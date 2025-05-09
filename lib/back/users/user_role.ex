defmodule Back.Users.UserRole do
  @user_roles [:admin, :developer, :user]

  def values, do: @user_roles

  def valid?(value), do: value in @user_roles
end
