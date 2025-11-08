defmodule Back.Automatons.AutomatonTagsTest do
  use Back.DataCase

  alias Back.Automatons.AutomatonTags

  describe "automaton_tag" do
    alias Back.Automatons.AutomatonTags.AutomatonTag

    import Back.Automatons.AutomatonTagsFixtures

    @invalid_attrs %{tag_id: nil}

    test "list_automaton_tag/0 returns all automaton_tag" do
      automaton_tag = automaton_tag_fixture()
      assert AutomatonTags.list_automaton_tag() == [automaton_tag]
    end

    test "get_automaton_tag!/1 returns the automaton_tag with given id" do
      automaton_tag = automaton_tag_fixture()
      assert AutomatonTags.get_automaton_tag!(automaton_tag.id) == automaton_tag
    end

    test "create_automaton_tag/1 with valid data creates a automaton_tag" do
      valid_attrs = %{}

      assert {:ok, %AutomatonTag{} = _automaton_tag} =
               AutomatonTags.create_automaton_tag(valid_attrs)
    end

    # NOTE: don't have data to change
    @tag :skip
    test "create_automaton_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AutomatonTags.create_automaton_tag(@invalid_attrs)
    end

    # NOTE: don't have data to change
    @tag :skip
    test "update_automaton_tag/2 with valid data updates the automaton_tag" do
      automaton_tag = automaton_tag_fixture()
      update_attrs = %{}

      assert {:ok, %AutomatonTag{} = _automaton_tag} =
               AutomatonTags.update_automaton_tag(automaton_tag, update_attrs)
    end

    # NOTE: don't have data to change
    @tag :skip
    test "update_automaton_tag/2 with invalid data returns error changeset" do
      automaton_tag = automaton_tag_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AutomatonTags.update_automaton_tag(automaton_tag, @invalid_attrs)

      assert automaton_tag == AutomatonTags.get_automaton_tag!(automaton_tag.id)
    end

    test "delete_automaton_tag/1 deletes the automaton_tag" do
      automaton_tag = automaton_tag_fixture()
      assert {:ok, %AutomatonTag{}} = AutomatonTags.delete_automaton_tag(automaton_tag)

      assert_raise Ecto.NoResultsError, fn ->
        AutomatonTags.get_automaton_tag!(automaton_tag.id)
      end
    end

    test "change_automaton_tag/1 returns a automaton_tag changeset" do
      automaton_tag = automaton_tag_fixture()
      assert %Ecto.Changeset{} = AutomatonTags.change_automaton_tag(automaton_tag)
    end
  end
end
