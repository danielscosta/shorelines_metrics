defmodule ShorelinesMetricsWeb.TemporalDataController do
  use ShorelinesMetricsWeb, :controller

  alias ShorelinesMetrics.Dashboards
  alias ShorelinesMetrics.Dashboards.TemporalData

  action_fallback ShorelinesMetricsWeb.FallbackController

  def index(conn, _params) do
    temporal_datas = Dashboards.list_temporal_datas()
    render(conn, "index.json", temporal_datas: temporal_datas)
  end

  def create(conn, %{"temporal_data" => temporal_data_params}) do
    with {:ok, %TemporalData{} = temporal_data} <-
           Dashboards.create_temporal_data(temporal_data_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.temporal_data_path(conn, :show, temporal_data))
      |> render("show.json", temporal_data: temporal_data)
    end
  end

  def show(conn, %{"id" => id}) do
    temporal_data = Dashboards.get_temporal_data!(id)
    render(conn, "show.json", temporal_data: temporal_data)
  end

  def update(conn, %{"id" => id, "temporal_data" => temporal_data_params}) do
    temporal_data = Dashboards.get_temporal_data!(id)

    with {:ok, %TemporalData{} = temporal_data} <-
           Dashboards.update_temporal_data(temporal_data, temporal_data_params) do
      render(conn, "show.json", temporal_data: temporal_data)
    end
  end

  def delete(conn, %{"id" => id}) do
    temporal_data = Dashboards.get_temporal_data!(id)

    with {:ok, %TemporalData{}} <- Dashboards.delete_temporal_data(temporal_data) do
      send_resp(conn, :no_content, "")
    end
  end
end
