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
      # password: user.password, # NOTE: shouldn't be available for public data (or maybe crypted)
      user_role: user.user_role,
      email: user.email,
      phone: user.phone,
      created_at: user.created_at,
      verified: user.verified
    }
  end
end
