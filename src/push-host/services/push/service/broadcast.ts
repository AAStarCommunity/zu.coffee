import { BroadcastRequest } from "../model/broadcast";

export const Broadcast = async (body: BroadcastRequest): Promise<string> => {
  return "Broadcasting message...";
};
