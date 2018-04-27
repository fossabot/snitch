defmodule Snitch.Data.Schema.PropertyPrototype do
  @moduledoc ~S"""
  Intermediate table between Properties and Prototypes relations

  """
  use Snitch.Data.Schema
  import Ecto.Changeset
  alias Snitch.Data.Schema.{Property, Prototype, PropertyPrototype}

  @type t :: %__MODULE__{}

  schema "snitch_property_prototypes" do
    belongs_to(:property, Property)
    belongs_to(:prototype, Prototype)
  end

  @doc """
  Changeset to use when both the prototypes and properties are present

    iex> params = %{
      option_type_id: 1,
      property_type_id: 2
    } 
  """
  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%PropertyPrototype{} = property_prototype, params \\ %{}) do
    property_prototype
    |> cast(params, [:property_id, :prototype_id])
    |> validate_required([:property_id, :prototype_id])
    |> foreign_key_constraint(:property_id)
    |> foreign_key_constraint(:prototype_id)
  end
end
