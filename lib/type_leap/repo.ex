defmodule TypeLeap.Repo do
  use Ecto.Repo,
    otp_app: :type_leap,
    adapter: Ecto.Adapters.Postgres
end
