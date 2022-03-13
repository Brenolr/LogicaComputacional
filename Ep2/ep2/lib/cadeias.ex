defmodule Cadeias do

  def cadeia_maiusc(lista) do
    #[inicial|resto] = lista
    #IO.inspect("lista")
    #IO.inspect(lista)
    # #IO.inspect("tem_maiusc(lista)")
    # #IO.inspect(tem_maiusc(lista))
    #cadeia_maiusc(resto, tem_maiusc(lista))

    # #IO.inspect([tem_maiusc(Enum.at(Enum.to_list(lista), 0))])
    list_has_uppercase = Enum.map(lista, fn el -> tem_maiusc(el) end)

    #IO.inspect("list_has_uppercase")
    #IO.inspect(list_has_uppercase)

    has_uppercase = Enum.reduce(list_has_uppercase, fn el, acc ->  el or acc end)

    #IO.inspect("has_uppercase")
    #IO.inspect(has_uppercase)

    has_uppercase
      # Enum.reduce(lista, fn el, acc -> acc ++ [tem_maiusc(el)] end)
  end

  def tem_maiusc(palavra) do
    #IO.inspect("tem_maisuc?")
    #IO.inspect(palavra)
    # palavra_s = palavra#List.to_string(palavra)
    # palavra_s != String.downcase(palavra_s)

    palavra != String.downcase(palavra)
  end

  def generate_partial_vocab(word_set, grammar) do

    l = Enum.map(word_set,
      fn word ->
        l2 = Enum.map(grammar,
          fn rule ->
            [pattern, replacement] = rule
            split_word = String.split(word, pattern)
            ##IO.inspect("-------------------")
            ##IO.inspect(split_word)

            n = Enum.count(split_word) - 2
            partial_vocab = if n >= 0 do
              ##IO.inspect("============")
              for i <- 0 .. n do
                part1 = Enum.slice(split_word, 0, i)
                part2 = Enum.slice(split_word, i, 2)
                part3 = Enum.slice(split_word, i + 2, n - i)

                ##IO.inspect(i)
                ##IO.inspect(part1)
                ##IO.inspect(part2)
                ##IO.inspect(part3)

                first = Enum.join(part1, pattern)
                middle = Enum.join(part2, replacement)
                last = Enum.join(part3, pattern)

                # ###IO.inspect([first, middle, last])

                #full =
                        if Enum.count(part1) == 0 do
                          if Enum.count(part3) == 0 do
                            ##IO.inspect("part1 e 3 == 0")
                            middle
                          else
                            ##IO.inspect("part1 == 0")
                            Enum.join([middle, last], pattern)
                          end
                        else
                          if Enum.count(part3) == 0 do
                            ##IO.inspect("part3 == 0")
                            Enum.join([first, middle], pattern)
                          else
                            ##IO.inspect("else")
                            Enum.join([first, middle, last], pattern)
                          end
                        end

                #IO.inspect(full)
                #full
              end
              ##IO.inspect("============")

            else
              # IO.inspect("word")
              # IO.inspect(word)
              MapSet.new([word]) # mantain lowcase words
            end

            #IO.inspect("partial vocab")
            #IO.inspect(partial_vocab)
            partial_vocab
            #s = String.replace(word, pattern, replacement)
            #s
          end
        )
        # #IO.inspect("l2")
        # #IO.inspect(l2)
        s2 = MapSet.new(l2)
        #IO.inspect("s2")
        #IO.inspect(s2)

            # O rpboelma esta aqui
        # a = Enum.reduce(s2, foo)
        # #IO.inspect("a")
        # #IO.inspect(a)
        s2
      end
    )

    foo = fn l, acc ->
      if not is_nil(l) do
        #IO.inspect("l")
        #IO.inspect(l)
        # #IO.inspect(MapSet.new(l))
        # #IO.inspect(MapSet.union( MapSet.new(l), acc ))
        if not is_nil(acc) do
          MapSet.union( MapSet.new(l), acc )
        else
          MapSet.union( MapSet.new(l), MapSet.new([]) )
        end
      end
    end

    #IO.inspect(l)
    new_wordlist_set = Enum.reduce(l, fn s, acc -> MapSet.union(s, acc) end)
    new_word_set = Enum.reduce(new_wordlist_set, foo)

    #IO.inspect(word_set)
    #IO.inspect(new_word_set)
    #IO.inspect(new_wordlist_set)

    #MapSet.difference(new_word_set, word_set)
    new_word_set
  end

  def remove_too_big(word_set, max_size) do
    # IO.inspect("remove_too_big")
    # IO.inspect("word_set")
    # IO.inspect(word_set)
    # IO.inspect("max_size")
    # IO.inspect(max_size)

    #IO.inspect(IEx.Info.info(5))

    Enum.filter(word_set, fn el -> (String.length(el) <= max_size) end)
  end

  def remove_uppercase(word_set) do
    Enum.filter(word_set, fn el -> not tem_maiusc(el) end)
  end

  # word_set precisa começar com um elemento
  def generate_vocab(word_set, grammar, max_size, last_clean_size) do

    IO.inspect("last_clean_size")
    IO.inspect(last_clean_size)

    IO.inspect("word_set")
    IO.inspect(word_set)
    clean_word_set = remove_too_big(word_set, max_size)
    IO.inspect("clean_word_set")
    IO.inspect(clean_word_set)

    if cadeia_maiusc(clean_word_set) do
      # IO.inspect("if")
      # IO.inspect(clean_word_set)
      new_word_set = generate_partial_vocab(clean_word_set, grammar)
      # IO.inspect(new_word_set)
      #if new_word_set != clean_word_set do
      new_clean_size = Enum.count(clean_word_set)

      if last_clean_size != new_clean_size do
        generate_vocab(new_word_set, grammar, max_size, new_clean_size)
      else
        remove_uppercase(new_word_set)
      end
    else
      # IO.inspect("else")
      remove_uppercase(clean_word_set)
    end
  end

end
# ###IO.inspect(is_list('ab'))
# ###IO.inspect('ab' == 'abc')
# teste = Cadeias.tem_maiusc('eNo')
# ###IO.inspect(teste)
grammar = [["A", "Aa"],["B", "b"],["C", "c"], ["A", "a"]]
# Cadeias.gerar_vocab(grammar,1)

# ###IO.inspect(Cadeias.any_maiusc(["abc", "BBa", "asdas"]))
list = ["ABc", "BBa", "CCaB"]
IO.inspect(grammar)
IO.inspect(list)
#IO.inspect(Cadeias.generate_partial_vocab(MapSet.new(list), grammar))
IO.inspect(Cadeias.generate_vocab(MapSet.new(list), grammar, 7, 0))
