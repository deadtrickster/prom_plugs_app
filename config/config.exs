use Mix.Config

config :prom_plugs_app, PromPlugsApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "prom_plugs_app",
  hostname: "localhost",
  port: "5432",
  username: "postgres",
  password: "postgres",
  pool_size: 50

config :prometheus, PromPlugsApp.PlugPipelineInstrumenter,
  labels: [:status_code, :method, method_name: CustomLabels],
  duration_buckets: [
    1_000, 3_000, 5_000, 7_000, 9_000, 15_000, 20_000, 30_000,
    50_000, 100_000, 300_000, 1_000_000, 3_000_000, 5_000_000
  ], registry: :default,
  duration_unit: :microseconds

config :prom_plugs_app, PromPlugsApp.HTTP,
  port: 8088

import_config "#{Mix.env}.exs"
