defmodule ProteinTranslation do
  @codons %{
  "UGU" => "Cysteine",
  "UGC" => "Cysteine",
  "UUA" => "Leucine",
  "UUG" => "Leucine",
  "AUG" => "Methionine",
  "UUU" => "Phenylalanine",
  "UUC" => "Phenylalanine",
  "UCU" => "Serine",
  "UCC" => "Serine",
  "UCA" => "Serine",
  "UCG" => "Serine",
  "UGG" => "Tryptophan",
  "UAU" => "Tyrosine",
  "UAC" => "Tyrosine",
  "UAG" => "STOP",
  "UAA" => "STOP",
  "UGA" => "STOP"
  }


  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> to_charlist
    |> Enum.chunk_every(3)
    |> Enum.reduce_while({:ok, []}, fn codon, acc ->
      case of_codon(to_string(codon)) do
        {:ok, proteine} ->
          cond do
            "STOP" ==  proteine -> {:halt, acc}
            true ->
              {:ok, old_acc} = acc
              {:cont, {:ok, old_acc ++ [proteine]}}
          end
        {:error, "invalid codon"} ->
          {:halt, {:error, "invalid RNA"}}
      end
    end)

  end


  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case @codons[codon] do
      :nil -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end

end
