"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogTrigger,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { CreateTaskRequest } from "@/types/task.type";
import { useToast } from "@/components/ui/use-toast";

interface AddTaskModalProps {
  onAddTask: (payload: CreateTaskRequest) => void;
}

export default function AddTaskModal({ onAddTask }: AddTaskModalProps) {
  const [isOpen, setIsOpen] = useState(false);
  const toast = useToast();

  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm<CreateTaskRequest>({
    defaultValues: {
      title: "",
      description: "",
    },
  });

  const onSubmit = (payload: CreateTaskRequest) => {
    try {
      onAddTask(payload);
      toast({
  title: "Task created",
  description: "Your task is now part of the journey.",
});

    } catch {
     toast({
  title: "Creation failed",
  description: "Something went off track. Try again.",
});

    } finally {
      reset();
      setIsOpen(false);
    }

  };

  return (
    <Dialog open={isOpen} onOpenChange={setIsOpen}>
      <DialogTrigger asChild>
        <Button className="cursor-pointer">Add Task</Button>
      </DialogTrigger>

      <DialogContent>
        <DialogHeader>
          <DialogTitle>Add New Task</DialogTitle>
          <DialogDescription>Create a new task.</DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit(onSubmit)} className="grid gap-4 py-4">
          <div>
            <Label className="font-semibold mb-1">Title</Label>
            <Input
              {...register("title", { required: "Title is required" })}
            />
            {errors.title && (
              <p className="text-red-500 text-xs">{errors.title.message}</p>
            )}
          </div>

          <div>
            <Label className="font-semibold mb-1">Description</Label>
            <Input
              {...register("description")}
            />
            {errors.description && (
              <p className="text-red-500 text-xs">
                {errors.description.message}
              </p>
            )}
          </div>

          <DialogFooter>
            <Button type="submit" className="cursor-pointer">
              Add
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
