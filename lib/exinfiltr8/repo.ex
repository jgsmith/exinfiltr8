defmodule Exinfiltr8.Repo do
  use Ecto.Repo,
    otp_app: :exinfiltr8,
    adapter: Ecto.Adapters.Postgres
end
