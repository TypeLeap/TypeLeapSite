defmodule VibeInputWeb.Components.VibeLiveInputHelpers do
  use Phoenix.Component

  attr :intent, :string, required: true
  attr :label, :string, required: true
  attr :current_intent, :string, required: true
  attr :myself, :string, required: true

  def render_intent_tab(assigns) do
    ~H"""
    <button
      phx-click="set_intent"
      phx-value-intent={@intent}
      phx-target={@myself}
      class={[
        "rounded px-2 py-1 text-xs transition-colors hover:bg-white/50",
        @intent == @current_intent && "bg-white/40 font-bold"
      ]}
      type="button"
    >
      {@label}
    </button>
    """
  end
end
