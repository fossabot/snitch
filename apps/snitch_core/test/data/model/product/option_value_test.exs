defmodule Snitch.Data.Model.OptionValueTest do
  use ExUnit.Case, async: true
  use Snitch.DataCase

  alias Snitch.Data.Model.OptionValue, as: OptionValueModel
  import Snitch.Factory

  @ov_params %{
    name: "small",
    display_name: "Small"
  }

  setup :option_types

  describe "create" do
    test "with missing option_type_id fails", %{option_type: option_type} do
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

      assert "small" = option_value.name
      assert "Small" = option_value.display_name
      assert option_type_id = option_value.option_type_id
    end
  end
end
