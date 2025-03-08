defmodule VibeInputWeb.VibeLiveInput do
  use VibeInputWeb, :live_component
  alias VibeInputWeb.Components.VibeInputIntent
  alias VibeInputWeb.Components.Icons
  import VibeInputWeb.Components.VibeLiveInputHelpers

  @impl true
  def mount(socket) do
    {:ok,
     socket
     |> assign(:intent, nil)
     |> assign(:intent_task, nil)
     |> assign(:loading, false)
     |> assign(:intent_locked, false)
     |> assign(:intent_button, "Go")
     |> assign(:intent_icon, nil)
     |> assign(:query, "")}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, socket |> assign(assigns) |> assign_button_for_intent()}
  end

  @impl true
  def handle_event("update_query", %{"query" => query}, socket) do
    if query == "" do
      {:noreply, socket |> reset_state()}
    else
      {:noreply, socket |> handle_query_update(query)}
    end
  end

  def handle_event("set_intent", %{"intent" => intent}, socket) do
    {:noreply,
     socket
     |> assign(:intent, intent)
     |> assign_button_for_intent()
     |> assign(:intent_locked, true)}
  end

  def handle_event("submit", _params, socket) do
    {:noreply, socket |> reset_state()}
  end

  defp reset_state(socket) do
    socket
    |> stop_task()
    |> assign(:intent, nil)
    |> assign(:intent_task, nil)
    |> assign(:intent_icon, nil)
    |> assign(:intent_locked, false)
    |> assign(:query, "")
    |> assign_button_for_intent()
  end

  defp assign_button_for_intent(socket) do
    intent_buttons = %{
      "search" => "Search",
      "knowledge" => "Add Knowledge",
      "command" => "Run Command",
      "question" => "Answer Question",
      "navigate" => "Visit Site"
    }

    intent_icons = %{
      "search" => &Icons.intent_search_icon/1,
      "knowledge" => &Icons.intent_knowledge_icon/1,
      "command" => &Icons.intent_command_icon/1,
      "question" => &Icons.intent_question_icon/1,
      "navigate" => &Icons.intent_navigate_icon/1
    }

    if socket.assigns.intent do
      icon_func = Map.get(intent_icons, socket.assigns.intent)

      socket
      |> assign(:intent_button, Map.get(intent_buttons, socket.assigns.intent))
      |> assign(:intent_icon, icon_func.(%{}))
    else
      socket |> assign(:intent_button, "Go")
    end
  end

  defp handle_query_update(socket, query) do
    socket |> assign(:query, query) |> get_intent_unless_locked()
  end

  defp get_intent_unless_locked(socket) do
    if socket.assigns.intent_locked do
      socket
    else
      get_intent(socket)
    end
  end

  defp stop_task(socket) do
    if socket.assigns.intent_task do
      Task.shutdown(socket.assigns.intent_task)
    end

    socket |> assign(:intent_task, nil)
  end

  defp get_intent(socket) do
    my_pid = self()
    id = socket.assigns.id
    query = socket.assigns.query

    socket |> stop_task()

    task =
      Task.async(fn ->
        # lol sleep debounce
        Process.sleep(250)
        IO.puts("Getting intent")
        send_update(my_pid, __MODULE__, id: id, loading: true)
        %{"intent" => intent} = VibeInputIntent.get_intent(query)
        send_update(my_pid, __MODULE__, id: id, intent: intent, loading: false)
      end)

    socket |> assign(:intent_task, task)
  end
end
