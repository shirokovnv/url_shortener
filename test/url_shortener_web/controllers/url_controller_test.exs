defmodule UrlShortenerWeb.UrlControllerTest do
  use UrlShortenerWeb.ConnCase

  import UrlShortener.LinksFixtures

  alias UrlShortener.Links.Url

  @create_attrs %{
    long_url: "https://example.com"
  }
  @invalid_attrs %{long_url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create short url" do
    test "renders short url when data is valid", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), @create_attrs)
      assert %{"short_url" => short_url} = json_response(conn, 201)

      conn = get(conn, short_url)
      assert redirected_to(conn, 302) == "https://example.com"
    end

    test "renders not found error", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :show, "some wrong_url"))
      assert json_response(conn, 404)["errors"] != %{}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_url(_) do
    url = url_fixture()
    %{url: url}
  end
end
