defmodule Snitch.Data.Model.OptionValueTest do
  use ExUnit.Case, async: true
  use Snitch.DataCase

  alias Snitch.Data.Model.OptionValue, as: OptionValueModel
  import Snitch.Factory

  @ov_params %{
    name: "small",
    display_name: "Small"
  }

  describe "create" do
    setup :option_type

    test "with missing option_type_id fails" do
      {:error, changeset} = OptionValueModel.create(@ov_params)

      refute changeset.valid?
      assert Kernel.length(changeset.errors) == 1
      assert %{option_type_id: ["can't be blank"]} = errors_on(changeset)
    end

    test "with missing name, display_name fails", %{option_type: option_type} do
      {:error, changeset} = OptionValueModel.create(%{option_type_id: option_type.id})

      assert 2 = Kernel.length(changeset.errors)
      assert {"can't be blank", [validation: :required]} = changeset.errors[:name]
      assert {"can't be blank", [validation: :required]} = changeset.errors[:display_name]
    end

    test "with valid attrs", %{option_type: option_type} do
      option_type_id = option_type.id
      params = Map.merge(@ov_params, %{option_type_id: option_type.id})
      {:ok, option_value} = OptionValueModel.create(params)

      assert "small" == option_value.name
      assert "Small" == option_value.display_name
      assert option_type_id == option_value.option_type_id
    end
  end

  describe "update" do
    setup :option_type
    setup :option_values

    test "fails with invalid params", %{option_values: option_values} do
      [option_value] = Enum.take(option_values, 1)
      {:error, changeset} = OptionValueModel.update(%{name: ""}, option_value)

      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "succeeds with correct params", %{option_values: option_values} do
      new_name = "xtra small"
      [option_value] = Enum.take(option_values, 1)
      {:ok, option_value} = OptionValueModel.update(%{name: new_name}, option_value)

      assert new_name == option_value.name
    end
  end

  describe "get" do
    setup :option_type
    setup :option_values

    test "returns nil for relation not present in db" do
      assert nil == OptionValueModel.get(-1)
    end

    test "returns the relation present in db", %{option_values: option_values} do
      [option_value] = Enum.take(option_values, 1)
      option_value_id = option_value.id
      ov = OptionValueModel.get(option_value_id)

      assert option_value_id == ov.id
    end
  end

  describe "get_all" do
    setup :option_type
    setup :option_values

    @tag option_value_count: 0
    test "returns an empty list for no relations present in db" do
      option_values = OptionValueModel.get_all()
      assert Enum.empty?(option_values)
    end

    @tag option_value_count: 3
    test "returns an array of relations present in db" do
      option_values = OptionValueModel.get_all()

      refute Enum.empty?(option_values)
    end
  end
end
