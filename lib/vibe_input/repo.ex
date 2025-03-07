defmodule VibeInput.Repo do
  use Ecto.Repo,
    otp_app: :vibe_input,
    adapter: Ecto.Adapters.Postgres
end
