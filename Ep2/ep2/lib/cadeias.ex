defmodule Cadeias do
  def gerar_vocab(gram, size) do
    gram == size
  end
  def tem_maius(palavra) do
    palavra_s = List.to_string(palavra)
    palavra_s != String.downcase(palavra_s)
  end
end
# IO.inspect(is_list('ab'))
# IO.inspect('ab' == 'abc')
teste = Cadeias.tem_maius('eno')
IO.inspect(teste)
grammar = [['A', 'a'],['B', 'b'],['C', 'c']]
Cadeias.gerar_vocab(grammar,1)
