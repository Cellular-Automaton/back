defmodule Back.UserAction.Blocked do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blocked" do
    field :blocked_id, :string
    field :time_unblock, :naive_datetime
    field :blocked_at, :naive_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(blocked, attrs) do
    blocked
    |> cast(attrs, [:blocked_id, :time_unblock, :blocked_at])
    |> validate_required([:blocked_id, :time_unblock, :blocked_at])
  end
end
