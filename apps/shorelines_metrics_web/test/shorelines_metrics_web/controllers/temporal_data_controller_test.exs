defmodule ShorelinesMetricsWeb.TemporalDataControllerTest do
  use ShorelinesMetricsWeb.ConnCase

  alias ShorelinesMetrics.Dashboards
  alias ShorelinesMetrics.Dashboards.TemporalData

  @create_attrs %{
    occur_datetime: ~N[2010-04-17 14:00:00],
    value: 120.5
  }
  @update_attrs %{
    occur_datetime: ~N[2011-05-18 15:01:01],
    value: 456.7
  }
  @invalid_attrs %{occur_datetime: nil, value: nil, serie_id: nil}

  def fixture(:temporal_data) do
    {:ok, serie} = Dashboards.create_serie(%{tag: "some tag"})

    {:ok, temporal_data} =
      Dashboards.create_temporal_data(Map.put(@create_attrs, :serie_id, serie.id))

    temporal_data
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all temporal_datas", %{conn: conn} do
      conn = get(conn, Routes.temporal_data_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create temporal_data" do
    test "renders temporal_data when data is valid", %{conn: conn} do
      {:ok, serie} = Dashboards.create_serie(%{tag: "some tag"})

      conn =
        post(conn, Routes.temporal_data_path(conn, :create),
          temporal_data: Map.put(@create_attrs, :serie_id, serie.id)
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.temporal_data_path(conn, :show, id))

      assert %{
               "id" => id,
               "occur_datetime" => "2010-04-17T14:00:00",
               "value" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.temporal_data_path(conn, :create), temporal_data: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update temporal_data" do
    setup [:create_temporal_data]

    test "renders temporal_data when data is valid", %{
      conn: conn,
      temporal_data: %TemporalData{id: id} = temporal_data
    } do
      conn =
        put(conn, Routes.temporal_data_path(conn, :update, temporal_data),
          temporal_data: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.temporal_data_path(conn, :show, id))

      assert %{
               "id" => id,
               "occur_datetime" => "2011-05-18T15:01:01",
               "value" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, temporal_data: temporal_data} do
      conn =
        put(conn, Routes.temporal_data_path(conn, :update, temporal_data),
          temporal_data: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete temporal_data" do
    setup [:create_temporal_data]

    test "deletes chosen temporal_data", %{conn: conn, temporal_data: temporal_data} do
      conn = delete(conn, Routes.temporal_data_path(conn, :delete, temporal_data))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.temporal_data_path(conn, :show, temporal_data))
      end
    end
  end

  defp create_temporal_data(_) do
    temporal_data = fixture(:temporal_data)
    {:ok, temporal_data: temporal_data}
  end
end
