defmodule CadeiasTest do
  use ExUnit.Case
  doctest Cadeias

  #Os "== true" poderiam vazios e "refute" ao invez de "assert" para falsos, mas deixamos dessa forma por clareza
  test "Caso de Testes 01" do
    grammar = [["S", "aAS"],["S", "a"],["A", "SbA"], ["A", "ba"], ["A", "SS"]]
    inicial = ["S"]
    sequence = "abaa"
    assert Cadeias.find_word_on_vocab(inicial,grammar,sequence) == true
  end
  test "Caso de Testes 02" do
    grammar = [["S", "aAS"],["S", "a"],["A", "SbA"], ["A", "ba"], ["A", "SS"]]
    inicial = ["S"]
    sequence = "a"
    assert Cadeias.find_word_on_vocab(inicial,grammar,sequence) == true
  end
  test "Caso de Testes 03" do
    grammar = [["S", "aAS"],["S", "a"],["A", "SbA"], ["A", "ba"], ["A", "SS"]]
    inicial = ["S"]
    sequence = "abbb"
    assert Cadeias.find_word_on_vocab(inicial,grammar,sequence) == false
  end
  test "Caso de Testes 04" do
    grammar = [["A", "Aa"],["B", "b"],["C", "c"], ["A", "a"]]
    inicial = ["A"]
    sequence = "aaa"
    assert Cadeias.find_word_on_vocab(inicial,grammar,sequence) == true
  end
  test "Caso de Testes 05" do
    grammar = [["A", "Aa"],["B", "b"],["C", "c"], ["A", "a"]]
    inicial = ["A"]
    sequence = "aaaaaa"
    assert Cadeias.find_word_on_vocab(inicial,grammar,sequence) == true
  end
  test "Caso de Testes 06" do
    grammar = [["A", "Aa"],["B", "b"],["C", "c"], ["A", "a"]]
    inicial = ["A"]
    sequence = "abbb"
    assert Cadeias.find_word_on_vocab(inicial,grammar,sequence) == false
  end
end
