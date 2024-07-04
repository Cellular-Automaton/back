defmodule BackTest do
  use ExUnit.Case
  doctest Back

  IO.puts(Back.RustAlgoritms.add(1, 2))
  test "greets the world" do
    assert Back.hello() == :world
  end
end
