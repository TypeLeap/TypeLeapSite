defmodule VibeInput.Vibes.Vibe do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "vibes" do
    field :query, :string
    field :vibe, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vibe, attrs) do
    vibe
    |> cast(attrs, [:query, :vibe])
    |> validate_required([:query, :vibe])
  end
end
