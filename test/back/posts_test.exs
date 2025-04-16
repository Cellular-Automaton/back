defmodule Back.PostsTest do
  use Back.DataCase

  alias Back.Posts

  describe "post" do
    alias Back.Posts.Post

    import Back.PostsFixtures

    @invalid_attrs %{title: nil, post_id: nil, edited: nil, contents: nil, posted_by: nil, viewed_by: nil, liked_by: nil, disliked_by: nil}

    test "list_post/0 returns all post" do
      post = post_fixture()
      assert Posts.list_post() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{title: "some title", post_id: "some post_id", edited: true, contents: "some contents", posted_by: "some posted_by", viewed_by: "some viewed_by", liked_by: "some liked_by", disliked_by: "some disliked_by"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.title == "some title"
      assert post.post_id == "some post_id"
      assert post.edited == true
      assert post.contents == "some contents"
      assert post.posted_by == "some posted_by"
      assert post.viewed_by == "some viewed_by"
      assert post.liked_by == "some liked_by"
      assert post.disliked_by == "some disliked_by"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{title: "some updated title", post_id: "some updated post_id", edited: false, contents: "some updated contents", posted_by: "some updated posted_by", viewed_by: "some updated viewed_by", liked_by: "some updated liked_by", disliked_by: "some updated disliked_by"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.title == "some updated title"
      assert post.post_id == "some updated post_id"
      assert post.edited == false
      assert post.contents == "some updated contents"
      assert post.posted_by == "some updated posted_by"
      assert post.viewed_by == "some updated viewed_by"
      assert post.liked_by == "some updated liked_by"
      assert post.disliked_by == "some updated disliked_by"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end

  describe "post" do
    alias Back.Posts.Post

    import Back.PostsFixtures

    @invalid_attrs %{title: nil, post_id: nil, edited: nil, contents: nil}

    test "list_post/0 returns all post" do
      post = post_fixture()
      assert Posts.list_post() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{title: "some title", post_id: "some post_id", edited: true, contents: "some contents"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.title == "some title"
      assert post.post_id == "some post_id"
      assert post.edited == true
      assert post.contents == "some contents"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{title: "some updated title", post_id: "some updated post_id", edited: false, contents: "some updated contents"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.title == "some updated title"
      assert post.post_id == "some updated post_id"
      assert post.edited == false
      assert post.contents == "some updated contents"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
