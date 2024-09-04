const channelSubscribersMap: Map<string, string[]> = new Map([
  ["coupon", ["subscriber1", "subscriber2"]],
  ["order", ["subscriber3", "subscriber4"]],
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
