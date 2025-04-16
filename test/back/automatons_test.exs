defmodule Back.AutomatonsTest do
  use Back.DataCase

  alias Back.Automatons

  describe "automaton" do
    alias Back.Automatons.Automaton

    import Back.AutomatonsFixtures

    @invalid_attrs %{name: nil, description: nil, automaton_id: nil, contents: nil}

    test "list_automaton/0 returns all automaton" do
      automaton = automaton_fixture()
      assert Automatons.list_automaton() == [automaton]
    end

    test "get_automaton!/1 returns the automaton with given id" do
      automaton = automaton_fixture()
      assert Automatons.get_automaton!(automaton.id) == automaton
    end

    test "create_automaton/1 with valid data creates a automaton" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        automaton_id: "some automaton_id",
        contents: "some contents"
      }

      assert {:ok, %Automaton{} = automaton} = Automatons.create_automaton(valid_attrs)
      assert automaton.name == "some name"
      assert automaton.description == "some description"
      assert automaton.automaton_id == "some automaton_id"
      assert automaton.contents == "some contents"
    end

    test "create_automaton/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Automatons.create_automaton(@invalid_attrs)
    end

    test "update_automaton/2 with valid data updates the automaton" do
      automaton = automaton_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        automaton_id: "some updated automaton_id",
        contents: "some updated contents"
      }

      assert {:ok, %Automaton{} = automaton} =
               Automatons.update_automaton(automaton, update_attrs)

      assert automaton.name == "some updated name"
      assert automaton.description == "some updated description"
      assert automaton.automaton_id == "some updated automaton_id"
      assert automaton.contents == "some updated contents"
    end

    test "update_automaton/2 with invalid data returns error changeset" do
      automaton = automaton_fixture()
      assert {:error, %Ecto.Changeset{}} = Automatons.update_automaton(automaton, @invalid_attrs)
      assert automaton == Automatons.get_automaton!(automaton.id)
    end

    test "delete_automaton/1 deletes the automaton" do
      automaton = automaton_fixture()
      assert {:ok, %Automaton{}} = Automatons.delete_automaton(automaton)
      assert_raise Ecto.NoResultsError, fn -> Automatons.get_automaton!(automaton.id) end
    end

    test "change_automaton/1 returns a automaton changeset" do
      automaton = automaton_fixture()
      assert %Ecto.Changeset{} = Automatons.change_automaton(automaton)
    end
  end
end
