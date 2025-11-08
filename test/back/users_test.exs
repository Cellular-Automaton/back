defmodule Back.UsersTest do
  use Back.DataCase

  alias Back.Users

  describe "users" do
    alias Back.Users.User

    import Back.UsersFixtures

    @invalid_attrs %{
      username: nil,
      user_id: nil,
      email: nil,
      phone: nil,
      created_at: nil,
      verified: nil
    }

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.user_id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        username: "some username",
        user_role: "user",
        password: "passw",
        email: "some email",
        phone: "some phone",
        verified: true
      }

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.username == "some username"
      assert Ecto.UUID.cast(user.user_id) == {:ok, user.user_id}
      assert user.email == "some email"
      assert user.phone == "some phone"
      assert user.verified == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        username: "some updated username",
        email: "some updated email",
        phone: "some updated phone",
        verified: false
      }

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.username == "some updated username"
      assert Ecto.UUID.cast(user.user_id) == {:ok, user.user_id}
      assert user.email == "some updated email"
      assert user.phone == "some updated phone"
      assert user.verified == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.user_id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.user_id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  describe "user" do
    alias Back.Users.User

    import Back.UsersFixtures

    @invalid_attrs %{
      username: nil,
      user_id: nil,
      email: nil,
      phone: nil,
      created_at: nil,
      verified: nil
    }

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert Users.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.user_id) == user
    end

    test "create_user/1 with valid data creates a user" do
      now = DateTime.utc_now() |> DateTime.truncate(:second)

      valid_attrs = %{
        username: "some username",
        user_role: "user",
        password: "passw",
        email: "some email",
        phone: "some phone",
        created_at: now,
        verified: true
      }

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.username == "some username"
      assert Ecto.UUID.cast(user.user_id) == {:ok, user.user_id}
      assert user.email == "some email"
      assert user.phone == "some phone"
      assert user.created_at == now
      assert user.verified == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      now = DateTime.utc_now() |> DateTime.truncate(:second)

      update_attrs = %{
        username: "some updated username",
        email: "some updated email",
        phone: "some updated phone",
        created_at: now,
        verified: false
      }

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.username == "some updated username"
      assert Ecto.UUID.cast(user.user_id) == {:ok, user.user_id}
      assert user.email == "some updated email"
      assert user.phone == "some updated phone"
      assert user.created_at == now
      assert user.verified == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.user_id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.user_id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
