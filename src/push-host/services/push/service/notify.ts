import { Client } from "@xmtp/xmtp-js";
import { Wallet } from "ethers";

const signer = Wallet.createRandom();

export const Notify = async (
  message: string,
  address: string,
): Promise<void> => {
  const signer = Wallet.createRandom();
  const xmtp = await Client.create(signer, { env: "dev" });
  const conversation = await xmtp.conversations.newConversation(address);
  await conversation.send(message);
};
