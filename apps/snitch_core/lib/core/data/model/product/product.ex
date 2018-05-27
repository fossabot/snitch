defmodule Snitch.Data.Model.Product do
  @moduledoc """

  """
  alias Snitch.Data.Schema

  use Snitch.Data.Model

  @doc """
  Fetch a product with id
  TODO: support fetching with slug
  """
  @spec get(non_neg_integer) :: Product.t() | nil
  def get(primary_key) do
    QH.get(Product, primary_key, Repo)
  end

  @spec list_products(map()) :: [Product.t()]
  def list_products(params \\ %{}) do
    # QH.get_all(Product)
    # Schema.Product.get_all(params)
    [%Schema.Product{name: "Firebolt"}, %Schema.Product{name: "Nimbus 2000"}]
  end
end
