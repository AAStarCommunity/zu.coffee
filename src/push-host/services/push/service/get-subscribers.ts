const channelSubscribersMap: Map<string, string[]> = new Map([
  ["coupon", []],
  ["order", []],
]);

export const IsSubscribeExists = (channel: string): boolean => {
  return channelSubscribersMap.has(channel);
};

export const GetSubscribers = async (channel: string): Promise<string[]> => {
  if (channelSubscribersMap.has(channel)) {
    return channelSubscribersMap.get(channel) || [];
  } else {
    return [];
  }
};

export const GetChannels = async (): Promise<string[]> => {
  return Array.from(channelSubscribersMap.keys());
};

export const Subscribe = async (
  subscriber: string,
  channels: string[],
): Promise<void> => {
  for (const channel of channels) {
    if (!channelSubscribersMap.has(channel)) {
      channelSubscribersMap.set(channel, []);
    }
    const subscribers = channelSubscribersMap.get(channel) || [];
    subscribers.push(subscriber);
    channelSubscribersMap.set(channel, subscribers);
  }
};
