defmodule Snitch.Data.Model.OptionValue do
  @moduledoc """
  # 
  """
  use Snitch.Data.Model
  alias Snitch.Data.Schema.OptionValue, as: OptionValueSchema

  @doc """
  Create a new `OptionValue`

    > name: "Tshirt-size"
      display_name: "Size"
      option_type_id: 1
  """
  @spec create(map(), non_neg_integer) :: term
  def create(%{name: name, display_name: display_name}, option_type_id) do
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

  @doc """
  Fetches all the `OptionValues`
  """
  @spec get_all() :: list(OptionValue.t())
  def get_all, do: Repo.all(OptionValueSchema)
end
