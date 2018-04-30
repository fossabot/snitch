defmodule Snitch.Data.Model.OptionValue do
  @moduledoc """
  # 
  """
  use Snitch.Data.Model
  alias Snitch.Data.Schema.OptionValue, as: OptionValueSchema

  @doc """
  Create a new `OptionValue` 
  """
  @spec create(String.t(), String.t(), non_neg_integer) :: term
  def create(name, display_name, option_type_id) do
    QH.create(
      OptionValueSchema,
      %{
        name: name,
        display_name: display_name,
        option_type_id: option_type_id
      },
      Repo
    )
  end

  # @spec get_all(map()) :: [Product.t()]
  # def get_all(params \\ %{}) do
  #   QH.get_all(Product)
  #   Schema.OptionType.get_all(params)
  # end
end
