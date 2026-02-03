defmodule Back.Repo.Migrations.ChangePluginCascadeDeleteInPluginManager do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE plugin_manager DROP CONSTRAINT IF EXISTS plugin_manager_automaton_fkey"

    execute """
    ALTER TABLE plugin_manager
    ADD CONSTRAINT plugin_manager_automaton_fkey
    FOREIGN KEY (automaton)
    REFERENCES automaton(automaton_id)
    ON DELETE CASCADE
    """
  end

  def down do
    execute "ALTER TABLE plugin_manager DROP CONSTRAINT IF EXISTS plugin_manager_automaton_fkey"

    execute """
    ALTER TABLE plugin_manager
    ADD CONSTRAINT plugin_manager_automaton_fkey
    FOREIGN KEY (automaton)
    REFERENCES automaton(automaton_id)
    ON DELETE NO ACTION
    """
  end
end
