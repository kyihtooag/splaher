defmodule Splash.Application do
  use Application

  def start(_type, _args) do
    children = [
      # Start the endpoint when the application starts
      Splash.Test
      # Starts a worker by calling: AnadaEload.Worker.start_link(arg)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    Supervisor.start_link(children, strategy: :one_for_one)
    # some more stuff
  end
end
