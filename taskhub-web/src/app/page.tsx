"use client";

import LogoutButton from "@/components/ui/logout-button";
import TaskTable from "./components/task-table";
import withAuth from "./hoc/withAuth";


const Page =()=> {
  return (
    <div className="p-8">
      <div className="flex justify-between items-center mb-4">
        <h1 className="text-2xl font-bold text-center flex-1">TASK-HUB</h1>
        <LogoutButton />
      </div>

      <TaskTable />
    </div>
  );
}


export default withAuth(Page);