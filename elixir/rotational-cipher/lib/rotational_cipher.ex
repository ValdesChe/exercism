defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.reduce([], fn char, acc ->
      acc ++ [rotate_character(char, shift)]
    end)
    |> to_string
  end

  def rotate_character(char, shift) do
    cond  do
      char >= ?a && char <= ?z -> rem(char - ?a + shift, 26) + ?a
      char >= ?A && char <= ?Z -> rem(char - ?A + shift, 26) + ?A
      true -> char
    end
  end
end
