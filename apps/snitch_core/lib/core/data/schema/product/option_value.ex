defmodule Snitch.Data.Schema.OptionValue do
  @moduledoc ~S"""
  Option Type are the properties which decide the 
  variants of a the products.

  Size and Colour would become option types of a product
  """

  use Snitch.Data.Schema
  import Ecto.Changeset
  alias Snitch.Data.Schema.{OptionType, OptionValue}

  @type t :: %__MODULE__{}

  schema "snitch_option_values" do
    field(:name, :string)
    field(:display_name, :string, null: false)
    field(:position, :integer, default: 0)

    belongs_to(:option_type, OptionType)
    timestamps()
  end

  @required_fields ~w(name display_name option_type_id)a

  @doc """
  Creates a changeset for creating option value.

  Raises an error if option type supplied does not exist.

  params = %{name: "S", display_name: "Small", option_type_id: 1}
  """
  @spec changeset(__MODULE__.t(), map) :: Ecto.Changeset.t()
  def changeset(%OptionValue{} = option_value, params \\ %{}) do
    option_value
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:option_type_id)
  end
end
