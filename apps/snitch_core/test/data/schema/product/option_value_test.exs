defmodule Snitch.Data.Schema.OptionValueTest do
  use ExUnit.Case, async: true
  use Snitch.DataCase

  alias Snitch.Data.Schema.OptionValue, as: OptionValueSchema

  import Snitch.Factory

  @option_value_params %{
    name: "small",
    display_name: "Small"
  }

  @option_type_params %{
    option_type_id: 1
  }

  test "changeset is invalid without option type" do
    invalid_changeset = create_changeset(@option_value_params)

    assert invalid_changeset.valid? == false
    assert Kernel.length(invalid_changeset.errors) == 1
  end

  test "changeset is invalid without params" do
    invalid_changeset = create_changeset(@option_type_params)

    assert invalid_changeset.valid? == false
    assert Kernel.length(invalid_changeset.errors) == 2
  end

  test "valid changeset with correct params" do
    valid_params = Map.merge(@option_value_params, @option_type_params)

    valid_changeset = create_changeset(valid_params)

    assert valid_changeset.valid? == true
    assert Kernel.length(valid_changeset.errors) == 0
  end

  defp create_changeset(params) do
    %OptionValueSchema{}
    |> OptionValueSchema.create_changeset(params)
  end
end
