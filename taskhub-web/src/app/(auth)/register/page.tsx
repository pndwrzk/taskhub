"use client";

import { useForm } from "react-hook-form";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";

import { useToast } from "@/components/ui/use-toast";
import { register as registerApi } from "@/services/auth.service";
import { RegisterPayload } from "@/types/auth.type";

import { AxiosError } from "axios";
import withAuth from "@/app/hoc/withAuth";

type RegisterFormValues = RegisterPayload & { confirmPassword: string };

const  Register =()=> {
  const toast = useToast();
  const router = useRouter();

  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
  } = useForm<RegisterFormValues>();

  const password = watch("password");

  const onSubmit = async (data: RegisterFormValues) => {
    try {
      await registerApi({
        email: data.email,
        password: data.password,
      });
      toast({
        title: "Account created",
        description: "Your journey begins. Step in with purpose.",
      });

      router.push("/login");
    } catch (err) {
      const error = err as AxiosError<{ message: string }>;
      toast({
        title: "Registration failed",
        description: error.message,
      });
    }
  };

  return (
    <div className="flex justify-center items-center h-screen bg-gray-50">
      <Card className="p-8 w-full max-w-md shadow-lg">
        <h2 className="text-2xl font-bold mb-6 text-center">Register</h2>

        <form onSubmit={handleSubmit(onSubmit)} className="flex flex-col gap-4">
          <div className="flex flex-col space-y-1">
            <Label htmlFor="email">Email</Label>
            <Input
              id="email"
              type="email"
              {...register("email", { required: "Email is required" })}
              placeholder="your@email.com"
            />
            {errors.email && (
              <span className="text-red-500 text-sm">
                {errors.email.message}
              </span>
            )}
          </div>

          <div className="flex flex-col space-y-1">
            <Label htmlFor="password">Password</Label>
            <Input
              id="password"
              type="password"
              {...register("password", { required: "Password is required" })}
              placeholder="Password"
            />
            {errors.password && (
              <span className="text-red-500 text-sm">
                {errors.password.message}
              </span>
            )}
          </div>

          <div className="flex flex-col space-y-1">
            <Label htmlFor="confirmPassword">Confirm Password</Label>
            <Input
              id="confirmPassword"
              type="password"
              {...register("confirmPassword", {
                required: "Confirm password is required",
                validate: (value) =>
                  value === password || "Passwords do not match",
              })}
              placeholder="Confirm Password"
            />
            {errors.confirmPassword && (
              <span className="text-red-500 text-sm">
                {errors.confirmPassword.message}
              </span>
            )}
          </div>

          <Button type="submit" className="mt-4 cursor-pointer">
            Register
          </Button>
        </form>

        <p className="text-sm text-center text-gray-600 mt-2">
          Already have an account?{" "}
          <Link href="/login" className="text-blue-500 underline">
            Login
          </Link>
        </p>
      </Card>
    </div>
  );
}

export default withAuth(Register);
