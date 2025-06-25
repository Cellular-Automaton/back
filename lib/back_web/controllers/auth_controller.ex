defmodule BackWeb.AuthController do
  use BackWeb, :controller

  alias Back.{Users, Users.User, Users.Guardian}

  action_fallback BackWeb.FallbackController

  def new(conn, _) do
    changeset = Users.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/protected")
    else
      render(conn, :login, changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    Users.authenticate_user(email, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    # and the arguments specified in the Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  # docs are not applicable here

  defp login_reply(res, conn) do
    with {:ok, user} <- res do
      IO.inspect("waaaaaa")

      token =
        conn
        |> Guardian.Plug.sign_in(%{
          email: user.email,
          password: user.password,
          user_id: user.user_id
        })

      render(conn, :login, token: token.private[:guardian_default_token])
    end
  end

  # docs are not applicable here.
end
