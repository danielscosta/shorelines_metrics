defmodule ShorelinesMetricsWeb.SerieControllerTest do
  use ShorelinesMetricsWeb.ConnCase

  alias ShorelinesMetrics.Dashboards
  alias ShorelinesMetrics.Dashboards.Serie

  @create_attrs %{
    tag: "some tag"
  }
  @update_attrs %{
    tag: "some updated tag"
  }
  @invalid_attrs %{tag: nil}

  def fixture(:serie) do
    {:ok, serie} = Dashboards.create_serie(@create_attrs)
    serie
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all series", %{conn: conn} do
      conn = get(conn, Routes.serie_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create serie" do
    test "renders serie when data is valid", %{conn: conn} do
      conn = post(conn, Routes.serie_path(conn, :create), serie: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.serie_path(conn, :show, id))

      assert %{
               "id" => id,
               "tag" => "some tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.serie_path(conn, :create), serie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update serie" do
    setup [:create_serie]

    test "renders serie when data is valid", %{conn: conn, serie: %Serie{id: id} = serie} do
      conn = put(conn, Routes.serie_path(conn, :update, serie), serie: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.serie_path(conn, :show, id))

      assert %{
               "id" => id,
               "tag" => "some updated tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, serie: serie} do
      conn = put(conn, Routes.serie_path(conn, :update, serie), serie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete serie" do
    setup [:create_serie]

    test "deletes chosen serie", %{conn: conn, serie: serie} do
      conn = delete(conn, Routes.serie_path(conn, :delete, serie))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.serie_path(conn, :show, serie))
      end
    end
  end

  defp create_serie(_) do
    serie = fixture(:serie)
    {:ok, serie: serie}
  end
end
