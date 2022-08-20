defmodule UrlShortener.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortener.Links` context.
  """

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        long_url: "https://example.com"
      })
      |> UrlShortener.Links.create_url()

    url
  end
end
