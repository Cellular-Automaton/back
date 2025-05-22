defmodule Back.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:image) do
      add :contents_binary, :binary
      add :contents_type, :string

      add :user_id, references(:user, type: :binary, column: :user_id)
      add :automaton_id, references(:automaton, type: :binary, column: :automaton_id)
      timestamps(type: :utc_datetime)
    end
  end
end
