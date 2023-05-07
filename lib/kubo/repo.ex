defmodule Kubo.Repo do
  use Ecto.Repo,
    otp_app: :kubo,
    adapter: Ecto.Adapters.Postgres
end
