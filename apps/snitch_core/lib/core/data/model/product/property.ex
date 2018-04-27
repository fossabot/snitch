defmodule Snitch.Data.Model.Property do
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

  @spec get_all(map()) :: [Product.t()]
  def get_all(params \\ %{}) do
    # QH.get_all(Product)
    Schema.Product.get_all(params)
  end
end
