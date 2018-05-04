defmodule Snitch.Data.Model.OptionValue do
  @moduledoc """
  # 
  """
  use Snitch.Data.Model
  alias Snitch.Data.Schema.OptionValue, as: OptionValueSchema

  @doc """
  Create a new `OptionValue`

    > params = %{
    >  name: "Tshirt-size"
    >  display_name: "Size"
    >  option_type_id: 1
    > }
  """
  @spec create(map()) :: term
  def create(params) do
    QH.create(
      OptionValueSchema,
      params,
      Repo
    )
  end

  @doc """
  Fetches all the `OptionValues`
  """
  @spec get_all() :: list(OptionValue.t())
  def get_all, do: Repo.all(OptionValueSchema)
end
