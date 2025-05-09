defmodule BackWeb.PostActionsJSON do
  alias Back.Posts.PostActions.PostAction

  @doc """
  Renders a list of posts_actions.
  """
  def index(%{posts_actions: posts_actions}) do
    %{data: for(post_actions <- posts_actions, do: data(post_actions))}
  end

  @doc """
  Renders a single post_actions.
  """
  def show(%{post_actions: post_actions}) do
    %{data: data(post_actions)}
  end

  defp data(%PostAction{} = post_actions) do
    %{
      id: post_actions.id,
      action: post_actions.action
    }
  end
end
