defmodule BackWeb.AuthJSON do
  def login(%{token: token}) do
    IO.inspect("oui")
    %{token: token}
  end

  def error(%{error: error}) do
    %{error: error}
  end
end
