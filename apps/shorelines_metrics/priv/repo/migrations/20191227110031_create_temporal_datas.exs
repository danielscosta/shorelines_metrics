defmodule ShorelinesMetrics.Repo.Migrations.CreateTemporalDatas do
  use Ecto.Migration

  def change do
    create table(:temporal_datas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :occur_datetime, :naive_datetime
      add :value, :float
      add :serie_id, references(:series, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:temporal_datas, [:serie_id])
  end
end
