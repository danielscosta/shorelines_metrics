defmodule ShorelinesMetrics.Dashboards.Serie do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias ShorelinesMetrics.Dashboards.TemporalData

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "series" do
    field :tag, :string
    has_many :temporal_datas, TemporalData

    timestamps()
  end

  @doc false
  def changeset(serie, attrs) do
    serie
    |> cast(attrs, [:tag])
    |> validate_required([:tag])
  end
end
