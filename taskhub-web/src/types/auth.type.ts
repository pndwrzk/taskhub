export type LoginPayload = {
  email: string;
  password: string;
  created_at: string;
};

export type RegisterPayload = {
  email: string;
  password: string;
};

export type LoginData = {
  access_token: string;
  access_token_expires_at: number;
  refresh_token: string;
  refresh_token_expires_at: number;
  token_type: string;
  user: {
    id: string;
    email: string;
  };
};

export type RefreshData = {
  access_token: string;
  access_token_expires_at: number;
  refresh_token: string;
  refresh_token_expires_at: number;
  token_type: string;
};

export type RegisterData = {
  id: string;
  email: string;
};
