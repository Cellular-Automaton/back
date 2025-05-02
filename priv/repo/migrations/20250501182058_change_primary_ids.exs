defmodule Back.Repo.Migrations.ChangePrimaryIds do
  use Ecto.Migration

  # update every id (that was auto-generated) to {table_name}_id except for table user
  def change do
    # create unique constraints to ids

    # drop foreign key constraints

    # update foreign keys in tables

    # delete :id and change :{table}_id to primary key
  end
end
