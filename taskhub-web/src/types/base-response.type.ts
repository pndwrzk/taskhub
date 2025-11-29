export type BaseResponse<T = unknown> = {
  status: string;
  message: string;
  data: T;
};
