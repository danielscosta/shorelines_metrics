defmodule ShorelinesMetricsWeb.SerieController do
  use ShorelinesMetricsWeb, :controller

  alias ShorelinesMetrics.Dashboards
  alias ShorelinesMetrics.Dashboards.Serie

  action_fallback ShorelinesMetricsWeb.FallbackController

  def index(conn, _params) do
    series = Dashboards.list_series()
    render(conn, "index.json", series: series)
  end

  def create(conn, %{"serie" => serie_params}) do
    with {:ok, %Serie{} = serie} <- Dashboards.create_serie(serie_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.serie_path(conn, :show, serie))
      |> render("show.json", serie: serie)
    end
  end

  def show(conn, %{"id" => id}) do
    serie = Dashboards.get_serie!(id)
    render(conn, "show.json", serie: serie)
  end

  def update(conn, %{"id" => id, "serie" => serie_params}) do
    serie = Dashboards.get_serie!(id)

    with {:ok, %Serie{} = serie} <- Dashboards.update_serie(serie, serie_params) do
      render(conn, "show.json", serie: serie)
    end
  end

  def delete(conn, %{"id" => id}) do
    serie = Dashboards.get_serie!(id)

    with {:ok, %Serie{}} <- Dashboards.delete_serie(serie) do
      send_resp(conn, :no_content, "")
    end
  end
end
