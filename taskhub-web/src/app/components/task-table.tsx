"use client";

import { useState } from "react";
import { Card } from "@/components/ui/card";
import {
  Table,
  TableHeader,
  TableBody,
  TableRow,
  TableHead,
  TableCell,
} from "@/components/ui/table";
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuGroup,
  DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import { MoreHorizontalIcon } from "lucide-react";

import AddTaskModal from "./add-task-modal";
import EditTaskModal from "./edit-task-modal";
import ConfirmationDialog from "@/components/ui/confirmation-dialog";
import { Button } from "@/components/ui/button";

import { useTask } from "@/app/hooks/useTask";
import { TaskResponse } from "@/types/task.type";
import { useToast } from "@/components/ui/use-toast";

const statusMap = ["Todo", "In Progress", "Done"];
const statusColor = ["bg-gray-600", "bg-blue-600", "bg-green-700"];

export default function TaskTable() {
  const toast = useToast();
  const { tasks, loading, addTask, editTask, removeTask } = useTask();

  const [editingTask, setEditingTask] = useState<TaskResponse | null>(null);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [deletingTask, setDeletingTask] = useState<TaskResponse | null>(null);

  return (
    <Card className="shadow-lg border border-gray-100 p-4">
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-lg font-semibold">Task List</h2>
        <AddTaskModal onAddTask={addTask} />
      </div>

      <Table className="min-w-full divide-y divide-gray-200 border rounded">
        <TableHeader className="bg-gray-50">
          <TableRow>
            <TableHead className="font-bold">Title</TableHead>
            <TableHead className="font-bold">Description</TableHead>
            <TableHead className="font-bold">Status</TableHead>
            <TableHead className="font-bold">Action</TableHead>
          </TableRow>
        </TableHeader>

        <TableBody>
          {loading ? (
            <TableRow>
              <TableCell colSpan={4} className="py-4 text-center text-gray-500">
                Loading...
              </TableCell>
            </TableRow>
          ) : (
            tasks?.map((task) => (
              <TableRow key={task.id} className="hover:bg-gray-50">
                <TableCell>{task.title}</TableCell>
                <TableCell>{task.description}</TableCell>

                <TableCell>
                  <span
                    className={`px-2 py-1 rounded-sm min-w-[100px] text-white text-xs ${statusColor[task.status]
                      }`}
                  >
                    {statusMap[task.status]}
                  </span>
                </TableCell>

                <TableCell>
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button variant="link" size="icon" className="cursor-pointer">
                        <MoreHorizontalIcon className="h-4 w-4" />
                      </Button>
                    </DropdownMenuTrigger>

                    <DropdownMenuContent align="end" className="w-48">
                      <DropdownMenuGroup>
                        <DropdownMenuItem
                          className="cursor-pointer"
                          onClick={() => {
                            setEditingTask(task);
                            setIsEditOpen(true);
                          }}
                        >
                          Edit
                        </DropdownMenuItem>

                        <DropdownMenuSeparator />

                        <DropdownMenuItem
                          className="cursor-pointer"
                          onClick={() => setDeletingTask(task)}
                        >
                          Delete
                        </DropdownMenuItem>
                      </DropdownMenuGroup>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </TableCell>
              </TableRow>
            ))
          )}
        </TableBody>
      </Table>

      {editingTask && (
        <EditTaskModal
          isOpen={isEditOpen}
          task={editingTask}
          onClose={() => setIsEditOpen(false)}
          onUpdateTask={(payload) => editTask(editingTask.id, payload)}
        />
      )}

      {deletingTask && (
        <ConfirmationDialog
          open={!!deletingTask}
          onOpenChange={() => setDeletingTask(null)}
          title="Delete Task"
          description={`Are you sure you want to delete "${deletingTask.title}"?`}
          confirmLabel="Delete"
          cancelLabel="Cancel"
          onConfirm={() => {
            removeTask(deletingTask.id);
            toast({
              title: "Task deleted successfully",
            });

            setDeletingTask(null);

          }}
        />
      )}
    </Card>
  );
}
