defmodule Snitch.Data.Schema.OptionTypeTest do
  use ExUnit.Case, async: true
  use Snitch.DataCase

  alias Snitch.Data.Schema.OptionType, as: OptionTypeSchema

  import Snitch.Factory

  @valid_option_type_params %{
    name: "size",
    display_name: "Size"
  }

  @invalid_option_type_params %{
    display_name: "Size"
  }

  describe "invalid" do
    test "option value changeset for missing params" do
      invalid_changeset = %OptionTypeSchema{}
                            |> OptionTypeSchema.create_changeset(@invalid_option_type_params)

      refute invalid_changeset.valid?
      assert Kernel.length(invalid_changeset.errors) == 1
      assert {"can't be blank", [validation: :required]} = invalid_changeset.errors[:name]
    end
  end

  describe "valid" do
    test "option value changeset with correct params" do
      changeset = %OptionTypeSchema{}
                    |> OptionTypeSchema.create_changeset(@valid_option_type_params)

      assert true = changeset.valid?
      assert "size" = changeset.changes.name
      assert "Size" = changeset.changes.display_name
    end
  end
end
