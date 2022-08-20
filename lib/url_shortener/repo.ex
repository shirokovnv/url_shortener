defmodule UrlShortener.Repo do
  use Ecto.Repo,
    otp_app: :url_shortener,
    adapter: Ecto.Adapters.Postgres

  def init(_, config) do
    env = Application.get_env(:url_shortener, __MODULE__)

    config =
      config
      |> Keyword.put(:username, System.get_env("PGUSER", env[:username]))
      |> Keyword.put(:password, System.get_env("PGPASSWORD", env[:password]))
      |> Keyword.put(:database, System.get_env("PGDATABASE", env[:database]))
      |> Keyword.put(:hostname, System.get_env("PGHOST", env[:hostname]))
      |> Keyword.put(
        :port,
        System.get_env("PGPORT", to_string(env[:port])) |> String.to_integer()
      )

    {:ok, config}
  end
end
