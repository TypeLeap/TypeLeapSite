defmodule VibeInputWeb.VibeLive.Show do
  use VibeInputWeb, :live_view

  alias VibeInput.Vibes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:vibe, Vibes.get_vibe!(id))}
  end

  defp page_title(:show), do: "Show Vibe"
  defp page_title(:edit), do: "Edit Vibe"
end
