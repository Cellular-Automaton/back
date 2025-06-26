defmodule BackWeb.AuthJSON do
  def login(%{token: token}) do
    %{token: token}
  end

  def error(%{error: error}) do
    %{error: error}
  end
end
