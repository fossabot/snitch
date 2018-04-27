defmodule Snitch.Data.Schema.Property do
  @moduledoc ~S"""
  Properties are the basic properties of the product like make etc.

  They don't affect variant numbers in any way.

  """

  use Snitch.Data.Schema
  import Ecto.Changeset

  alias Snitch.Data.Schema.Property

  @type t :: %__MODULE__{}

  schema "snitch_properties" do
    field(:name, :string)
    field(:display_name, :string, null: false)
    timestamps()
  end

  def changeset(%Property{} = property, params \\ %{}) do
    property
    |> cast(params, [:name, :display_name])
    |> validate_required([:name, :display_name])
  end
end
