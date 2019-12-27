defmodule ShorelinesMetrics.Dashboards.TemporalData do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "temporal_datas" do
    field :occur_datetime, :naive_datetime
    field :value, :float
    field :serie_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(temporal_data, attrs) do
    temporal_data
    |> cast(attrs, [:occur_datetime, :value])
    |> validate_required([:occur_datetime, :value])
  end
end
