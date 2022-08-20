defmodule UrlShortener do
  @moduledoc """
  An example of a URL shortener app.

  Provides simple API:

  **Create short URL request**

  ```
  curl --location --request POST 'http://localhost:4000/' \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "long_url": "https://example.com"
    }'
  ```

  **Response**

  ```
  {
    "short_url": "http://localhost:4000/2bU"
  }
  ```

  **Follow short URL request**

  ```
  curl --location --request GET 'http://localhost:4000/2bU'
  ```

  **Response**

  ```
  Request URL: http://localhost:4000/2bJ
  Request Method: GET
  Status Code: 302 Found
  Remote Address: 127.0.0.1:4000
  Referrer Policy: strict-origin-when-cross-origin

  https://example.com/
  ```
  """
end
