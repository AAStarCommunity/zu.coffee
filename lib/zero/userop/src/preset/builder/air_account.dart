import 'dart:typed_data';

import 'package:HexagonWarrior/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';
import 'package:web_socket_channel/io.dart';

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

  AirAccount(String rpcUrl, {IPresetBuilderOpts? opts, EthereumAddress? sender}) : super() {
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
      address: sender ?? EthereumAddress.fromHex(Addresses.AddressZero),
      client: web3client,
    );
  }
  //final b = "0x60806040523615605f5773ffffffffffffffffffffffffffffffffffffffff7f360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc54166000808092368280378136915af43d82803e15605b573d90f35b3d90fd5b73ffffffffffffffffffffffffffffffffffffffff7f360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc54166000808092368280378136915af43d82803e15605b573d90f3fea26469706673582212205da2750cd2b0cadfd354d8a1ca4752ed7f22214c8069d852f7dc6b8e9e5ee66964736f6c63430008150033";
  //final a = "0x60806040523615605f5773ffffffffffffffffffffffffffffffffffffffff7f360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc54166000808092368280378136915af43d82803e15605b573d90f35b3d90fd5b73ffffffffffffffffffffffffffffffffffffffff7f360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc54166000808092368280378136915af43d82803e15605b573d90f3fea26469706673582212205da2750cd2b0cadfd354d8a1ca4752ed7f22214c8069d852f7dc6b8e9e5ee66964736f6c63430008150033";
  /// Resolves the nonce and init code for the SimpleAccount contract creation.
  Future<void> resolveAccount(ctx) async {

    final nonce = await entryPoint.getNonce((key: nonceKey, sender: EthereumAddress.fromHex(ctx.op.sender)));
    ctx.op.nonce = nonce;
    ctx.op.initCode = nonce == BigInt.zero ? initCode : "0x";

    logger.i("nonce: ${nonce}, initCode: ${ctx.op.initCode}, account initCode: ${initCode}, ${nonce == BigInt.zero}");
    // ctx.op.nonce = await entryPoint.getNonce((key: nonceKey, sender: EthereumAddress.fromHex(ctx.op.sender)));
    // final code = results[1];
    // ctx.op.nonce = BigInt.zero;
    // ctx.op.initCode = initCode;
  }

  /// Initializes a AirAccount object and returns it.
  static Future<AirAccount> init(String aa, String initCode, String rpcUrl, String origin, {IPresetBuilderOpts? opts}) async {
    final senderAddress = EthereumAddress.fromHex(aa);
    final instance = AirAccount(rpcUrl, opts: opts, sender: senderAddress);

    instance.initCode = initCode;

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