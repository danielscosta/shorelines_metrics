import Config

# Configure your database
config :shorelines_metrics, ShorelinesMetrics.Repo,
  username: "postgres",
  password: "postgres",
  database: "shorelines_metrics_test",
  hostname: System.get_env("PG_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shorelines_metrics_web, ShorelinesMetricsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
