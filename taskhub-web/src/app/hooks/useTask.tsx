"use client";

import { useState, useEffect, useCallback } from "react";
import {
  getTasks,
  createTask,
  updateTask,
  deleteTask,
} from "@/services/task.service";
import {
  TaskResponse,
  CreateTaskRequest,
  UpdateTaskRequest,
} from "@/types/task.type";
import { BaseResponse } from "@/types/base-response.type";
import { AxiosError } from "axios";

export function useTask() {
  const [tasks, setTasks] = useState<TaskResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const safeError = (err: unknown) => {
    const e = err as AxiosError<{ message: string }>;
    return e.response?.data?.message || e.message || "Unknown error";
  };

  const fetchTasks = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const res: BaseResponse<TaskResponse[]> = await getTasks();
      setTasks(res.data);
    } catch (err) {
      setError(safeError(err));
    } finally {
      setLoading(false);
    }
  }, []);

  const addTask = async (payload: CreateTaskRequest) => {
    setError(null);
    try {
      const res: BaseResponse<TaskResponse> = await createTask(payload);
      fetchTasks();
      return res.data;
    } catch (err) {
      setError(safeError(err));
    }
  };

  const editTask = async (id: string, payload: UpdateTaskRequest) => {
    setError(null);
    try {
      const res: BaseResponse<TaskResponse> = await updateTask(id, payload);
      fetchTasks();
      return res.data;
    } catch (err) {
      setError(safeError(err));
    }
  };

  const removeTask = async (id: string) => {
    setError(null);
    try {
      await deleteTask(id);
      fetchTasks();
    } catch (err) {
      setError(safeError(err));
    }
  };

  useEffect(() => {
    fetchTasks();
  }, [fetchTasks]);

  return { tasks, loading, error, fetchTasks, addTask, editTask, removeTask };
}
