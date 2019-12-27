defmodule ShorelinesMetrics.Repo do
  use Ecto.Repo,
    otp_app: :shorelines_metrics,
    adapter: Ecto.Adapters.Postgres
end
