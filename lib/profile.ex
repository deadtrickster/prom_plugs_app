defmodule PromPlugsApp.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  @exportable [:profile_id, :meta, :inserted_at, :updated_at]

  @primary_key {:profile_id, :id, autogenerate: true}
  schema "profile" do
    field :meta, :map
    timestamps
  end

  def to_map(model) do
    model
    |> Map.take(@exportable)
  end
end