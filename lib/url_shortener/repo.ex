defmodule UrlShortener.Repo do
  use Ecto.Repo,
    otp_app: :url_shortener,
    adapter: Ecto.Adapters.Postgres
end
