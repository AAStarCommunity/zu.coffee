import 'dart:convert';
import 'dart:io';

import 'package:HexagonWarrior/config/tx_configs.dart';
import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/utils/validate_util.dart';
import 'package:HexagonWarrior/zero/userop/src/preset/builder/air_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../userop/userop.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:web3dart/crypto.dart';assets/contracts/TetherToken.json

Future<void> mint(String aaAddress, String functionName, String tokenAbiPath, String initCode, String origin, {String? amountStr}) async {
  final contractName = tokenAbiPath.substring(tokenAbiPath.lastIndexOf("/") + 1, tokenAbiPath.lastIndexOf("."));
  final tokenAddress = EthereumAddress.fromHex(op_sepolia.contracts.usdt);
  final targetAddress = EthereumAddress.fromHex(aaAddress);
  final amount = isNotNull(amountStr) ? BigInt.parse(amountStr!) : BigInt.zero;

  final bundlerRPC = op_sepolia.bundler.first.url;

  final paymasterMiddleware = verifyingPaymaster(
     op_sepolia.paymaster.first.url,
     op_sepolia.paymaster.first.option!.toJson(),
  );

  final IPresetBuilderOpts opts = IPresetBuilderOpts()
  ..paymasterMiddleware = paymasterMiddleware;

  final airAccount = await AirAccount.init(
    aaAddress,
    initCode,
    bundlerRPC,
    origin,
    tokenAddress,
    opts: opts,
  );

  final IClientOpts iClientOpts = IClientOpts()
    ..overrideBundlerRpc = bundlerRPC;

  final client = await Client.init(bundlerRPC, opts: iClientOpts);

  final sendOpts = ISendUserOperationOpts()
    ..dryRun = true
    ..onBuild = (IUserOperation ctx) async {
      debugPrint("Signed UserOperation：" + ctx.opToJson().toString());
    };

  String abiStr = await rootBundle.loadString(tokenAbiPath);
  final abiObj = jsonDecode(abiStr);

  final call = Call(
    to: tokenAddress,
    value: BigInt.zero,
    data: ContractsHelper.encodedDataForContractCall(
      contractName,
      tokenAddress.toString(),
      functionName,//_mint, mint
      [
        targetAddress,
        amount,
      ],
      include0x: true,
      jsonInterface: jsonEncode(abiObj['abi'])
    ),
  );
  final userOp = await airAccount.execute(call);

  final res = await client.sendUserOperation(
    userOp,
    opts: sendOpts,
  );
  debugPrint('UserOpHash: ${res.userOpHash}');

  debugPrint('Waiting for transaction...');
  final ev = await res.wait();
  debugPrint('Transaction hash: ${ev?.transactionHash}');

}