defmodule Back.Repo.Migrations.AutomatonTagUniqueConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:automaton_tag, [:tag_id, :automaton_id],
             name: :automaton_tag_unique_index
           )
  end
end
