defmodule BackWeb.AuthController do
  use BackWeb, :controller

  alias Back.{Users, Users.Guardian}
  alias Back.Data.Image

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

      with {:ok, img} <- Image.get_image_user_id(user.user_id) do
        render(conn, :login_img,
          token: token.private[:guardian_default_token],
          user: user,
          image: img
        )
      end

      conn
      |> put_status(206)
      |> render(:login, token: token.private[:guardian_default_token], user: user)
    end
  end

  # docs are not applicable here.
end
