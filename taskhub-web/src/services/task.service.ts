import { AxiosError } from "axios";
import {
  CreateTaskRequest,
  UpdateTaskRequest,
  TaskResponse,
} from "@/types/task.type";
import { BaseResponse } from "@/types/base-response.type";
import { axiosConfig } from "@/lib/axios";

function api() {
  return axiosConfig();
}

export async function getTasks(): Promise<BaseResponse<TaskResponse[]>> {
  try {
    const res = await api().get("/tasks");
    return res.data;
  } catch (err) {
    const error = err as AxiosError<{ message: string }>;
    throw new Error(error.response?.data?.message || "Failed to fetch tasks");
  }
}

export async function createTask(
  payload: CreateTaskRequest
): Promise<BaseResponse<TaskResponse>> {
  try {
    const res = await api().post("/tasks", payload);
    return res.data;
  } catch (err) {
    const error = err as AxiosError<{ message: string }>;
    throw new Error(error.response?.data?.message || "Failed to create task");
  }
}

export async function updateTask(
  id: string,
  payload: UpdateTaskRequest
): Promise<BaseResponse<TaskResponse>> {
  try {
    const res = await api().put(`/tasks/${id}`, payload);
    return res.data;
  } catch (err) {
    const error = err as AxiosError<{ message: string }>;
    throw new Error(error.response?.data?.message || "Failed to update task");
  }
}

export async function deleteTask(id: string): Promise<BaseResponse<null>> {
  try {
    const res = await api().delete(`/tasks/${id}`);
    return res.data;
  } catch (err) {
    const error = err as AxiosError<{ message: string }>;
    throw new Error(error.response?.data?.message || "Failed to delete task");
  }
}
