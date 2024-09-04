import 'package:HexagonWarrior/config/tx_network.dart';

String address_zero = "0x0000000000000000000000000000000000000000";

final eth_sepolia = TxNetwork(
    name: "Sepolia",
    rpc: "https://public.stackup.sh/api/v1/node/ethereum-sepolia",
    chainId: "11155111",
    blockExplorerURL: "https://sepolia.etherscan.io",
    contracts: TxContracts(
        usdt: "0x7169D38820dfd117C3FA1f22a697dBA58d90BA06",
        nft: "0xCEf599508abd274bab8F0D9D9149d9ceeD9a2A07",
        communityManager: address_zero, eventManager: address_zero),
    bundler: [
      BundlerConfig(
          provider: "stackup",
          url: "https://public.stackup.sh/api/v1/node/ethereum-sepolia"),
      BundlerConfig(
          provider: "pimlico",
          url: "https://api.pimlico.io/v2/11155111/rpc?apikey=7dc438e7-8de7-47f0-9d71-3372e57694ca"),
      BundlerConfig(
          provider: "biconomy",
          url: "https://bundler.biconomy.io/api/v2/11155111/nJPK7B3ru.dd7f7861-190d-41bd-af80-6877f74b8f44"),
    ],
    paymaster: [
      PaymasterConfig(
          provider: "stackup",
          url: "https://api.stackup.sh/v1/paymaster/e008121e92221cb49073b5bca65d434fbeb2162e73f42a9e3ea01d00b606fcba",
          option: IConfigOption(type: "payg")),
      PaymasterConfig(
        provider: "pimlico",
        url: "https://api.pimlico.io/v2/11155111/rpc?apikey=7dc438e7-8de7-47f0-9d71-3372e57694ca",
      ),
      PaymasterConfig(
          provider: "biconomy",
          url: "https://paymaster.biconomy.io/api/v1/11155111/sbA6OmcPO.016e1abd-0db6-4909-a806-175f617f1cb9",
          option: IConfigOption(
              mode: "SPONSORED",
              calculateGasLimits: true,
              expiryDuration: 300,
              sponsorshipInfo: SponsorshipInfo(webhookData: {}, smartAccountInfo: SmartAccountInfo(name: "BICONOMY", version: "2.0.0")))),
      PaymasterConfig(
          provider: "aastar",
          url: "https://paymaster.aastar.io/api/v1/paymaster/ethereum-sepolia?apiKey=fe6017a4-9e13-4750-ae69-a7568f633eb5",
          option: IConfigOption(strategyCode: "a__d7MwJ", version: "v0.6"))
    ]);


final op_sepolia = TxNetwork(name: "OP Sepolia",
    chainId: "11155420", blockExplorerURL: "https://sepolia-optimism.etherscan.io",
    contracts: TxContracts(
        usdt: "0x1927E2D716D7259d06006bFaF3dBFA22A12d6945",
        nft: "0x9194618d3695902a426bfacc9e2182d2cb6ad880",
        communityManager: "0x83924f7a84257c808a5af8a2650fec77f96ec1f0",
        eventManager: "0xd395e7293d2afeeeeae705d075b952c12315e510"),
    bundler: <BundlerConfig>[
      BundlerConfig(
          provider: "stackup",
          url: "https://api.stackup.sh/v1/node/7d139a21553146569a5bfb71478befa462bda69335e469cf25463ea6bc8b2366"
      )
    ], paymaster: <PaymasterConfig>[
      PaymasterConfig(
          provider: "stackup",
          url: "https://api.stackup.sh/v1/paymaster/7d139a21553146569a5bfb71478befa462bda69335e469cf25463ea6bc8b2366",
          option: IConfigOption(type: "payg"))
    ], rpc: "https://endpoints.omniatech.io/v1/op/sepolia/public");


final arb_sepolia = TxNetwork(name: "Arbitrum Sepolia",
    chainId: "421614",
    blockExplorerURL: "https://sepolia-explorer.arbitrum.io", contracts: TxContracts(
      usdt: "0x1927E2D716D7259d06006bFaF3dBFA22A12d6945",
      nft: address_zero,
      communityManager: address_zero,
      eventManager: address_zero
    ), bundler: <BundlerConfig>[
      BundlerConfig(provider: "stackup", url: "https://public.stackup.sh/api/v1/node/arbitrum-sepolia")
    ], paymaster: <PaymasterConfig>[
      PaymasterConfig(provider: "stackup", url: "https://api.stackup.sh/v1/paymaster/5309e1878a24d01f3998beb56b2357443f72d127ee224eab072bd2378168da01", option: IConfigOption(
        type: "payg"
      ))
    ], rpc: "https://public.stackup.sh/api/v1/node/arbitrum-sepolia");



final txNetworks = <String, TxNetwork>{
  eth_sepolia.chainId : eth_sepolia,
  op_sepolia.chainId : op_sepolia,
  arb_sepolia.chainId : arb_sepolia
};
