defmodule ShorelinesMetrics.DashboardsTest do
  use ShorelinesMetrics.DataCase

  alias ShorelinesMetrics.Dashboards

  describe "series" do
    alias ShorelinesMetrics.Dashboards.Serie

    @valid_attrs %{tag: "some tag"}
    @update_attrs %{tag: "some updated tag"}
    @invalid_attrs %{tag: nil}

    def serie_fixture(attrs \\ %{}) do
      {:ok, serie} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboards.create_serie()

      serie
    end

    test "list_series/0 returns all series" do
      serie = serie_fixture()
      assert Dashboards.list_series() == [serie]
    end

    test "get_serie!/1 returns the serie with given id" do
      serie = serie_fixture()
      assert Dashboards.get_serie!(serie.id) == serie
    end

    test "create_serie/1 with valid data creates a serie" do
      assert {:ok, %Serie{} = serie} = Dashboards.create_serie(@valid_attrs)
      assert serie.tag == "some tag"
    end

    test "create_serie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboards.create_serie(@invalid_attrs)
    end

    test "update_serie/2 with valid data updates the serie" do
      serie = serie_fixture()
      assert {:ok, %Serie{} = serie} = Dashboards.update_serie(serie, @update_attrs)
      assert serie.tag == "some updated tag"
    end

    test "update_serie/2 with invalid data returns error changeset" do
      serie = serie_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboards.update_serie(serie, @invalid_attrs)
      assert serie == Dashboards.get_serie!(serie.id)
    end

    test "delete_serie/1 deletes the serie" do
      serie = serie_fixture()
      assert {:ok, %Serie{}} = Dashboards.delete_serie(serie)
      assert_raise Ecto.NoResultsError, fn -> Dashboards.get_serie!(serie.id) end
    end

    test "change_serie/1 returns a serie changeset" do
      serie = serie_fixture()
      assert %Ecto.Changeset{} = Dashboards.change_serie(serie)
    end
  end

  describe "temporal_datas" do
    alias ShorelinesMetrics.Dashboards.TemporalData

    @valid_attrs %{occur_datetime: ~N[2010-04-17 14:00:00], value: 120.5}
    @update_attrs %{occur_datetime: ~N[2011-05-18 15:01:01], value: 456.7}
    @invalid_attrs %{occur_datetime: nil, value: nil, serie_id: nil}

    def temporal_data_fixture(attrs \\ %{}) do
      {:ok, serie} = Dashboards.create_serie(%{tag: "some tag"})

      {:ok, temporal_data} =
        attrs
        |> Map.put(:serie_id, serie.id)
        |> Enum.into(@valid_attrs)
        |> Dashboards.create_temporal_data()

      temporal_data
    end

    test "list_temporal_datas/0 returns all temporal_datas" do
      temporal_data = temporal_data_fixture()
      assert Dashboards.list_temporal_datas() == [temporal_data]
    end

    test "get_temporal_data!/1 returns the temporal_data with given id" do
      temporal_data = temporal_data_fixture()
      assert Dashboards.get_temporal_data!(temporal_data.id) == temporal_data
    end

    test "create_temporal_data/1 with valid data creates a temporal_data" do
      {:ok, serie} = Dashboards.create_serie(%{tag: "some tag"})

      assert {:ok, %TemporalData{} = temporal_data} =
               Dashboards.create_temporal_data(Map.put(@valid_attrs, :serie_id, serie.id))

      assert temporal_data.occur_datetime == ~N[2010-04-17 14:00:00]
      assert temporal_data.value == 120.5
    end

    test "create_temporal_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboards.create_temporal_data(@invalid_attrs)
    end

    test "update_temporal_data/2 with valid data updates the temporal_data" do
      temporal_data = temporal_data_fixture()

      assert {:ok, %TemporalData{} = temporal_data} =
               Dashboards.update_temporal_data(temporal_data, @update_attrs)

      assert temporal_data.occur_datetime == ~N[2011-05-18 15:01:01]
      assert temporal_data.value == 456.7
    end

    test "update_temporal_data/2 with invalid data returns error changeset" do
      temporal_data = temporal_data_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Dashboards.update_temporal_data(temporal_data, @invalid_attrs)

      assert temporal_data == Dashboards.get_temporal_data!(temporal_data.id)
    end

    test "delete_temporal_data/1 deletes the temporal_data" do
      temporal_data = temporal_data_fixture()
      assert {:ok, %TemporalData{}} = Dashboards.delete_temporal_data(temporal_data)
      assert_raise Ecto.NoResultsError, fn -> Dashboards.get_temporal_data!(temporal_data.id) end
    end

    test "change_temporal_data/1 returns a temporal_data changeset" do
      temporal_data = temporal_data_fixture()
      assert %Ecto.Changeset{} = Dashboards.change_temporal_data(temporal_data)
    end
  end
end
