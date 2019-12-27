defmodule ShorelinesMetricsWeb.TemporalDataView do
  use ShorelinesMetricsWeb, :view
  alias ShorelinesMetricsWeb.TemporalDataView

  def render("index.json", %{temporal_datas: temporal_datas}) do
    %{data: render_many(temporal_datas, TemporalDataView, "temporal_data.json")}
  end

  def render("show.json", %{temporal_data: temporal_data}) do
    %{data: render_one(temporal_data, TemporalDataView, "temporal_data.json")}
  end

  def render("temporal_data.json", %{temporal_data: temporal_data}) do
    %{
      id: temporal_data.id,
      occur_datetime: temporal_data.occur_datetime,
      value: temporal_data.value
    }
  end
end
