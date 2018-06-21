defmodule AdminAppWeb.RegistrationController do
  use AdminAppWeb, :controller
  alias Snitch.Data.Schema.User
  alias Snitch.Domain.Account

  def new(conn, _params) do
    changeset = User.create_changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"registration" => registration}) do
    params = parse_registration_params(registration)

    case Account.register(params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account created!!")
        |> redirect(to: page_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Sorry there were some errors!!")
        |> render("new.html", changeset: %{changeset | action: :insert})
    end
  end

  ########## Private Functions ###################

  defp parse_registration_params(registration) do
    %{
      first_name: registration["first_name"],
      last_name: registration["last_name"],
      email: registration["email"],
      password: registration["password"],
      password_confirmation: registration["password_confirmation"]
    }
  end
end
