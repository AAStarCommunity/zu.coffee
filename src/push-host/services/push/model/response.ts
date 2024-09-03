interface ApiResponse<T> {
  code: number;
  error: boolean;
  data?: T;
  msg?: string;
}

export const createResponse = <T>(
  code: number,
  error: boolean,
  data?: T,
  msg?: string,
): ApiResponse<T> => {
  return {
    code,
    error,
    data,
    msg,
  };
};
