defmodule ShorelinesMetrics.Dashboards do
  @moduledoc """
  The Dashboards context.
  """

  import Ecto.Query, warn: false
  alias ShorelinesMetrics.Repo

  alias ShorelinesMetrics.Dashboards.Serie

  @doc """
  Returns the list of series.

  ## Examples

      iex> list_series()
      [%Serie{}, ...]

  """
  def list_series do
    Repo.all(Serie)
  end

  @doc """
  Gets a single serie.

  Raises `Ecto.NoResultsError` if the Serie does not exist.

  ## Examples

      iex> get_serie!(123)
      %Serie{}

      iex> get_serie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_serie!(id), do: Repo.get!(Serie, id)

  @doc """
  Creates a serie.

  ## Examples

      iex> create_serie(%{field: value})
      {:ok, %Serie{}}

      iex> create_serie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_serie(attrs \\ %{}) do
    %Serie{}
    |> Serie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a serie.

  ## Examples

      iex> update_serie(serie, %{field: new_value})
      {:ok, %Serie{}}

      iex> update_serie(serie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_serie(%Serie{} = serie, attrs) do
    serie
    |> Serie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Serie.

  ## Examples

      iex> delete_serie(serie)
      {:ok, %Serie{}}

      iex> delete_serie(serie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_serie(%Serie{} = serie) do
    Repo.delete(serie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking serie changes.

  ## Examples

      iex> change_serie(serie)
      %Ecto.Changeset{source: %Serie{}}

  """
  def change_serie(%Serie{} = serie) do
    Serie.changeset(serie, %{})
  end

  alias ShorelinesMetrics.Dashboards.TemporalData

  @doc """
  Returns the list of temporal_datas.

  ## Examples

      iex> list_temporal_datas()
      [%TemporalData{}, ...]

  """
  def list_temporal_datas do
    Repo.all(TemporalData)
  end

  @doc """
  Gets a single temporal_data.

  Raises `Ecto.NoResultsError` if the Temporal data does not exist.

  ## Examples

      iex> get_temporal_data!(123)
      %TemporalData{}

      iex> get_temporal_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_temporal_data!(id), do: Repo.get!(TemporalData, id)

  @doc """
  Creates a temporal_data.

  ## Examples

      iex> create_temporal_data(%{field: value})
      {:ok, %TemporalData{}}

      iex> create_temporal_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_temporal_data(attrs \\ %{}) do
    %TemporalData{}
    |> TemporalData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a temporal_data.

  ## Examples

      iex> update_temporal_data(temporal_data, %{field: new_value})
      {:ok, %TemporalData{}}

      iex> update_temporal_data(temporal_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_temporal_data(%TemporalData{} = temporal_data, attrs) do
    temporal_data
    |> TemporalData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TemporalData.

  ## Examples

      iex> delete_temporal_data(temporal_data)
      {:ok, %TemporalData{}}

      iex> delete_temporal_data(temporal_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_temporal_data(%TemporalData{} = temporal_data) do
    Repo.delete(temporal_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking temporal_data changes.

  ## Examples

      iex> change_temporal_data(temporal_data)
      %Ecto.Changeset{source: %TemporalData{}}

  """
  def change_temporal_data(%TemporalData{} = temporal_data) do
    TemporalData.changeset(temporal_data, %{})
  end
end
