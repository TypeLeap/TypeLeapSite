defmodule VibeInputWeb.VibeLiveInput do
  use VibeInputWeb, :live_component

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:vibe, "")}
  end

  @impl true
  def handle_event("update_vibe", %{"vibe" => vibe}, socket) do
    {:noreply, assign(socket, vibe: vibe)}
  end
end
