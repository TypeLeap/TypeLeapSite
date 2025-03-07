defmodule VibeInput.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VibeInputWeb.Telemetry,
      VibeInput.Repo,
      {DNSCluster, query: Application.get_env(:vibe_input, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VibeInput.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: VibeInput.Finch},
      # Start a worker by calling: VibeInput.Worker.start_link(arg)
      # {VibeInput.Worker, arg},
      # Start to serve requests, typically the last entry
      VibeInputWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VibeInput.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VibeInputWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
