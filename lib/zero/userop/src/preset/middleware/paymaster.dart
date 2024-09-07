import 'package:HexagonWarrior/main.dart';
import 'package:http/http.dart';
import '../../../userop.dart' hide Client;
import '../../models/verifying_paymaster_result.dart';

UserOperationMiddlewareFn verifyingPaymaster(
  String paymasterRpc,
  Map<String, dynamic> context,
) {
  return (ctx) async {
    final paymasterAndData = "0x0101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000001010101010100000000000000000000000000000000000000000000000000000000000000000101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101";
    final signature = "0xa15569dd8f8324dbeabf8073fdec36d4b754f53ce5901e283c6de79af177dc94557fa3c9922cd7af2a96ca94402d35c39f266925ee6407aeb32b31d76978d4ba1c";

    // ctx.op.paymasterAndData = paymasterAndData;
    // ctx.op.signature = signature;
    ctx.op.verificationGasLimit = ctx.op.verificationGasLimit * BigInt.from(3);

    final params = [ctx.op.opToJson(), ctx.entryPoint.toString(), context];

    logger.i(params);

    final provider = BundlerJsonRpcProvider(paymasterRpc, Client());
    final rpcResponse = await provider.call(
      'pm_sponsorUserOperation',
      params,
    );

    final pm = VerifyingPaymasterResult.fromJson(
      rpcResponse.result as Map<String, dynamic>,
    );

    ctx.op.paymasterAndData = pm.paymasterAndData;
    ctx.op.preVerificationGas = BigInt.parse(pm.preVerificationGas) * BigInt.from(1.8);
    ctx.op.verificationGasLimit = BigInt.parse(pm.verificationGasLimit);
    ctx.op.callGasLimit = BigInt.parse(pm.callGasLimit);
  };
}
