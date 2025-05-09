defmodule Back.Repo.Migrations.CreatePostActionEnum do
  use Ecto.Migration

  @enum_name :post_action_name

  def change do
    execute(
      """
      CREATE TYPE #{@enum_name} AS ENUM (
        'liked',
        'disliked',
        'viewed'
      )
      """,
      "DROP TYPE IF EXISTS #{@enum_name}"
    )
  end
end
