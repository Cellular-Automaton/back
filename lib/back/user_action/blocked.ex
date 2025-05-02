defmodule Back.UserAction.Blocked do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:blocked_id, :binary_id, autogenerate: true}
  schema "blocked" do
    field :time_unblock, :naive_datetime
    field :blocked_at, :naive_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(blocked, attrs) do
    blocked
    |> cast(attrs, [:time_unblock, :blocked_at])
    |> validate_required([:time_unblock, :blocked_at])
  end
end
