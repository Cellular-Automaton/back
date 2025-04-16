defmodule Back.CommentsTest do
  use Back.DataCase

  alias Back.Comments

  describe "comment" do
    alias Back.Comments.Comment

    import Back.CommentsFixtures

    @invalid_attrs %{comment_id: nil, edited: nil, contents: nil}

    test "list_comment/0 returns all comment" do
      comment = comment_fixture()
      assert Comments.list_comment() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Comments.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{comment_id: "some comment_id", edited: true, contents: "some contents"}

      assert {:ok, %Comment{} = comment} = Comments.create_comment(valid_attrs)
      assert comment.comment_id == "some comment_id"
      assert comment.edited == true
      assert comment.contents == "some contents"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comments.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{comment_id: "some updated comment_id", edited: false, contents: "some updated contents"}

      assert {:ok, %Comment{} = comment} = Comments.update_comment(comment, update_attrs)
      assert comment.comment_id == "some updated comment_id"
      assert comment.edited == false
      assert comment.contents == "some updated contents"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
      assert comment == Comments.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Comments.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Comments.change_comment(comment)
    end
  end
end
