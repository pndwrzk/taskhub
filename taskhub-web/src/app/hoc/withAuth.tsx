"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { isLoggedIn } from "@/lib/auth";

function withAuth<P extends {}>(WrappedComponent: React.ComponentType<P>) {
  const ComponentWithAuth: React.FC<P> = (props) => {
    const router = useRouter();
    const componentName = WrappedComponent.displayName || WrappedComponent.name || "";

    useEffect(() => {
      const loggedIn = isLoggedIn();


      const isGuestPage = /(login|register)/i.test(componentName);

      if (isGuestPage && loggedIn) {
        router.replace("/");
      } else if (!isGuestPage && !loggedIn) {
        router.replace("/login");
      }
    }, []);

    return <WrappedComponent {...props} />;
  };


  return ComponentWithAuth;
}

export default withAuth;
