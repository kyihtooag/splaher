defmodule Splash.Unsplash do
  use Tesla

  plug Tesla.Middleware.JSON

  @url "https://api.unsplash.com/collections/220388/photos?per_page=50&client_id=WSefC4fm68ZsPlFPll9BD6qatQOdgH9N6wPgFTuh9lA"

  @spec get_image_urls_list :: :failed | [any]
  def get_image_urls_list() do
    case get(@url) do
      {:ok, response} ->
        decode_response(response)
      {:error, :timeout} ->
        :failed
      {:error, _reason} ->
        :failed
    end
  end

  defp decode_response(response) do
    %{body: body} = response
    Enum.map(
      body,
      fn x ->
        x["urls"]["raw"]
    end)
  end
end
