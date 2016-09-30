defmodule PromPlugsApp do
  use Application

  def prometheus_labels do
    [:status_code, :method, :method_name]
  end

  def start(_type, _args) do

    PromPlugsApp.PlugPipelineInstrumenter.setup()
    PromPlugsApp.MetricsExporter.setup()

    import Supervisor.Spec, warn: false
    opts = [strategy: :one_for_one, name: PromPlugsApp.Supervisor]
    children = [
        worker(PromPlugsApp.HTTP, []),
        supervisor(PromPlugsApp.Repo, [])
    ]
    Supervisor.start_link(children, opts)
  end
end

defmodule CustomLabels do
  def label_value(key, conn) do
    Map.get(conn, :method_name, "unknown") |> to_string
  end
end

defmodule PromPlugsApp.API do
  import Ecto.Query, only: [from: 2]
  use Plug.Router
  use Plug.ErrorHandler
  require Logger

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  plug :match
  plug :dispatch


  get "/profiles/:profile_id" do
    conn = Map.put(conn, :method_name, "get_profile")
    obj = PromPlugsApp.Repo.get_by(PromPlugsApp.Profile, profile_id: profile_id)
    data = Poison.encode! PromPlugsApp.Profile.to_map(obj)
    send_resp(conn, 200, data)
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end

defmodule PromPlugsApp.MetricsExporter do
  use Prometheus.PlugExporter
end

defmodule PromPlugsApp.PlugPipelineInstrumenter do
  use Prometheus.PlugPipelineInstrumenter
end

defmodule PromPlugsApp.HTTP do
  use Plug.Builder
  plug PromPlugsApp.MetricsExporter
  plug PromPlugsApp.PlugPipelineInstrumenter
  plug PromPlugsApp.API, []

  def init(_opts) do
    %{}
  end

  def call(conn, opts) do
    conn = put_private(conn, :opts, opts)
    super(conn, opts)
  end

  def start_link do
    http_conf = Application.get_env(:prom_plugs_app, PromPlugsApp.HTTP, [])
    {:ok, _} = Plug.Adapters.Cowboy.http PromPlugsApp.HTTP, [], port: Keyword.get(http_conf, :port, 8000)
  end
end
