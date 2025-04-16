defmodule Back.AutomatonTest do
  use Back.DataCase

  alias Back.Automaton

  describe "automaton" do
    alias Back.Automaton.Posts

    import Back.AutomatonFixtures

    @invalid_attrs %{name: nil, description: nil, automaton_id: nil, contents: nil}

    test "list_automaton/0 returns all automaton" do
      posts = posts_fixture()
      assert Automaton.list_automaton() == [posts]
    end

    test "get_posts!/1 returns the posts with given id" do
      posts = posts_fixture()
      assert Automaton.get_posts!(posts.id) == posts
    end

    test "create_posts/1 with valid data creates a posts" do
      valid_attrs = %{name: "some name", description: "some description", automaton_id: "some automaton_id", contents: "some contents"}

      assert {:ok, %Posts{} = posts} = Automaton.create_posts(valid_attrs)
      assert posts.name == "some name"
      assert posts.description == "some description"
      assert posts.automaton_id == "some automaton_id"
      assert posts.contents == "some contents"
    end

    test "create_posts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Automaton.create_posts(@invalid_attrs)
    end

    test "update_posts/2 with valid data updates the posts" do
      posts = posts_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", automaton_id: "some updated automaton_id", contents: "some updated contents"}

      assert {:ok, %Posts{} = posts} = Automaton.update_posts(posts, update_attrs)
      assert posts.name == "some updated name"
      assert posts.description == "some updated description"
      assert posts.automaton_id == "some updated automaton_id"
      assert posts.contents == "some updated contents"
    end

    test "update_posts/2 with invalid data returns error changeset" do
      posts = posts_fixture()
      assert {:error, %Ecto.Changeset{}} = Automaton.update_posts(posts, @invalid_attrs)
      assert posts == Automaton.get_posts!(posts.id)
    end

    test "delete_posts/1 deletes the posts" do
      posts = posts_fixture()
      assert {:ok, %Posts{}} = Automaton.delete_posts(posts)
      assert_raise Ecto.NoResultsError, fn -> Automaton.get_posts!(posts.id) end
    end

    test "change_posts/1 returns a posts changeset" do
      posts = posts_fixture()
      assert %Ecto.Changeset{} = Automaton.change_posts(posts)
    end
  end
end
