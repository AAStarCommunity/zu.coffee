import 'dart:convert';
import 'dart:io';

import 'package:HexagonWarrior/config/tx_configs.dart';
import 'package:HexagonWarrior/main.dart';
import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/utils/validate_util.dart';
import 'package:HexagonWarrior/zero/userop/src/preset/builder/air_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/v4.dart';
import 'package:web3dart/crypto.dart';
import 'dart:math' as math;
import '../../userop/userop.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:web3dart/crypto.dart';assets/contracts/TetherToken.json

Future<String?> getBalance(String tokenAbiPath, String aaAddress) async{
  final contractName = tokenAbiPath.substring(tokenAbiPath.lastIndexOf("/") + 1, tokenAbiPath.lastIndexOf("."));
  String abiStr = await rootBundle.loadString(tokenAbiPath);
  final abiObj = jsonDecode(abiStr);
  final contractAddress = op_sepolia.contracts.usdt;
  final web3Client = Web3Client.custom(BundlerJsonRpcProvider(op_sepolia.rpc, http.Client()));
  final response = await ContractsHelper.readFromContract(web3Client, contractName, contractAddress, "balanceOf", [EthereumAddress.fromHex(aaAddress)], jsonInterface: jsonEncode(abiObj['abi']));
  return formatUnits(response.first as BigInt, 6);
}

Future<String?> mint(String aaAddress, String functionName, String tokenAbiPath, String initCode, String origin, {int? amount, String? receiver}) async {
  final contractName = tokenAbiPath.substring(tokenAbiPath.lastIndexOf("/") + 1, tokenAbiPath.lastIndexOf("."));
  final tokenAddress = EthereumAddress.fromHex(op_sepolia.contracts.usdt);
  final targetAddress = EthereumAddress.fromHex(receiver ?? aaAddress);
  final etherAmount = parseUnits("${amount ?? 0}", 6);

  logger.i("amount : ${etherAmount}");

  final bundlerRPC = op_sepolia.bundler.first.url;
  final rpcUrl = op_sepolia.rpc;

  final paymasterMiddleware = verifyingPaymaster(
     op_sepolia.paymaster.first.url,
     op_sepolia.paymaster.first.option!.toJson(),
  );

  final IPresetBuilderOpts opts = IPresetBuilderOpts()
  //..nonceKey = BigInt.from(hexToDartInt(UuidV4().generate().replaceAll("-", "").substring(0, 6)))
  ..paymasterMiddleware = paymasterMiddleware;
  //..overrideBundlerRpc = bundlerRPC;

  final airAccount = await AirAccount.init(
    aaAddress,
    initCode,
    rpcUrl,
    origin,
    tokenAddress,
    opts: opts,
  );

  final client = await Client.init(bundlerRPC);

  final sendOpts = ISendUserOperationOpts()
    ..dryRun = false
    ..onBuild = (IUserOperation ctx) async {
      logger.i("Signed UserOperation：" + ctx.toJson().toString());
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
        etherAmount,
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
  return await getBalance(tokenAbiPath, aaAddress);
}

String formatUnits(BigInt value, int decimals) {
  // 将 BigInt 转换为 double 以处理小数
  double base = math.pow(10, decimals).toDouble();
  double formattedValue = value.toDouble() / base;

  // 转换为字符串，并确保显示固定的小数位数
  return formattedValue.toStringAsFixed(decimals);
}

BigInt parseUnits(String value, int decimals) {
  // 将输入值转换为 double，并乘以 10^decimals
  double base = math.pow(10, decimals).toDouble();
  double parsedValue = double.parse(value) * base;

  // 返回 BigInt 表示的最小单位值
  return BigInt.from(parsedValue);
}