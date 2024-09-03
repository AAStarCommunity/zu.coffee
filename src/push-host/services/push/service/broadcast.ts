import { BroadcastClient } from "@xmtp/broadcast-sdk";
import { BroadcastRequest } from "../model/broadcast";
import { Client } from "@xmtp/xmtp-js";
import { Wallet } from "ethers";

const signer = Wallet.createRandom();

export const Broadcast = async (body: BroadcastRequest): Promise<string> => {
  const client = await Client.create(signer);
  const broadcastClient = new BroadcastClient({
    client,
    addresses: ["0x1234", "0x5678"],
    cachedCanMessageAddresses: ["0x1234"],
  })
  broadcastClient.broadcast(['Hello!'], {})
  return "Broadcasting message...";
};
