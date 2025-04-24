defmodule Back.UserActionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.UserAction` context.
  """

  @doc """
  Generate a blocked.
  """
  def blocked_fixture(attrs \\ %{}) do
    {:ok, blocked} =
      attrs
      |> Enum.into(%{
        blocked_at: ~N[2025-04-15 18:04:00],
        blocked_id: "some blocked_id",
        time_unblock: ~N[2025-04-15 18:04:00]
      })
      |> Back.UserAction.create_blocked()

    blocked
  end
end
