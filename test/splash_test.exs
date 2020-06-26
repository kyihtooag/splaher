defmodule SplashTest do
  use ExUnit.Case
  doctest Splash

  test "greets the world" do
    assert Splash.hello() == :world
  end
end
