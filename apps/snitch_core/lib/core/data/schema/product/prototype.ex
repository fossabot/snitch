defmodule Snitch.Data.Schema.Prototype do
  @moduledoc ~S"""
  Prototype helps store template for product, properties, option types and 
  taxons.
  """
  use Snitch.Data.Schema
  import Ecto.{Changeset, Query}
  alias Snitch.Data.Schema.{OptionType, Prototype, Property}
  alias Core.Repo

  @type t :: %__MODULE__{}

  schema "snitch_prototypes" do
    field(:name, :string)

    many_to_many(
      :properties,
      Property,
      join_through: "snitch_property_prototypes",
      on_delete: :delete_all,
      on_replace: :delete
    )

    many_to_many(
      :option_types,
      OptionType,
      join_through: "snitch_option_type_prototypes",
      on_delete: :delete_all,
      on_replace: :delete
    )

    timestamps()
  end

  @doc """
  Returns changeset to create prototype along with `option types`, `properties`,
  `taxons`.

  All the records option types, properties and taxons should already be created.

    iex> params = %{
      name: 'Mug', 
      option_type_ids: [1, 2], 
      property_ids: [1, 2], 
      taxon_ids: [1, 2, 3]
    }
  """
  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%Prototype{} = prototype, params \\ %{}) do
    {:ok, option_type_ids} = Map.fetch(params, :option_type_ids)
    {:ok, property_ids} = Map.fetch(params, :property_ids)

    prototype
    |> cast(params, [:name])
    |> validate_required([:name])
    |> put_assoc(:option_types, parse_option_types(option_type_ids))
    |> put_assoc(:properties, parse_properties(property_ids))
  end

  def parse_properties([]), do: []

  def parse_properties(property_ids) do
    Repo.all(from(props in Property, where: props.id in ^property_ids))
  end

  defp parse_option_types([]), do: []

  defp parse_option_types(option_type_ids) do
    Repo.all(from(ot in OptionType, where: ot.id in ^option_type_ids))
  end
end
