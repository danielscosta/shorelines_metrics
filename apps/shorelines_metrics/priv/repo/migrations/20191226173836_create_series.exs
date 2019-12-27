defmodule ShorelinesMetrics.Repo.Migrations.CreateSeries do
  use Ecto.Migration

  def change do
    create table(:series, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :tag, :string

      timestamps()
    end
  end
end
