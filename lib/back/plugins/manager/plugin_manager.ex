defmodule Back.Plugins.Manager.PluginManager do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "plugin_manager" do
    field :automaton, :binary_id
    field :visual, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(plugin_manager, attrs) do
    plugin_manager
    |> cast(attrs, [])
    |> validate_required([])
  end
end
