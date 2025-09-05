defmodule Back.Repo.Migrations.ValidateAndForeignConstraint do
  use Ecto.Migration

  def change do
    drop constraint(:image, :image_automaton_id_fkey)
    drop constraint(:image, :image_user_id_fkey)
    # drop constraint(:favorite, :favorite_automaton_id_fkey)
    # drop constraint(:favorite, :favorite_user_id_fkey)
    drop constraint(:file, :file_automaton_id_fkey)
    drop constraint(:blocked, :blocked_user_id_fkey)
    drop constraint(:automaton_tag, :automaton_tag_automaton_id_fkey)
    drop constraint(:automaton_tag, :automaton_tag_tag_id_fkey)
    drop constraint(:automaton_comment, :automaton_comment_automaton_id_fkey)
    drop constraint(:comment, :comment_post_id_fkey)
    drop constraint(:posts_actions, :posts_actions_post_id_fkey)
    drop constraint(:posts_actions, :posts_actions_user_id_fkey)

    alter table(:image) do
      modify :automaton_id,
             references(:automaton, type: :binary, on_delete: :delete_all, column: :automaton_id)

      modify :user_id, references(:user, type: :binary, on_delete: :delete_all, column: :user_id)
    end

    alter table(:favorite) do
      modify :automaton_id,
             references(:automaton, type: :binary, on_delete: :delete_all, column: :automaton_id)

      modify :user_id, references(:user, type: :binary, on_delete: :delete_all, column: :user_id)
    end

    alter table(:file) do
      modify :automaton_id,
             references(:automaton, type: :binary, on_delete: :delete_all, column: :automaton_id)
    end

    alter table(:blocked) do
      modify :user_id, references(:user, type: :binary, on_delete: :delete_all, column: :user_id)
    end

    alter table(:automaton_tag) do
      modify :automaton_id,
             references(:automaton, type: :binary, on_delete: :delete_all, column: :automaton_id)

      modify :tag_id, references(:tag, type: :binary_id, on_delete: :delete_all, column: :id)
    end

    alter table(:automaton_comment) do
      modify :automaton_id,
             references(:automaton, type: :binary, on_delete: :delete_all, column: :automaton_id)
    end

    alter table(:comment) do
      modify :post_id, references(:post, type: :binary, on_delete: :delete_all, column: :post_id)
    end

    alter table(:posts_actions) do
      modify :post_id, references(:post, type: :binary, on_delete: :delete_all, column: :post_id)
      modify :user_id, references(:user, type: :binary, on_delete: :delete_all, column: :user_id)
    end
  end
end
