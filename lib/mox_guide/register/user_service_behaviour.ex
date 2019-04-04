defmodule MoxGuideWeb.UserServiceBehaviour do
  @type user :: map
  @type error :: :invalid_params

  @callback register_user(user_params :: map) :: {:ok, user} | {:error, error}
end
