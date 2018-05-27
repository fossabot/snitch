defmodule Snitch.Data.Schema.Product do
  @moduledoc """
  Product API and utilities.
  """
  use Snitch.Data.Schema

  @type t :: %__MODULE__{}

  schema "snitch_products" do
    field(:name, :string, null: false, default: "")
    field(:available_on, :utc_datetime)
    field(:deleted_at, :utc_datetime)
    field(:discontinue_on, :utc_datetime)
    field(:slug, :string)
    field(:meta_description, :string)
    field(:meta_keywords, :string)
    field(:meta_title, :string)
    field(:promotionable, :boolean)
    timestamps()
  end

  @required_fields ~w(name)

  def changeset(model, params \\ {}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
