defmodule ShorelinesMetricsWeb.Router do
  use ShorelinesMetricsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShorelinesMetricsWeb do
    pipe_through :api

    resources "/series", SerieController, except: [:new, :edit]
    resources "/temporal_datas", TemporalDataController, except: [:new, :edit]
  end
end
