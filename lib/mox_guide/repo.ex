defmodule MoxGuide.Repo do
  use Ecto.Repo,
    otp_app: :mox_guide,
    adapter: Ecto.Adapters.Postgres
end
