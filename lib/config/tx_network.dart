import 'package:HexagonWarrior/translations/en.dart';


const entryPointAddress = "0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789";
const factoryAddress = "0x9406Cc6185a346906296840746125a0E44976454";

class TxNetwork {
 final String name;
 final String chainId;
 final String rpc;
 final String blockExplorerURL;
 final TxContracts contracts;
 final List<BundlerConfig> bundler;
 final List<PaymasterConfig> paymaster;

 TxNetwork({required this.name, required this.chainId, required this.blockExplorerURL, required this.contracts, required this.bundler, required this.paymaster, required this.rpc});
}

class TxContracts {
  final String usdt;
  final String nft;
  final String communityManager;

  TxContracts({required this.usdt, required this.nft, required this.communityManager});
}

class BundlerConfig extends IConfig{
  BundlerConfig({required String provider, required String url, IConfigOption? option}) : super(provider: provider, url: url, option: option, entryPoint: null);
}

class PaymasterConfig extends IConfig{
  PaymasterConfig({required String provider, required String url, IConfigOption? option, String? entryPoint}) : super(provider: provider, url: url, option: option, entryPoint: entryPoint);
}

class IConfig {
  final String provider;
  final String url;
  final IConfigOption? option;
  final String? entryPoint;

  IConfig({required this.provider, required this.url, this.option, this.entryPoint});
}

class IConfigOption {
  final String? mode;
  final bool? calculateGasLimits;
  final int? expiryDuration;
  final SponsorshipInfo? sponsorshipInfo;
  final String? type;
  final String? strategyCode;
  final String? version;

  IConfigOption({
    this.mode,
    this.calculateGasLimits,
    this.expiryDuration,
    this.sponsorshipInfo,
    this.type,
    this.strategyCode,
    this.version
  });
}

class SponsorshipInfo {
  final Map<String, dynamic> webhookData;
  final SmartAccountInfo smartAccountInfo;

  SponsorshipInfo({
    required this.webhookData,
    required this.smartAccountInfo,
  });
}

class SmartAccountInfo {
  final String name;
  final String version;

  SmartAccountInfo({
    required this.name,
    required this.version,
  });
}
