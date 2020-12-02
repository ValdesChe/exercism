defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      (!shouting?(input) || capitalise?(input)) && is_question?(input) -> "Sure."
      shouting?(input) && is_question?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input) && ( is_exclam?(input) || String.match?(input, ~r/[a-zA-Zо-и]/))  -> "Whoa, chill out!"
      :otherwise -> "Whatever."
    end
  end

  defp silence?(nil) do
    true
  end

  defp silence?(input) do
    "" == String.trim input
  end

  defp is_question?(input) do
    "?" == (
    input
    |> String.trim
    |> String.last())
  end

  defp is_exclam?(input) do
    "!" == String.last(input)
  end

  # If first letter is capital
  defp capitalise?(input), do: input == String.capitalize input

  defp shouting?(input), do: input == String.upcase input
end
