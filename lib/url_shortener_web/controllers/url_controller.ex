defmodule UrlShortenerWeb.UrlController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Links
  alias UrlShortener.Links.Url

  action_fallback UrlShortenerWeb.FallbackController

  @expired_interval 60 * 60

  def create(conn, %{"long_url" => _long_url} = url_params) do
    with {:ok, %Url{} = url} <- Links.create_url(url_params),
         {:ok, true} <-
           Cachex.put(:url_cache, url.id, url.long_url, ttl: :timer.seconds(@expired_interval)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def show(conn, %{"id" => id}) do
    long_url = Cachex.get!(:url_cache, id) || fetch_and_cache_url!(id)

    redirect(conn, external: long_url)
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end

  defp fetch_and_cache_url!(id) do
    url = Links.get_url!(id)
    Cachex.put(:url_cache, id, url.long_url, ttl: :timer.seconds(@expired_interval))

    url.long_url
  end
end
