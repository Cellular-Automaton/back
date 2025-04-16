defmodule Back.User_ActionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.User_Action` context.
  """

  @doc """
  Generate a blocked.
  """
  def blocked_fixture(attrs \\ %{}) do
    {:ok, blocked} =
      attrs
      |> Enum.into(%{
        blocked_at: ~N[2025-04-15 18:03:00],
        blocked_id: "some blocked_id",
        time_unblock: ~N[2025-04-15 18:03:00]
      })
      |> Back.User_Action.create_blocked()

    blocked
  end
end
