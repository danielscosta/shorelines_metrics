import Config

# Configure Mix tasks and generators
config :shorelines_metrics,
  ecto_repos: [ShorelinesMetrics.Repo]

config :shorelines_metrics_web,
  ecto_repos: [ShorelinesMetrics.Repo],
  generators: [context_app: :shorelines_metrics, binary_id: true]

# Configures the endpoint
config :shorelines_metrics_web, ShorelinesMetricsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "l3rgZ3jIqLBJVu4WMHPjIdzwwugJqBFIsQumIlXDmNjQoDp9zBlotPhO5z7NcY/6",
  render_errors: [view: ShorelinesMetricsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ShorelinesMetricsWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
