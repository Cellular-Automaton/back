defmodule BackWeb.AuthController do
  use BackWeb, :controller

  alias Back.{Users, Users.Guardian}

  action_fallback BackWeb.FallbackController

  def login(conn, %{"email" => email, "password" => password}) do
    Users.authenticate_user(email, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()

    send_resp(conn, :no_content, "")
  end

  # docs are not applicable here

  defp login_reply(res, conn) do
    with {:ok, user} <- res do
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
