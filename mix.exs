defmodule ShorelinesMetrics.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      releases: [
        shorelines_metrics: [
          include_executables_for: [:unix],
          applications: [
            shorelines_metrics: :permanent,
            shorelines_metrics_web: :permanent,
            runtime_tools: :permanent,
            jason: :permanent
          ],
          quiet: true
        ]
      ],
      version: "0.1.0"
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  defp deps do
    [
      {:credo, "~> 1.1.5", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.12", only: :test}
    ]
  end
end
