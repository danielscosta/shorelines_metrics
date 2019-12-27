defmodule ShorelinesMetrics.Dashboards.TemporalData do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias ShorelinesMetrics.Dashboards.Serie

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "temporal_datas" do
    field :occur_datetime, :naive_datetime
    field :value, :float
    belongs_to :serie, Serie

    timestamps()
  end

  @doc false
  def changeset(temporal_data, attrs) do
    temporal_data
    |> cast(attrs, [:occur_datetime, :value, :serie_id])
    |> validate_required([:occur_datetime, :value, :serie_id])
  end
end
