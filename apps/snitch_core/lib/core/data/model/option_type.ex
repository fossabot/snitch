defmodule Snitch.Data.Model.OptionType do
  @moduledoc false
  use Snitch.Data.Model
  alias Snitch.Data.Schema.OptionType

  @doc """
  Create a Option Type with supplied params
  """
  @spec create(map) :: {:ok, OptionType.t()} | {:error, Ecto.Changeset.t()}
  def create(params) do
    QH.create(OptionType, params, Repo)
  end

  @doc """
  Returns all Option Types
  """
  @spec get_all() :: [OptionType.t()]
  def get_all do
    Repo.all(OptionType)
  end

  @doc """
  Returns an Option type

  Takes Optiontype id as input
  """
  @spec get(integer) :: OptionType.t() | nil
  def get(id) do
    QH.get(OptionType, id, Repo)
  end

  @doc """
  Update the option type with supplied params and option type instance
  """
  @spec update(OptionType.t(), map) :: {:ok, OptionType.t()} | {:error, Ecto.Changeset.t()}
  def update(model, params) do
    QH.update(OptionType, params, model, Repo)
  end

  @doc """
  Deletes the option type
  """
  @spec delete(OptionType.t()) :: {:ok, OptionType.t()} | {:error, Ecto.Changeset.t()}
  def delete(instance) do
    Repo.delete(instance)
  end
end
