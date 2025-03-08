defmodule TypeLeap.Repo.Migrations.CreateVibes do
  use Ecto.Migration

  def change do
    create table(:vibes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :query, :string
      add :vibe, :string

      timestamps(type: :utc_datetime)
    end
  end
end
