defmodule Snitch.Domain.Product do
  alias Snitch.Data.Schema.Product, as: ProductSchema

  use Snitch.Data.Model

  @moduledoc """
  API Boundary for Product related business logic
  """

  @doc """
  List all the products with searching

  TODO: Add support for search and paginate using rummage
  """
  @spec get_all(map()) :: [ProductSchema.t()]
  def get_all(params \\ %{}) do
    get_all_products(params)
  end

  def get_all(params = %{per: _per, page: _page, search_term: _search_term}) do
    get_all_products(params)
  end

  defp get_all_products(params \\ %{}) do
    Model.Product.get_all(params)
  end
end
