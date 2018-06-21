defmodule Snitch.Domain.AccountTest do
  use ExUnit.Case
  use Snitch.DataCase
  import Snitch.Factory

  alias Snitch.Domain.Account

  @params %{
    email: "superman@himalya.com",
    first_name: "Super",
    last_name: "Man",
    password: "supergirl",
    password_confirmation: "supergirl"
  }

  test "register user successfully" do
    {:ok, user} = Account.register(@params)
  end

  test "registration failed missing params" do
    params = Map.drop(@params, [:email])
    {:error, changeset} = Account.register(params)
    assert %{email: ["can't be blank"]} = errors_on(changeset)
  end

  test "user authenticated successfully" do
    assert {:ok, user} = Account.register(@params)
    {:ok, user} = Account.authenticate(@params.email, @params.password)
  end

  test "user unauthenticated bad email" do
    assert {:ok, user} = Account.register(@params)
    {:error, message} = Account.authenticate("tony@stark.com", @params.password)
    assert message == :not_found
  end

  test "user unauthenticated bad password" do
    assert {:ok, user} = Account.register(@params)
    {:error, message} = Account.authenticate(@params.email, "catwoman")
    assert message == :not_found
  end
end
