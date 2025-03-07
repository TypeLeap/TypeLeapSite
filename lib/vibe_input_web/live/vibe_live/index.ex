defmodule VibeInputWeb.VibeLive.Index do
  use VibeInputWeb, :live_view

  alias VibeInput.Vibes
  alias VibeInput.Vibes.Vibe

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :vibes, Vibes.list_vibes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Vibe Input")
  end

  @impl true
  def handle_info({VibeInputWeb.VibeLive.FormComponent, {:saved, vibe}}, socket) do
    {:noreply, stream_insert(socket, :vibes, vibe)}
  end

end
