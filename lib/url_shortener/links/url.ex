defmodule UrlShortener.Links.Url do
  @moduledoc """
  This module represents Url ecto schema.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias UrlShortener.Links.Type.ShortUrlId

  @primary_key {:id, ShortUrlId, read_after_writes: true}
  @derive {Phoenix.Param, key: :id}
  schema "urls" do
    field :long_url, :string

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:long_url])
    |> validate_required([:long_url])
    |> validate_url([:long_url])
  end

  def validate_url(changeset, fields, opts \\ [])

  def validate_url(changeset, fields, opts) when is_list(fields) do
    Enum.reduce(fields, changeset, fn field, acc -> validate_url(acc, field, opts) end)
  end

  def validate_url(changeset, field, _opts) when is_atom(field) do
    value = get_field(changeset, field)

    case EctoFields.URL.cast(value) do
      {:ok, _url} -> changeset
      :error -> add_error(changeset, field, "Not a valid URL.")
    end
  end
end
