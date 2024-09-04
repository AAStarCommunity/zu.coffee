import 'package:web3dart/web3dart.dart';

import '../../models/index.dart';
import '../../types.dart';

UserOperationMiddlewareFn estimateUserOperationGas(
  Web3Client client,
) {
  return (ctx) async {
    final rpcResponse = await client.makeRPCCall<Map<String, dynamic>>(
      'eth_estimateUserOperationGas',
      [ctx.op.opToJson(), ctx.entryPoint.toString()],
    );
    final est = GasEstimate.fromJson(
      rpcResponse,
    );
    ctx.op.preVerificationGas = BigInt.parse(est.preVerificationGas);
    ctx.op.verificationGasLimit = est.verificationGasLimit != null
        ? BigInt.parse(est.verificationGasLimit!)
        : BigInt.parse(est.verificationGas);
    ctx.op.callGasLimit = BigInt.parse(est.callGasLimit);
  };
}
