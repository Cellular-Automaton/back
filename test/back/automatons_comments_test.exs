defmodule Back.AutomatonsCommentsTest do
  use Back.DataCase

  alias Back.AutomatonsComments

  describe "automaton_comment" do
    alias Back.AutomatonsComments.AutomatonComments

    import Back.AutomatonsCommentsFixtures

    @invalid_attrs %{edited: nil, contents: nil}

    test "list_automaton_comment/0 returns all automaton_comment" do
      automaton_comments = automaton_comments_fixture()
      assert AutomatonsComments.list_automaton_comment() == [automaton_comments]
    end

    test "get_automaton_comments!/1 returns the automaton_comments with given id" do
      automaton_comments = automaton_comments_fixture()
      assert AutomatonsComments.get_automaton_comments!(automaton_comments.id) == automaton_comments
    end

    test "create_automaton_comments/1 with valid data creates a automaton_comments" do
      valid_attrs = %{edited: true, contents: "some contents"}

      assert {:ok, %AutomatonComments{} = automaton_comments} = AutomatonsComments.create_automaton_comments(valid_attrs)
      assert automaton_comments.edited == true
      assert automaton_comments.contents == "some contents"
    end

    test "create_automaton_comments/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AutomatonsComments.create_automaton_comments(@invalid_attrs)
    end

    test "update_automaton_comments/2 with valid data updates the automaton_comments" do
      automaton_comments = automaton_comments_fixture()
      update_attrs = %{edited: false, contents: "some updated contents"}

      assert {:ok, %AutomatonComments{} = automaton_comments} = AutomatonsComments.update_automaton_comments(automaton_comments, update_attrs)
      assert automaton_comments.edited == false
      assert automaton_comments.contents == "some updated contents"
    end

    test "update_automaton_comments/2 with invalid data returns error changeset" do
      automaton_comments = automaton_comments_fixture()
      assert {:error, %Ecto.Changeset{}} = AutomatonsComments.update_automaton_comments(automaton_comments, @invalid_attrs)
      assert automaton_comments == AutomatonsComments.get_automaton_comments!(automaton_comments.id)
    end

    test "delete_automaton_comments/1 deletes the automaton_comments" do
      automaton_comments = automaton_comments_fixture()
      assert {:ok, %AutomatonComments{}} = AutomatonsComments.delete_automaton_comments(automaton_comments)
      assert_raise Ecto.NoResultsError, fn -> AutomatonsComments.get_automaton_comments!(automaton_comments.id) end
    end

    test "change_automaton_comments/1 returns a automaton_comments changeset" do
      automaton_comments = automaton_comments_fixture()
      assert %Ecto.Changeset{} = AutomatonsComments.change_automaton_comments(automaton_comments)
    end
  end
end
