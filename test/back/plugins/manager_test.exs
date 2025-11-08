defmodule Back.Plugins.ManagerTest do
  use Back.DataCase

  alias Back.Plugins.Manager

  describe "plugin_manager" do
    alias Back.Plugins.Manager.PluginManager

    import Back.Plugins.ManagerFixtures

    @invalid_attrs %{}

    test "list_plugin_manager/0 returns all plugin_manager" do
      plugin_manager = plugin_manager_fixture()
      assert Manager.list_plugin_manager() == [plugin_manager]
    end

    test "get_plugin_manager!/1 returns the plugin_manager with given id" do
      plugin_manager = plugin_manager_fixture()
      assert Manager.get_plugin_manager!(plugin_manager.id) == plugin_manager
    end

    test "create_plugin_manager/1 with valid data creates a plugin_manager" do
      valid_attrs = %{}

      assert {:ok, %PluginManager{} = plugin_manager} = Manager.create_plugin_manager(valid_attrs)
    end

    test "create_plugin_manager/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Manager.create_plugin_manager(@invalid_attrs)
    end

    test "update_plugin_manager/2 with valid data updates the plugin_manager" do
      plugin_manager = plugin_manager_fixture()
      update_attrs = %{}

      assert {:ok, %PluginManager{} = plugin_manager} =
               Manager.update_plugin_manager(plugin_manager, update_attrs)
    end

    test "update_plugin_manager/2 with invalid data returns error changeset" do
      plugin_manager = plugin_manager_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Manager.update_plugin_manager(plugin_manager, @invalid_attrs)

      assert plugin_manager == Manager.get_plugin_manager!(plugin_manager.id)
    end

    test "delete_plugin_manager/1 deletes the plugin_manager" do
      plugin_manager = plugin_manager_fixture()
      assert {:ok, %PluginManager{}} = Manager.delete_plugin_manager(plugin_manager)
      assert_raise Ecto.NoResultsError, fn -> Manager.get_plugin_manager!(plugin_manager.id) end
    end

    test "change_plugin_manager/1 returns a plugin_manager changeset" do
      plugin_manager = plugin_manager_fixture()
      assert %Ecto.Changeset{} = Manager.change_plugin_manager(plugin_manager)
    end
  end
end
