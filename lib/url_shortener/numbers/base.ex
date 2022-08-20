defmodule UrlShortener.Numbers.Base do
  @moduledoc """
  This module represents encode/decode functionality from integers to the custom alphabet.
  """

  defmacro __using__(opts) do
    alphabet = Keyword.fetch!(opts, :alphabet)

    if !is_binary(alphabet), do: raise(ArgumentError, message: "Alphabet must be string.")

    quote bind_quoted: [alphabet: alphabet] do
      Module.register_attribute(__MODULE__, :alphabet, accumulate: false)
      Module.register_attribute(__MODULE__, :length, accumulate: false)

      @alphabet String.graphemes(alphabet)
      @length String.length(alphabet)

      @spec encode(integer) :: binary
      def encode(number), do: encode(number, [])

      @spec decode(binary) :: integer
      def decode(enc), do: decode(enc |> String.graphemes(), 0)

      defp encode(0, []), do: [@alphabet |> hd] |> to_string
      defp encode(0, acc), do: acc |> to_string

      defp encode(digit, acc) do
        encode(div(digit, @length), [Enum.at(@alphabet, rem(digit, @length)) | acc])
      end

      defp decode([], acc), do: acc

      defp decode([head | tail], acc) do
        decode(tail, acc * @length + Enum.find_index(@alphabet, &(&1 == head)))
      rescue
        ArithmeticError -> nil
      end
    end
  end
end

defmodule UrlShortener.Numbers.Base62 do
  @moduledoc """
  This module encoding integers to base62 format and back.
  """

  use UrlShortener.Numbers.Base,
    alphabet: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
end
