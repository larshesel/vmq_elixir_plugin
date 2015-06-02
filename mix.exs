defmodule VmqElixirPlugin.Mixfile do
  use Mix.Project

  def project do
    [app: :vmq_elixir_plugin,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :vmq_elixir],
     mod: {VmqElixirPlugin, []},
     env: [vmq_plugin_hooks]]
  end

  defp vmq_plugin_hooks do
    {:vmq_plugin_hooks, [{Elixir.VmqElixirPlugin,:auth_on_subscribe,3,[]},
                         {Elixir.VmqElixirPlugin,:auth_on_register,5,[]},
                         {Elixir.VmqElixirPlugin,:auth_on_publish,6,[]}]}
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    # Use vmq_elixir as a dev dependency, otherwise we can's start the
    # app with `iex -S mix`. It's not needed for creating actual
    # plugins, as vmq_elixir would already be loaded..
    [{:vmq_elixir, git: "https://github.com/larshesel/vmq_elixir.git", only: :dev}]
  end
end
