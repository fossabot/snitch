defmodule Snitch.Data.Schema.OptionType do
  @moduledoc ~S"""
  Option Type are the properties which decide the 
  variants of a the products.

  Size and Colour would become option types of a product
  """

  use Snitch.Data.Schema
  import Ecto.Changeset

  alias Snitch.Data.Schema.{OptionValue, OptionType, Prototype}

  @type t :: %__MODULE__{}

  schema "snitch_option_types" do
    field(:name, :string)
    field(:display_name, :string, null: false)

    has_many(:option_values, OptionValue)
    many_to_many(:prototypes, Prototype, join_through: :snitch_option_type_prototypes)

    timestamps()
  end

  @doc """
  Creates a changeset for creating option type.

  params = %{name: "size", display_name: "Size"}
  """
  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%OptionType{} = option_type, params \\ %{}) do
    option_type
    |> cast(params, [:name, :display_name])
    |> validate_required([:name, :display_name])
  end
end
