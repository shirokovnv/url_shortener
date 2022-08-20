defmodule UrlShortenerWeb.UrlView do
  use UrlShortenerWeb, :view

  def render("show.json", %{url: url}) do
    %{
      short_url: Enum.join([UrlShortenerWeb.Endpoint.url(), "/", url.id])
    }
  end
end
