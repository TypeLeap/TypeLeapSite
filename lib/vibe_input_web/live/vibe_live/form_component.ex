defmodule VibeInputWeb.VibeLive.FormComponent do
  use VibeInputWeb, :live_component

  alias VibeInput.Vibes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage vibe records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="vibe-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:query]} type="text" label="Query" />
        <.input field={@form[:vibe]} type="text" label="Vibe" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Vibe</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{vibe: vibe} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Vibes.change_vibe(vibe))
     end)}
  end

  @impl true
  def handle_event("validate", %{"vibe" => vibe_params}, socket) do
    changeset = Vibes.change_vibe(socket.assigns.vibe, vibe_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"vibe" => vibe_params}, socket) do
    save_vibe(socket, socket.assigns.action, vibe_params)
  end

  defp save_vibe(socket, :edit, vibe_params) do
    case Vibes.update_vibe(socket.assigns.vibe, vibe_params) do
      {:ok, vibe} ->
        notify_parent({:saved, vibe})

        {:noreply,
         socket
         |> put_flash(:info, "Vibe updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_vibe(socket, :new, vibe_params) do
    case Vibes.create_vibe(vibe_params) do
      {:ok, vibe} ->
        notify_parent({:saved, vibe})

        {:noreply,
         socket
         |> put_flash(:info, "Vibe created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
