defmodule Helios.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HeliosWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Helios.PubSub, adapter: Phoenix.PubSub.PG2},
      # Start the Endpoint (http/https)
      HeliosWeb.Endpoint,
      # Start a worker by calling: Helios.Worker.start_link(arg)
      # {Helios.Worker, arg}

      {MyXQL, username: "root",password: "",database: "helios",hostname: "localhost", name: :myxql}
      # {:ok, pid} = MyXQL.start_link(username: "root",password: "",database: "helios",hostname: "localhost")

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Helios.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HeliosWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
