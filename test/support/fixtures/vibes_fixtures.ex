defmodule TypeLeap.VibesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TypeLeap.Vibes` context.
  """

  @doc """
  Generate a vibe.
  """
  def vibe_fixture(attrs \\ %{}) do
    {:ok, vibe} =
      attrs
      |> Enum.into(%{
        query: "some query",
        vibe: "some vibe"
      })
      |> TypeLeap.Vibes.create_vibe()

    vibe
  end
end
