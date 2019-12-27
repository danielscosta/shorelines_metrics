defmodule ShorelinesMetricsWeb.SerieView do
  use ShorelinesMetricsWeb, :view
  alias ShorelinesMetricsWeb.SerieView

  def render("index.json", %{series: series}) do
    %{data: render_many(series, SerieView, "serie.json")}
  end

  def render("show.json", %{serie: serie}) do
    %{data: render_one(serie, SerieView, "serie.json")}
  end

  def render("serie.json", %{serie: serie}) do
    %{id: serie.id, tag: serie.tag}
  end
end
