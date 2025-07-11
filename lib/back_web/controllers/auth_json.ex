defmodule BackWeb.AuthJSON do
  def login(%{token: token, user: user}) do
    %{
      token: token,
      user: %{
        mail: user.email,
        username: user.username,
        id: user.user_id
      }
    }
  end

  def login_img(%{token: token, user: user, image: image}) do
    %{
      token: token,
      user: %{
        mail: user.email,
        username: user.username,
        id: user.user_id,
        image: %{
          contents_binary: image.contents_binary,
          contents_type: image.contents_type
        }
      }
    }
  end

  def error(%{error: error}) do
    %{error: error}
  end
end
