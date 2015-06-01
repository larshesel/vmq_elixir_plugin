defmodule VmqElixirPlugin do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(VmqElixirPlugin.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VmqElixirPlugin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def auth_on_register(a,b,c,d,e) do
    IO.inspect {:auth_on_register, a, b, c, d, e}
    :ok
  end

  def auth_on_subscribe(a,b,c) do
    IO.inspect {:auth_on_subscribe, a, b, c}
    :ok
  end
end
