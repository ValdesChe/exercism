defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    strand
    |> Enum.reduce(0, fn char, acc ->
      if nucleotide == char, do: acc + 1, else: acc
    end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do

    histog = strand
    |> Enum.reduce(%{}, fn char, acc ->
     Map.put(acc, char, (acc[char] || 0) + 1)
    end)

    @nucleotides
    |> Enum.reduce(histog, fn el, acc ->
      Map.put(acc, el, acc[el] || 0)
    end)

  end
end
