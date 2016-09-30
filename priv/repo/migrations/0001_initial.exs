defmodule PromPlugsApp.Migrations.Initial do
  use Ecto.Migration
  def up do
    create table(:profile, primary_key: false) do
      add :profile_id, :bigint, primary_key: true
      add :meta, :map
      timestamps
    end
    execute "insert into profile(profile_id, inserted_at, updated_at, meta) values (1, now(), now(), '{\"a\":1, \"b\":2}');"
  end

  def down do
    execute "DROP TABLE profile CASCADE"
  end
end
