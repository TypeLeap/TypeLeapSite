defmodule TypeLeap.VibesTest do
  use TypeLeap.DataCase

  alias TypeLeap.Vibes

  describe "vibes" do
    alias TypeLeap.Vibes.Vibe

    import TypeLeap.VibesFixtures

    @invalid_attrs %{query: nil, vibe: nil}

    test "list_vibes/0 returns all vibes" do
      vibe = vibe_fixture()
      assert Vibes.list_vibes() == [vibe]
    end

    test "get_vibe!/1 returns the vibe with given id" do
      vibe = vibe_fixture()
      assert Vibes.get_vibe!(vibe.id) == vibe
    end

    test "create_vibe/1 with valid data creates a vibe" do
      valid_attrs = %{query: "some query", vibe: "some vibe"}

      assert {:ok, %Vibe{} = vibe} = Vibes.create_vibe(valid_attrs)
      assert vibe.query == "some query"
      assert vibe.vibe == "some vibe"
    end

    test "create_vibe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vibes.create_vibe(@invalid_attrs)
    end

    test "update_vibe/2 with valid data updates the vibe" do
      vibe = vibe_fixture()
      update_attrs = %{query: "some updated query", vibe: "some updated vibe"}

      assert {:ok, %Vibe{} = vibe} = Vibes.update_vibe(vibe, update_attrs)
      assert vibe.query == "some updated query"
      assert vibe.vibe == "some updated vibe"
    end

    test "update_vibe/2 with invalid data returns error changeset" do
      vibe = vibe_fixture()
      assert {:error, %Ecto.Changeset{}} = Vibes.update_vibe(vibe, @invalid_attrs)
      assert vibe == Vibes.get_vibe!(vibe.id)
    end

    test "delete_vibe/1 deletes the vibe" do
      vibe = vibe_fixture()
      assert {:ok, %Vibe{}} = Vibes.delete_vibe(vibe)
      assert_raise Ecto.NoResultsError, fn -> Vibes.get_vibe!(vibe.id) end
    end

    test "change_vibe/1 returns a vibe changeset" do
      vibe = vibe_fixture()
      assert %Ecto.Changeset{} = Vibes.change_vibe(vibe)
    end
  end
end
