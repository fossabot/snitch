defmodule Snitch.Data.Schema.Taxon do
  @moduledoc false
  use Snitch.Data.Schema
  use AsNestedSet, scope: [:taxonomy_id]

  alias Snitch.Data.Schema.{Taxon, Taxonomy}

  @type t :: %__MODULE__{}

  schema "snitch_taxons" do
    field(:name, :string)
    field(:lft, :integer)
    field(:rgt, :integer)

    belongs_to(:taxonomy, Taxonomy)
    belongs_to(:parent, Taxon)
    timestamps()
  end

  @cast_fields ~w(name parent_id taxonomy_id lft rgt)

  def changeset(taxon, params) do
    cast(taxon, params, @cast_fields)
  end
end
