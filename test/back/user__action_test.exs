defmodule Back.User_ActionTest do
  use Back.DataCase

  alias Back.User_Action

  describe "blocked" do
    alias Back.User_Action.Blocked

    import Back.User_ActionFixtures

    @invalid_attrs %{blocked_id: nil, time_unblock: nil, blocked_at: nil}

    test "list_blocked/0 returns all blocked" do
      blocked = blocked_fixture()
      assert User_Action.list_blocked() == [blocked]
    end

    test "get_blocked!/1 returns the blocked with given id" do
      blocked = blocked_fixture()
      assert User_Action.get_blocked!(blocked.id) == blocked
    end

    test "create_blocked/1 with valid data creates a blocked" do
      valid_attrs = %{
        blocked_id: "some blocked_id",
        time_unblock: ~N[2025-04-15 18:03:00],
        blocked_at: ~N[2025-04-15 18:03:00]
      }

      assert {:ok, %Blocked{} = blocked} = User_Action.create_blocked(valid_attrs)
      assert blocked.blocked_id == "some blocked_id"
      assert blocked.time_unblock == ~N[2025-04-15 18:03:00]
      assert blocked.blocked_at == ~N[2025-04-15 18:03:00]
    end

    test "create_blocked/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User_Action.create_blocked(@invalid_attrs)
    end

    test "update_blocked/2 with valid data updates the blocked" do
      blocked = blocked_fixture()

      update_attrs = %{
        blocked_id: "some updated blocked_id",
        time_unblock: ~N[2025-04-16 18:03:00],
        blocked_at: ~N[2025-04-16 18:03:00]
      }

      assert {:ok, %Blocked{} = blocked} = User_Action.update_blocked(blocked, update_attrs)
      assert blocked.blocked_id == "some updated blocked_id"
      assert blocked.time_unblock == ~N[2025-04-16 18:03:00]
      assert blocked.blocked_at == ~N[2025-04-16 18:03:00]
    end

    test "update_blocked/2 with invalid data returns error changeset" do
      blocked = blocked_fixture()
      assert {:error, %Ecto.Changeset{}} = User_Action.update_blocked(blocked, @invalid_attrs)
      assert blocked == User_Action.get_blocked!(blocked.id)
    end

    test "delete_blocked/1 deletes the blocked" do
      blocked = blocked_fixture()
      assert {:ok, %Blocked{}} = User_Action.delete_blocked(blocked)
      assert_raise Ecto.NoResultsError, fn -> User_Action.get_blocked!(blocked.id) end
    end

    test "change_blocked/1 returns a blocked changeset" do
      blocked = blocked_fixture()
      assert %Ecto.Changeset{} = User_Action.change_blocked(blocked)
    end
  end
end
