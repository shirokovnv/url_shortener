defmodule UrlShortenerWeb.UrlController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Links
  alias UrlShortener.Links.Url

  action_fallback UrlShortenerWeb.FallbackController

  def create(conn, %{"long_url" => _long_url} = url_params) do
    with {:ok, %Url{} = url} <- Links.create_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def show(conn, %{"id" => id}) do
    url = Links.get_url!(id)
    redirect(conn, external: url.long_url)
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end
end
