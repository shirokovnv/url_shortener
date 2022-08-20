# UrlShortener

![ci.yml][link-ci]

**Oh, no! Another URL shortener app.**

## Dependencies

* [Docker][link-docker]
* [Make][link-make]
* [Phoenix framework][link-phx]
* [PostgreSQL][link-pgsql]

## Project setup

**From the project root, inside shell, run:**

- `make pull` to pull latest images
- `make init` to install fresh dependencies
- `make up` to run app containers

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

* `make down` - to extinguish running containers
* `make help` - for additional commands

## Howitworks

**There are two API methods:**

_Shorten a long URL_ by getting an incremental counter and converting it to base62 format.

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

_Reading short URL_ and redirecting to the matched long URL.

   **Just follow the link builded from previous step:**

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
