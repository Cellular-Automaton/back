defmodule Back.UserActionTest do
  use Back.DataCase

  alias Back.UserAction

  describe "blocked" do
    alias Back.UserAction.Blocked

    import Back.UserActionFixtures

    @invalid_attrs %{blocked_id: nil, time_unblock: nil, blocked_at: nil}

    test "list_blocked/0 returns all blocked" do
      blocked = blocked_fixture()
      assert UserAction.list_blocked() == [blocked]
    end

    test "get_blocked!/1 returns the blocked with given id" do
      blocked = blocked_fixture()
      assert UserAction.get_blocked!(blocked.id) == blocked
    end

    test "create_blocked/1 with valid data creates a blocked" do
      valid_attrs = %{blocked_id: "some blocked_id", time_unblock: ~N[2025-04-15 18:04:00], blocked_at: ~N[2025-04-15 18:04:00]}

      assert {:ok, %Blocked{} = blocked} = UserAction.create_blocked(valid_attrs)
      assert blocked.blocked_id == "some blocked_id"
      assert blocked.time_unblock == ~N[2025-04-15 18:04:00]
      assert blocked.blocked_at == ~N[2025-04-15 18:04:00]
    end

    test "create_blocked/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserAction.create_blocked(@invalid_attrs)
    end

    test "update_blocked/2 with valid data updates the blocked" do
      blocked = blocked_fixture()
      update_attrs = %{blocked_id: "some updated blocked_id", time_unblock: ~N[2025-04-16 18:04:00], blocked_at: ~N[2025-04-16 18:04:00]}

      assert {:ok, %Blocked{} = blocked} = UserAction.update_blocked(blocked, update_attrs)
      assert blocked.blocked_id == "some updated blocked_id"
      assert blocked.time_unblock == ~N[2025-04-16 18:04:00]
      assert blocked.blocked_at == ~N[2025-04-16 18:04:00]
    end

    test "update_blocked/2 with invalid data returns error changeset" do
      blocked = blocked_fixture()
      assert {:error, %Ecto.Changeset{}} = UserAction.update_blocked(blocked, @invalid_attrs)
      assert blocked == UserAction.get_blocked!(blocked.id)
    end

    test "delete_blocked/1 deletes the blocked" do
      blocked = blocked_fixture()
      assert {:ok, %Blocked{}} = UserAction.delete_blocked(blocked)
      assert_raise Ecto.NoResultsError, fn -> UserAction.get_blocked!(blocked.id) end
    end

    test "change_blocked/1 returns a blocked changeset" do
      blocked = blocked_fixture()
      assert %Ecto.Changeset{} = UserAction.change_blocked(blocked)
    end
  end
end
