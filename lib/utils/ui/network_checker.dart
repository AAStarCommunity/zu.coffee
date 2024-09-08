
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;


enum ConnectionType { http, rpc, paymaster, bundler }
enum ConnectionStatus { success, failure }

class NetworkChecker {
  final String address;
  final int port;
  final Duration checkInterval;
  final Duration timeout;
  final ConnectionType type;

  NetworkChecker({
    required this.address,
    this.port = 80,
    this.checkInterval = const Duration(minutes: 5),
    this.timeout = const Duration(seconds: 10),
    this.type = ConnectionType.http,
  });

  Stream<ConnectionStatus> checkPeriodically() async* {
    while (true) {
      yield await checkConnection();
      await Future.delayed(checkInterval);
    }
  }

  Future<ConnectionStatus> checkConnection() async {
    try {
      bool isConnected = false;

      if (type == ConnectionType.http) {
        isConnected = await _checkHttp();
      } else {
        isConnected = await _checkSocket((status){

        });
      }
      return isConnected ? ConnectionStatus.success : ConnectionStatus.failure;
    } catch (e) {
      print('连接检查出错: ${e.toString()}');
      return ConnectionStatus.failure;
    }
  }

  Future<bool> _checkHttp() async {
    final uri = Uri.parse(address.startsWith('http') ? address : 'http://$address');
    final response = await http.get(uri).timeout(timeout);
    return response.statusCode == 200;
  }

  Future<bool> _checkSocket(ValueChanged<int> onChanged) async {
    final wsUrl = Uri.parse(address.replaceAll("https", "wss"));
    final socket = WebSocketChannel.connect(wsUrl);
    await socket.ready;
    socket.stream.listen((e){
      onChanged.call(1);
      debugPrint("onData: ${e.toString()}");
    }, onError: (e){
      onChanged.call(0);
      debugPrint("onError: ${e.toString()}");
    }, onDone: (){
      debugPrint("onDone}");
    });
    return true;
  }

  // Future<bool> checkConnection() async {
  //   try {
  //     final client = Web3Client(address, http.Client());
  //
  //     // 创建一个模拟的UserOperation
  //     final userOp = {
  //       'sender': '0x1234567890123456789012345678901234567890',
  //       'nonce': '0x0',
  //       'initCode': '0x',
  //       'callData': '0x',
  //       'callGasLimit': '0x5000',
  //       'verificationGasLimit': '0x5000',
  //       'preVerificationGas': '0x5000',
  //       'maxFeePerGas': '0x1',
  //       'maxPriorityFeePerGas': '0x1',
  //       'paymasterAndData': '0x',
  //       'signature': '0x'
  //     };
  //
  //     // 尝试调用paymaster特定的方法,例如pm_sponsorUserOperation
  //     final sponsorResult = await client.call(
  //       contract: DeployedContract(ContractAbi.fromJson([], 'DummyContract'), Addresses.AddressZero.toString()),
  //       function: ContractFunction('pm_sponsorUserOperation', []),
  //       params: [userOp, '0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789'],
  //     ).timeout(timeout);
  //
  //     await client.dispose();
  //
  //     // 如果能够成功获取sponsorResult,则认为连接成功
  //     return sponsorResult != null;
  //   } catch (e) {
  //     print('Paymaster连接检查出错: $e');
  //     return false;
  //   }
  // }
}

class NetworkCheckContainer extends StatefulWidget {

  final Color color;
  final String network;
  final ConnectionType type;

  NetworkCheckContainer({super.key, required this.network, required this.type, this.color = Colors.red});

  @override
  _NetworkCheckContainerState createState() => _NetworkCheckContainerState();
}

class _NetworkCheckContainerState extends State<NetworkCheckContainer> {

  NetworkChecker? _checker;
  StreamSubscription? _subscription;
  bool _networkError = false;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _startChecking() {
    _subscription?.cancel();
    _checker = NetworkChecker(
      address: widget.network,
      checkInterval: Duration(seconds: 30), // 每30秒检查一次
      timeout: Duration(seconds: 5), // 5秒超时
      type: widget.type, // 或 ConnectionType.socket
    );
    _subscription = _checker!.checkPeriodically().listen((status) {
      print('连接状态: ${status == ConnectionStatus.success ? "成功" : "失败"}');
      if(mounted) {
        setState(() {
          _networkError = status != ConnectionStatus.success;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_){
      _startChecking();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: _networkError ? 20 : 0, color: widget.color, child: Text("${widget.network} is disconnected", style: TextStyle(color: Colors.white, fontSize: 10)));
  }
}