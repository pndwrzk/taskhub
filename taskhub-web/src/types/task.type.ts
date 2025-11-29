export type CreateTaskRequest = {
  title: string;
  description?: string;
}

export type UpdateTaskRequest = {
  title: string;
  description?: string;
  status: number;
}

export type TaskResponse = {
  id: string; 
  title: string;
  description?: string;
  status: number;
  created_at: string; 
  updated_at: string;
}
