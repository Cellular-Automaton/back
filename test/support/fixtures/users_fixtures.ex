defmodule Back.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        created_at: "some created_at",
        email: "some email",
        phone: "some phone",
        user_id: "some user_id",
        username: "some username",
        verified: true
      })
      |> Back.Users.create_user()

    user
  end

  @doc """
  Generate a blocked.
  """
  def blocked_fixture(attrs \\ %{}) do
    {:ok, blocked} =
      attrs
      |> Enum.into(%{
        blocked_at: ~N[2025-04-15 18:02:00],
        blocked_id: "some blocked_id",
        time_unblock: ~N[2025-04-15 18:02:00]
      })
      |> Back.Users.create_blocked()

    blocked
  end
end
