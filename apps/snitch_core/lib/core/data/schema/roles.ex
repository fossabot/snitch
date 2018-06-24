defmodule Snitch.Data.Schema.Role do
  @moduledoc """
  Models the User Roles.
  """

  @type t :: %__MODULE__{}

  use Snitch.Data.Schema
  alias Snitch.Data.Schema.{User, Permission}

  schema "snitch_roles" do
    # associations
    has_many(:users, User)
    many_to_many(:permissions, Permission, join_through: "role_permissions")

    field(:name, :string)
    field(:description, :string)

    timestamps()
  end

  @required_params ~w(name)a
  @optional_params ~w(description)a
  @create_params @required_params ++ @optional_params
  @update_params @required_params ++ @optional_params

  @doc """
  Returns a changeset to create a new `role`.
  """
  @spec create_changeset(t, map) :: Ecto.Changeset.t()
  def create_changeset(%__MODULE__{} = role, params) do
    role
    |> cast(params, @create_params)
    |> common_changeset()
  end

  @doc """
  Returns a changeset to update a `role`.
  """
  @spec update_changeset(t, map) :: Ecto.Changeset.t()
  def update_changeset(%__MODULE__{} = role, params) do
    role
    |> cast(params, @update_params)
    |> common_changeset()
  end

  defp common_changeset(changeset) do
    changeset
    |> validate_required(@required_params)
    |> unique_constraint(:name)
  end
end
