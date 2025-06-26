defmodule BackWeb.UserJSON do
  alias Back.Users.User

  @doc """
  Renders a list of user.
  """
  def index(%{user: user}) do
    %{data: for(user <- user, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      user_id: user.user_id,
      username: user.username,
      user_role: user.user_role,
      email: user.email,
      phone: user.phone,
      created_at: user.created_at,
      verified: user.verified
    }
  end

  # same structure, with the profile picture added

  def index_picture(%{user: user}) do
    %{data: for(user <- user, do: data_picture(user))}
  end

  @doc """
  Render a user with the profile picture when needed
  """
  def show_picture(%{user: user}) do
    %{data: data_picture(user)}
  end

  defp data_picture(%{} = user) do
    %{
      user_id: user.user_id,
      username: user.username,
      user_role: user.user_role,
      email: user.email,
      phone: user.phone,
      created_at: user.created_at,
      verified: user.verified,
      profile_pic: user.profile_pic
    }
  end
end
