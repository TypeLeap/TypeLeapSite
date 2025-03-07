defmodule VibeInput.Vibes do
  @moduledoc """
  The Vibes context.
  """

  import Ecto.Query, warn: false
  alias VibeInput.Repo

  alias VibeInput.Vibes.Vibe

  @doc """
  Returns the list of vibes.

  ## Examples

      iex> list_vibes()
      [%Vibe{}, ...]

  """
  def list_vibes do
    Repo.all(Vibe)
  end

  @doc """
  Gets a single vibe.

  Raises `Ecto.NoResultsError` if the Vibe does not exist.

  ## Examples

      iex> get_vibe!(123)
      %Vibe{}

      iex> get_vibe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vibe!(id), do: Repo.get!(Vibe, id)

  @doc """
  Creates a vibe.

  ## Examples

      iex> create_vibe(%{field: value})
      {:ok, %Vibe{}}

      iex> create_vibe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vibe(attrs \\ %{}) do
    %Vibe{}
    |> Vibe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vibe.

  ## Examples

      iex> update_vibe(vibe, %{field: new_value})
      {:ok, %Vibe{}}

      iex> update_vibe(vibe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vibe(%Vibe{} = vibe, attrs) do
    vibe
    |> Vibe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vibe.

  ## Examples

      iex> delete_vibe(vibe)
      {:ok, %Vibe{}}

      iex> delete_vibe(vibe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vibe(%Vibe{} = vibe) do
    Repo.delete(vibe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vibe changes.

  ## Examples

      iex> change_vibe(vibe)
      %Ecto.Changeset{data: %Vibe{}}

  """
  def change_vibe(%Vibe{} = vibe, attrs \\ %{}) do
    Vibe.changeset(vibe, attrs)
  end
end
