defmodule Snitch.Data.Model.PeropertyTest do
  use Elixir.Case, async: true
  use Snitch.DataCase

  alias Snitch.Data.Model.Property, as: PropertyModel
  import Snitch.Factory

  describe "create" do
    test "fails for wrong params"
    test "succeeds for correct params"
  end

  describe "update" do
    test "fails for wrong params"
    test "succeeds for correct params"
  end

  describe "get" do
    test "returns nil if property relation is not present in db"
    test "returns a property with an id"
  end

  describe "get_all" do
    test "returns list of properties"
    test "returns empty list if properties are not present in db"
  end
end
