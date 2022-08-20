# UrlShortener

![ci.yml][link-ci]

**Oh, no! Another URL shortener app.**

## Prerequisites

The application uses [Phoenix][link-phx] as a framework and [PostgreSQL][link-pgsql] as a persistent storage.

To run the containers application uses [docker][link-docker] and [make][link-make].

## Configuration and booting

From the project root, inside the shell, run:

- `make pull` to pull latest images
- `make init` to install fresh dependencies
- `make up` to run app containers

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To extinguish running containers type `make down`.

For another commands see `make help`.

## Howitworks

There are two API methods:

1. Shorten a long URL by getting an incremental counter and converting it to base62 format.

   ```
   curl --location --request POST 'http://localhost:4000/' \
   --header 'Accept: application/json' \
   --header 'Content-Type: application/json' \
   --data-raw '{
       "long_url": "https://example.com"
     }'
   ```
   
   **It responds with:**
   
   ```
   {
     "short_url": "http://localhost:4000/2bU"
   }
   ```

2. Reading short URL and redirecting to the matched long URL.

   **Just follow the link builded in step 1:**

   ```
   curl --location --request GET 'http://localhost:4000/2bU'
   ```

   **You will be redirected to the previously stored long URL**.

## Benchmarks

Run `make bench` for benchmarking tests.

### Thats literally it. Good job :)

[link-ci]: https://github.com/shirokovnv/url_shortener/actions/workflows/ci.yml/badge.svg
[link-phx]: https://www.phoenixframework.org/
[link-pgsql]: https://www.postgresql.org/
[link-docker]: https://www.docker.com/
[link-make]: https://www.gnu.org/software/make/manual/make.html
