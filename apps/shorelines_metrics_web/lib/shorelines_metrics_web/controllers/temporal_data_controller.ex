defmodule ShorelinesMetricsWeb.TemporalDataController do
  use ShorelinesMetricsWeb, :controller

  alias ShorelinesMetrics.Dashboards
  alias ShorelinesMetrics.Dashboards.TemporalData

  action_fallback ShorelinesMetricsWeb.FallbackController

  def index(conn, params) when map_size(params) == 0 do
    temporal_datas = Dashboards.list_temporal_datas()
    render(conn, "index.json", temporal_datas: temporal_datas)
  end

  def index(conn, params) do
    temporal_datas = Dashboards.list_temporal_datas_by_params(keys_to_atoms(params))
    render(conn, "index.json", temporal_datas: temporal_datas)
  end

  def keys_to_atoms(%_{} = value), do: value

  def keys_to_atoms(%{} = string_key_map),
    do:
      for({key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), keys_to_atoms(val)})

  def keys_to_atoms(value), do: value

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
