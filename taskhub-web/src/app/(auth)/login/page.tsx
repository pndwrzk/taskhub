"use client";

import { useForm } from "react-hook-form";
import Link from "next/link";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { LoginData, LoginPayload } from "@/types/auth.type";
import { BaseResponse } from "@/types/base-response.type";
import { login } from "@/services/auth.service";
import { AxiosError } from "axios";
import { useToast } from "@/components/ui/use-toast";
import { saveTokenData } from "@/lib/axios";
import { useRouter } from "next/navigation";
import withAuth from "@/app/hoc/withAuth";

const Login =()=> {
  const toast = useToast();
  const router = useRouter();
  const {
    register: formRegister,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginPayload>();

  const onSubmit = async (data: LoginPayload) => {
    try {
      const result: BaseResponse<LoginData> = await login(data);

      saveTokenData({
        access_token: result.data.access_token,
        refresh_token: result.data.refresh_token,
        access_token_expires_at: result.data.access_token_expires_at,
        refresh_token_expires_at: result.data.refresh_token_expires_at,
      });

      toast({
        title: "Login successful",
        description: "You're in. Let's get things done.",
      });

      router.push("/");
    } catch (err) {
      const error = err as AxiosError<{ message: string }>;
      toast({
        title: "Login failed",
        description: "Email or password is incorrect.",
      });
    }
  };

  return (
    <div className="flex justify-center items-center h-screen bg-gray-50">
      <Card className="p-8 w-full max-w-md shadow-lg">
        <h2 className="text-2xl font-bold mb-6 text-center">Login</h2>

        <form className="flex flex-col gap-4" onSubmit={handleSubmit(onSubmit)}>
          <div className="flex flex-col space-y-1">
            <Label htmlFor="email" className="mb-1">
              Email
            </Label>
            <Input
              id="email"
              type="email"
              {...formRegister("email", { required: "Email is required" })}
              placeholder="your@email.com"
            />
            {errors.email && (
              <span className="text-red-500 text-sm">
                {errors.email.message}
              </span>
            )}
          </div>

          <div className="flex flex-col space-y-1">
            <Label htmlFor="password" className="mb-1">
              Password
            </Label>
            <Input
              id="password"
              type="password"
              {...formRegister("password", {
                required: "Password is required",
              })}
              placeholder="Password"
            />
            {errors.password && (
              <span className="text-red-500 text-sm">
                {errors.password.message}
              </span>
            )}
          </div>

          <Button type="submit" className="mt-4 cursor-pointer">
            Login
          </Button>
        </form>

        <p className="text-sm text-center text-gray-600 mt-2">
          Don't have an account?{" "}
          <Link href="/register" className="text-blue-500 underline">
            Register
          </Link>
        </p>
      </Card>
    </div>
  );
}

export default withAuth(Login);
