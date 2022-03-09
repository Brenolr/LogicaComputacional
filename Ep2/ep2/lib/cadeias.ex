defmodule Cadeias do
  def gerar_vocab(inicial, gram, size) do

  end
  def gerar_vocab(inicial, gram, size, acc) do

  end

  # def iterador(lista,iter,gram,acc) do
  #   char = Enum.at(lista,iter)
  #   acc = acc + grammar_op(char,gram)
  #   if(iter == Enum.length(lista))do
  #     iter = false
  #   end
  #   # iterador(lista,iter + acc)
  # end
  # def interador(lista, false, acc)do
  #   acc
  # end

  def generate_partial_grammar(word_set, grammar) do

    l = Enum.map(word_set,
      fn word ->
        l2 = Enum.map(grammar,
          fn rule ->
            [pattern, replacement] = rule
            s = String.replace(word, pattern, replacement)
            s
          end
        )
        MapSet.new(l2)
      end
    )

    new_word_set = Enum.reduce(l, fn s, acc -> MapSet.union(s, acc) end)
    MapSet.difference(new_word_set, word_set)
  end

  def grammar_op(char,gram) do
    grammar_op(char,gram,0,[])
  end
  def grammar_op(char,gram,false,acc) do
    acc
  end
  def grammar_op(char,gram,iter,acc) do
    if(iter==Enum.count(gram)) do
      grammar_op(char,gram,false,acc)
    end
    IO.inspect(Enum.at(Enum.at(gram,iter),0))
    IO.inspect(char)
    if(Enum.at(Enum.at(gram,iter),0) == char)do
      grammar_op(char,gram,iter+1,[(Enum.at(Enum.at(gram,iter),1))|acc])
    end
    grammar_op(char,gram,iter+1,acc)
  end

  def cadeia_maiusc([]) do
    false
  end
  def cadeia_maiusc(lista) do
    [inicial|resto] = lista
    cadeia_maiusc(resto, tem_maiusc(inicial))
  end
  def cadeia_maiusc(lista, true) do
    true
  end
  def cadeia_maiusc(lista, false) do
    cadeia_maiusc(lista)
  end

  def tem_maiusc(palavra) do
    palavra_s = List.to_string(palavra)
    palavra_s != String.downcase(palavra_s)
  end
end
# IO.inspect(is_list('ab'))
# IO.inspect('ab' == 'abc')
# teste =  ['eno','fsfaasf','fsadasfd','jasfdjasldE']
# IO.inspect(Cadeias.cadeia_maiusc(teste))
grammar = [['A', 'a'],['A', 'b']]
# inicial = ['A']
# Cadeias.gerar_vocab(grammar,1)
IO.inspect(Cadeias.grammar_op('A',grammar))
