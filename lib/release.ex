defmodule Release.Tasks do
  def migrate do
    path = Application.app_dir(:prom_plugs_app, "priv/repo/migrations")
    Ecto.Migrator.run(PromPlugsApp.Repo, path, :up, all: true)
    :ok
  end
end
