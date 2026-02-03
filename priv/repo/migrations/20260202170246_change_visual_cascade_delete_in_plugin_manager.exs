defmodule Back.Repo.Migrations.ChangeVisualCascadeDeleteInPluginManager do
  use Ecto.Migration

  def up do
    drop constraint(:plugin_manager, "plugin_manager_visual_fkey")
    alter table(:plugin_manager) do
      modify :visual, references(:visuals, on_delete: :delete_all, type: :binary_id)
    end
  end

  def down do
    drop constraint(:plugin_manager, "plugin_manager_visual_fkey")

    alter table(:plugin_manager) do
      modify :visual, references(:visuals, on_delete: :restrict, type: :binary_id)
    end
  end
end
