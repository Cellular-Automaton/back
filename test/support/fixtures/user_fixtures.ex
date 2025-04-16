defmodule Back.UserFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.User` context.
  """

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
      |> Back.User.create_blocked()

    blocked
  end
end
