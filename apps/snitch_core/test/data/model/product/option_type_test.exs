defmodule Snitch.Data.Model.OptionTypeTest do
  use ExUnit.Case, async: true
  use Snitch.DataCase

  alias Snitch.Data.Model.OptionType, as: OptionTypeModel

  import Snitch.Factory

  @invalid_params %{
    name: "size"
  }

  @valid_params %{
    name: "size",
    display_name: "Size"
  }

  describe "create" do
    test "fails with invalid params" do
      {:error, changeset} = OptionTypeModel.create(@invalid_params)

      refute changeset.valid?
      assert {"can't be blank", [validation: :required]} = changeset.errors[:display_name]
    end

    test "succeeds with valid params" do
      {:ok, ot} = OptionTypeModel.create(@valid_params)

      assert "size" = ot.name
      assert "Size" = ot.display_name
    end
  end

  describe "get" do
    setup :option_types

    test "returns nil when invalid id is passed" do
      assert nil == OptionTypeModel.get(-1)
    end

    test "returns valid record when query with id", %{option_type: option_type} do
      ot = OptionTypeModel.get(option_type.id)
      option_type_id = option_type.id

      assert option_type_id = ot.id
    end
  end

  describe "get_all" do
    test "returns option types in db" do
      insert_list(3, :option_type)

      option_types = OptionTypeModel.get_all()
      assert 3 = Enum.count(option_types)
    end
  end

  describe "update" do
    setup :option_types

    test "succeeds with valid params", %{option_type: option_type} do
      new_name = "ashish"
      {:ok, ot} = OptionTypeModel.update(%{name: new_name}, option_type)

      assert new_name = ot.name
    end

    test "fails with invaild params", %{option_type: option_type} do
      {:error, changeset} = OptionTypeModel.update(%{name: ""}, option_type)

      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
