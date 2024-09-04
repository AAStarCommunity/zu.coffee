import 'dart:typed_data';

import 'package:HexagonWarrior/main.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';

import '../../../userop.dart';
import '../../typechain/SimpleAccount.g.dart' as simple_account_impl;
import '../../typechain/index.dart';

extension E on String {
  String lastChars(int n) => substring(length - n);
}

/// A simple account class that extends the `UserOperationBuilder`.
/// This class provides methods for interacting with an 4337 simple account.
class AirAccount extends UserOperationBuilder {

  /// The EntryPoint object to interact with the ERC4337 EntryPoint contract.
  late final EntryPoint entryPoint;

  /// The factory instance to create simple account contracts.
  late final SimpleAccountFactory simpleAccountFactory;

  /// The initialization code for the contract.
  late String initCode;

  /// The nonce key to use the Semi-Abstract-Nonce mechanism.
  late final BigInt nonceKey;

  /// The proxy instance to interact with the SimpleAccount contract.
  late simple_account_impl.SimpleAccount proxy;

  AirAccount(String rpcUrl, {IPresetBuilderOpts? opts}) : super() {
    final web3client = Web3Client.custom(BundlerJsonRpcProvider(
      rpcUrl,
      http.Client(),
    ).setBundlerRpc(
      opts?.overrideBundlerRpc,
    ));
    entryPoint = EntryPoint(
      address: opts?.entryPoint ?? EthereumAddress.fromHex(ERC4337.ENTRY_POINT),
      client: web3client,
    );
    simpleAccountFactory = SimpleAccountFactory(
      address: opts?.factoryAddress ??
          EthereumAddress.fromHex(ERC4337.SIMPLE_ACCOUNT_FACTORY),
      client: web3client,
    );
    initCode = '0x';
    nonceKey = opts?.nonceKey ?? BigInt.zero;
    proxy = simple_account_impl.SimpleAccount(
      address: EthereumAddress.fromHex(Addresses.AddressZero),
      client: web3client,
    );
  }

  /// Resolves the nonce and init code for the SimpleAccount contract creation.
  Future<void> resolveAccount(ctx) async {
    final results = await Future.wait([
      entryPoint.getNonce(
        (
        key: nonceKey,
        sender: EthereumAddress.fromHex(ctx.op.sender),
        ),
      ),
      // entryPoint.client.makeRPCCall<String>('eth_getCode', [
      //   ctx.op.sender,
      //   'latest',
      // ])
    ]);
    ctx.op.nonce = results[0];
    // final code = results[1];
    ctx.op.initCode = initCode;
  }

  /// Initializes a AirAccount object and returns it.
  static Future<AirAccount> init(String aa, String initCode, String rpcUrl, String origin, EthereumAddress smartContractAddress, {IPresetBuilderOpts? opts}) async {
    final instance = AirAccount(rpcUrl, opts: opts);

    instance.initCode = initCode;

    final senderAddress = EthereumAddress.fromHex(aa);
    instance.proxy = simple_account_impl.SimpleAccount(
      address: smartContractAddress,
      client: instance.simpleAccountFactory.client,
    );
    logger.i("${instance.proxy.self.address.toString()}");
    // final sender = entrypoint.callStatic.getsenddaddr(initCode)
    final baseInstance = instance.useDefaults({
      'sender': aa,//instance.proxy.self.address.toString(),
    }).useMiddleware(instance.resolveAccount).useMiddleware(getGasPrice(
      instance.simpleAccountFactory.client,
    ));

    final withPM = opts?.paymasterMiddleware != null
        ? baseInstance.useMiddleware(
        opts?.paymasterMiddleware as UserOperationMiddlewareFn)
        : baseInstance.useMiddleware(
      estimateUserOperationGas(
        instance.simpleAccountFactory.client,
      ),
    );

    return withPM.useMiddleware(signUserOpHashUseSignature(origin))
    as AirAccount;
  }

  /// Executes a transaction on the network.
  Future<IUserOperationBuilder> execute(
      Call call,
      ) async {
    return setCallData(
      bytesToHex(
        proxy.self.function('execute').encodeCall(
          [
            call.to,
            call.value,
            call.data,
          ],
        ),
        include0x: true,
      ),
    );
  }

  /// Executes a batch transaction on the network.
  Future<IUserOperationBuilder> executeBatch(
      List<Call> calls,
      ) async {
    return setCallData(
      bytesToHex(
        proxy.self.function('executeBatch').encodeCall(
          [
            calls.map((e) => e.to).toList(),
            calls.map((e) => e.data).toList(),
          ],
        ),
        include0x: true,
      ),
    );
  }
}