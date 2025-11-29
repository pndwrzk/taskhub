import axios, { AxiosError } from "axios";

import { BaseResponse } from "@/types/base-response.type";
import {
  LoginPayload,
  LoginData,
  RegisterPayload,
  RegisterData,
} from "@/types/auth.type";


const api = axios.create({
  baseURL: `${process.env.NEXT_PUBLIC_API_URL}/auth`,
  headers: { "Content-Type": "application/json" },
});


export async function login(
  payload: LoginPayload
): Promise<BaseResponse<LoginData>> {
  try {
    const res = await api.post("/login", payload);
    return res.data;
  } catch (err) {
   const error = err as AxiosError<{ message: string }>;
    throw new Error(error.response?.data?.message || "Register failed");
  }
}

export async function register(
  payload: RegisterPayload
): Promise<BaseResponse<RegisterData>> {
  try {
    const res = await api.post("/register", payload);
    return res.data;
  } catch (err) {
   const error = err as AxiosError<{ message: string }>;
    throw new Error(error.response?.data?.message || "Register failed");
  }
}
