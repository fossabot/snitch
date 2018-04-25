defmodule Snitch.Data.Schema.Product do
  @moduledoc """
  Product API and utilities.
  """
  use Snitch.Data.Schema

  alias Snitch.Data.Schema.Product

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
end
