defmodule BackWeb.PostJSON do
  alias Back.Posts.Post

  @doc """
  Renders a list of post.
  """
  def index(%{post: post}) do
    %{data: for(post <- post, do: data(post))}
  end

  @doc """
  Renders a single post.
  """
  def show(%{post: post}) do
    %{data: data(post)}
  end

  defp data(%Post{} = post) do
    %{
      post_id: post.post_id,
      edited: post.edited,
      title: post.title,
      contents: post.contents
    }
  end
end
