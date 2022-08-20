defmodule UrlShortener.Links.Type.ShortUrlId do
  @moduledoc """
  This module represents a wrapper around `:id` Ecto type.

  It encodes numeric ID-s to base62 numbers and vise versa.
  """

  @behaviour Ecto.Type
  alias UrlShortener.Numbers.Base62

  @spec type :: :id
  def type, do: :id

  def cast(id) when is_integer(id) do
    {:ok, Base62.encode(id)}
  end

  @spec cast(integer | binary) :: :error | {:ok, integer}
  def cast(id) when is_binary(id), do: dump(id)

  def cast(_), do: :error

  @spec dump(integer | binary) :: :error | {:ok, integer}
  def dump(id) when is_integer(id), do: {:ok, id}

  def dump(id) when is_binary(id) do
    {:ok, Base62.decode(id)}
  end

  def dump(_), do: :error

  @spec load(integer) :: :error | {:ok, binary | integer}
  def load(id) when is_integer(id), do: cast(id)

  def load(_), do: :error

  @spec embed_as(any) :: :self
  def embed_as(_), do: :self

  @spec equal?(binary | integer, binary | integer) :: boolean
  def equal?(term1, term2), do: term1 == term2
end
