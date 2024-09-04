import { BroadcastClient } from "@xmtp/broadcast-sdk";
import { BroadcastRequest } from "../model/broadcast";
import { Client } from "@xmtp/xmtp-js";
import { Wallet } from "ethers";
import { GetSubscribers } from "./get-subscribers";

const signer = Wallet.createRandom();

export const Broadcast = async (body: BroadcastRequest): Promise<string> => {
  const client = await Client.create(signer);
  setImmediate(async () =>{
    for (const channel in body.channels) {
      const subscribers = await GetSubscribers(channel);
      const broadcastClient = new BroadcastClient({
        client,
        addresses: subscribers,
        cachedCanMessageAddresses: subscribers,
      });
      broadcastClient.broadcast([body.message], {});
    }
  })
  return "Broadcasting message...";
};
