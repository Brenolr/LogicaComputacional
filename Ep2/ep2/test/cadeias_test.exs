defmodule CadeiasTest do
  use ExUnit.Case
  doctest Cadeias
  ExUnit.start()

  test "greets the world" do
    assert Cadeias.hello() == :world
  end

  test "test1" do
    grammar = [["A", "Aa"],["B", "b"],["C", "c"], ["A", "a"]]
    list = ["ABc", "BBa", "CCaB"]

    vocab = Cadeias.generate_vocab(MapSet.new(list), grammar, 4, 0)

    assert vocab == ["aabc", "abc", "bba", "ccab"]
  end
end
