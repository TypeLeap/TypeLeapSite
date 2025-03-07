defmodule VibeInputWeb.VibeLiveTest do
  use VibeInputWeb.ConnCase

  import Phoenix.LiveViewTest
  import VibeInput.VibesFixtures

  @create_attrs %{query: "some query", vibe: "some vibe"}
  @update_attrs %{query: "some updated query", vibe: "some updated vibe"}
  @invalid_attrs %{query: nil, vibe: nil}

  defp create_vibe(_) do
    vibe = vibe_fixture()
    %{vibe: vibe}
  end

  describe "Index" do
    setup [:create_vibe]

    test "lists all vibes", %{conn: conn, vibe: vibe} do
      {:ok, _index_live, html} = live(conn, ~p"/vibes")

      assert html =~ "Listing Vibes"
      assert html =~ vibe.query
    end

    test "saves new vibe", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/vibes")

      assert index_live |> element("a", "New Vibe") |> render_click() =~
               "New Vibe"

      assert_patch(index_live, ~p"/vibes/new")

      assert index_live
             |> form("#vibe-form", vibe: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#vibe-form", vibe: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vibes")

      html = render(index_live)
      assert html =~ "Vibe created successfully"
      assert html =~ "some query"
    end

    test "updates vibe in listing", %{conn: conn, vibe: vibe} do
      {:ok, index_live, _html} = live(conn, ~p"/vibes")

      assert index_live |> element("#vibes-#{vibe.id} a", "Edit") |> render_click() =~
               "Edit Vibe"

      assert_patch(index_live, ~p"/vibes/#{vibe}/edit")

      assert index_live
             |> form("#vibe-form", vibe: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#vibe-form", vibe: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vibes")

      html = render(index_live)
      assert html =~ "Vibe updated successfully"
      assert html =~ "some updated query"
    end

    test "deletes vibe in listing", %{conn: conn, vibe: vibe} do
      {:ok, index_live, _html} = live(conn, ~p"/vibes")

      assert index_live |> element("#vibes-#{vibe.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#vibes-#{vibe.id}")
    end
  end

  describe "Show" do
    setup [:create_vibe]

    test "displays vibe", %{conn: conn, vibe: vibe} do
      {:ok, _show_live, html} = live(conn, ~p"/vibes/#{vibe}")

      assert html =~ "Show Vibe"
      assert html =~ vibe.query
    end

    test "updates vibe within modal", %{conn: conn, vibe: vibe} do
      {:ok, show_live, _html} = live(conn, ~p"/vibes/#{vibe}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Vibe"

      assert_patch(show_live, ~p"/vibes/#{vibe}/show/edit")

      assert show_live
             |> form("#vibe-form", vibe: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#vibe-form", vibe: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/vibes/#{vibe}")

      html = render(show_live)
      assert html =~ "Vibe updated successfully"
      assert html =~ "some updated query"
    end
  end
end
