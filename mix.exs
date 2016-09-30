defmodule PromPlugsApp.Mixfile do
  use Mix.Project

  def project do
    [app: :prom_plugs_app,
     version: "0.0.1",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    applications = [
      :logger, :postgrex, :ecto, :cowboy,
      :poison, :plug, :mix, :prometheus, :prometheus_plugs
    ]
    mod = {PromPlugsApp, []}
    [mod: mod, applications: applications]
  end

  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [{:cowboy, "~> 1.0"},
     {:plug, "~> 1.2"},
     {:poison, "~> 2.2"},
     {:postgrex, "~> 0.12"},
     {:distillery, "~> 0.9"},
     {:ecto, "~> 2.0"},
     {:prometheus, "~> 3.0"},
     {:prometheus_plugs, "~> 1.0"}
   ]
  end
end
