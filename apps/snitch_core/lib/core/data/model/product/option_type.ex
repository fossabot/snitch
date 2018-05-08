defmodule Snitch.Data.Model.OptionType do
  @moduledoc """

  """
  alias Snitch.Data.Schema.OptionType, as: OptionTypeSchema
  use Snitch.Data.Model

  @doc """
  Creates an `OptionType`
  """
  @spec create(map()) :: {:ok, OptionTypeSchema.t()} | {:error, Ecto.Changeset.t()}
  def create(params \\ %{}) do
    %OptionTypeSchema{}
    |> OptionTypeSchema.create_changeset(params)
    |> Repo.insert()
  end

  @spec update(map()) :: {:ok, OptionTypeSchema.t()} | {:error, Ecto.Changeset.t()}
  def update(params \\ %{}, instance \\ nil) do
    QH.update(OptionTypeSchema, params, instance, Repo)
  end

  @doc """
  Fetches one option type based on `id` or `field`
  """
  @spec get(non_neg_integer | map) :: OptionTypeSchema.t()
  def get(query_fields) do
    QH.get(OptionTypeSchema, query_fields, Repo)
  end

  @doc """
  Fetches all the option types in the DB
  """
  @spec get_all :: list(OptionTypeSchema.t())
  def get_all, do: Repo.all(OptionTypeSchema)
end
