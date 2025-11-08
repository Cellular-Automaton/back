defmodule Back.Posts.PostActionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Posts.PostActions` context.
  """

  @doc """
  Generate a post_actions.
  """
  def post_actions_fixture(attrs \\ %{}) do
    {:ok, post_actions} =
      attrs
      |> Enum.into(%{
        action: "liked"
      })
      |> Back.Posts.PostActions.create_post_actions()

    post_actions
  end
end
