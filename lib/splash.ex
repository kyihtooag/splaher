defmodule Splash.Test do
  use GenServer

  alias Splash.Unsplash

  def start_link(_) do
    IO.puts("starting............")
    GenServer.start_link(__MODULE__, %{})
  end

  #test master

  def init(state) do
    url_list = Unsplash.get_image_urls_list

    schedule_work(url_list, 1)
    {:ok, state}
  end

  def handle_info({:work, url_list, index}, state) do

    max = length(url_list)

    IO.puts("Changing Wallpaper...")

    System.cmd("gsettings", ["set", "org.gnome.desktop.background", "picture-uri", "file:///tmp/#{index}.jpg"])

    System.cmd("rm", ["-rf", "/tmp/#{index-1}.jpg"])

    new_index =  case index == (max - 1) do
      true ->
        1
      false ->
        index + 1
    end

    schedule_work(url_list, new_index)
    {:noreply, state}
  end

  # If you want to change the schedule inverval, change it here
  defp schedule_work(url_list, index) do

    {:ok, url} = Enum.fetch(url_list, index - 1)

    IO.puts("Downloading Image................")

    System.cmd("wget", ["-O", "/tmp/#{index}.jpg", url])

    IO.puts("Download Complete.")

    Process.send_after(self(), {:work, url_list, index}, 300 * 1000)
  end

end
