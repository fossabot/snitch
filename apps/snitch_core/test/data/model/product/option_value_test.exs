defmodule Snitch.Data.Model.OptionValueTest do
  use ExUnit.Case, async: true
  use Snitch.DataCase

  alias Snitch.Data.Model.OptionValue

  import Snitch.Factory

  @params %{
    name: "small",
    display_name: "Small"
  }

  setup :option_types

  test "with valid attdsas", %{option_type: option_type} do
    {:ok, option_value} = OptionValue.create(@params, option_type.id)
  end
end
