"use client";

import { useRouter } from "next/navigation";

import { ClearToken } from "@/lib/axios";

export default function LogoutButton() {
  const router = useRouter();

  const handleLogout = () => {
    ClearToken();
    router.push("/login");
  };

  return (
    <button
      onClick={handleLogout}
      className="px-4 py-1 cursor-pointer bg-red-800 text-white rounded hover:bg-red-700"
    >
      Logout
    </button>
  );
}
