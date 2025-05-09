defmodule Back.Repo.Migrations.ChangeDatetimeUser do
  use Ecto.Migration
  import Ecto.Query

  def up do
    alter table(:user) do
      remove_if_exists :created_at
    end

    alter table(:user) do
      add :created_at, :timestamp, default: fragment("now()")
    end
  end

  def down do
    alter table(:user) do
      modify :created_at, :string
    end
  end
end
