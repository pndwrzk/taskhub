"use client";

import { useEffect } from "react";
import { useForm } from "react-hook-form";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

import { TaskResponse, UpdateTaskRequest } from "@/types/task.type";
import { useToast } from "@/components/ui/use-toast";

interface EditTaskModalProps {
  task: TaskResponse;
  isOpen: boolean;
  onClose: () => void;
  onUpdateTask: (payload: UpdateTaskRequest) => void;
}

export default function EditTaskModal({
  task,
  isOpen,
  onClose,
  onUpdateTask,
}: EditTaskModalProps) {
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm<UpdateTaskRequest>({
    defaultValues: task,
  });
  const toast = useToast();

  useEffect(() => {
    if (isOpen) reset(task);
  }, [task, isOpen, reset]);

  const onSubmit = (payload: UpdateTaskRequest) => {
    try {
      onUpdateTask(payload);
      toast({
        title: "Task updated",
        description: "Your changes slipped into place like it was meant to be.",
      });

    } catch {
      toast({
        title: "Update failed",
        description: "Something didn't align. Try tuning it again.",
      });

    } finally {
      onClose();
    }

  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Edit Task</DialogTitle>
          <DialogDescription>Modify task fields.</DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit(onSubmit)} className="grid gap-4 py-4">
          <div>
            <Label className="font-semibold mb-1">Title</Label>
            <Input {...register("title", { required: "Title is required" })} />
            {errors.title && (
              <p className="text-red-500 text-sm">{errors.title.message}</p>
            )}
          </div>

          <div>
            <Label className="font-semibold mb-1">Description</Label>
            <Input {...register("description")} />
            {errors.description && (
              <p className="text-red-500 text-sm">
                {errors.description.message}
              </p>
            )}
          </div>

          <div>
            <Label className="font-semibold mb-1">Status</Label>
            <select
              className="border rounded-md px-2 py-2 w-full"
              {...register("status", { required: true, valueAsNumber: true })}
            >
              <option value={0}>Todo</option>
              <option value={1}>In Progress</option>
              <option value={2}>Done</option>
            </select>
          </div>

          <DialogFooter>
            <Button type="submit" className="cursor-pointer">
              Update
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
