defmodule BackWeb.BlockedJSON do
  alias Back.UserAction.Blocked

  @doc """
  Renders a list of blocked.
  """
  def index(%{blocked: blocked}) do
    %{data: for(blocked <- blocked, do: data(blocked))}
  end

  @doc """
  Renders a single blocked.
  """
  def show(%{blocked: blocked}) do
    %{data: data(blocked)}
  end

  defp data(%Blocked{} = blocked) do
    %{
      id: blocked.id,
      blocked_id: blocked.blocked_id,
      time_unblock: blocked.time_unblock,
      blocked_at: blocked.blocked_at
    }
  end
end
