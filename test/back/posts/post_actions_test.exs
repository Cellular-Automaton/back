defmodule Back.Posts.PostActionsTest do
  use Back.DataCase

  alias Back.Posts.PostActions

  describe "posts_actions" do
    alias Back.Posts.PostActions.PostActions

    import Back.Posts.PostActionsFixtures

    @invalid_attrs %{action: nil}

    test "list_posts_actions/0 returns all posts_actions" do
      post_actions = post_actions_fixture()
      assert PostActions.list_posts_actions() == [post_actions]
    end

    test "get_post_actions!/1 returns the post_actions with given id" do
      post_actions = post_actions_fixture()
      assert PostActions.get_post_actions!(post_actions.id) == post_actions
    end

    test "create_post_actions/1 with valid data creates a post_actions" do
      valid_attrs = %{action: "some action"}

      assert {:ok, %PostActions{} = post_actions} = PostActions.create_post_actions(valid_attrs)
      assert post_actions.action == "some action"
    end

    test "create_post_actions/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PostActions.create_post_actions(@invalid_attrs)
    end

    test "update_post_actions/2 with valid data updates the post_actions" do
      post_actions = post_actions_fixture()
      update_attrs = %{action: "some updated action"}

      assert {:ok, %PostActions{} = post_actions} =
               PostActions.update_post_actions(post_actions, update_attrs)

      assert post_actions.action == "some updated action"
    end

    test "update_post_actions/2 with invalid data returns error changeset" do
      post_actions = post_actions_fixture()

      assert {:error, %Ecto.Changeset{}} =
               PostActions.update_post_actions(post_actions, @invalid_attrs)

      assert post_actions == PostActions.get_post_actions!(post_actions.id)
    end

    test "delete_post_actions/1 deletes the post_actions" do
      post_actions = post_actions_fixture()
      assert {:ok, %PostActions{}} = PostActions.delete_post_actions(post_actions)
      assert_raise Ecto.NoResultsError, fn -> PostActions.get_post_actions!(post_actions.id) end
    end

    test "change_post_actions/1 returns a post_actions changeset" do
      post_actions = post_actions_fixture()
      assert %Ecto.Changeset{} = PostActions.change_post_actions(post_actions)
    end
  end
end
