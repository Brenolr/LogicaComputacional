defmodule Cadeias do

  def cadeia_maiusc(lista) do
    list_has_uppercase = Enum.map(lista, fn el -> tem_maiusc(el) end)

    has_uppercase = Enum.reduce(list_has_uppercase, fn el, acc ->  el or acc end)
    has_uppercase
  end

  def tem_maiusc(palavra) do
    palavra != String.downcase(palavra)
  end

  def generate_partial_vocab(word_set, grammar) do

    l = Enum.map(word_set,
      fn word ->
        l2 = Enum.map(grammar,
          fn rule ->
            [pattern, replacement] = rule
            split_word = String.split(word, pattern)

            n = Enum.count(split_word) - 2
            partial_vocab = if n >= 0 do
              for i <- 0 .. n do
                part1 = Enum.slice(split_word, 0, i)
                part2 = Enum.slice(split_word, i, 2)
                part3 = Enum.slice(split_word, i + 2, n - i)

                first = Enum.join(part1, pattern)
                middle = Enum.join(part2, replacement)
                last = Enum.join(part3, pattern)

                if Enum.count(part1) == 0 do
                  if Enum.count(part3) == 0 do
                    middle
                  else
                    Enum.join([middle, last], pattern)
                  end
                else
                  if Enum.count(part3) == 0 do
                    Enum.join([first, middle], pattern)
                  else
                    Enum.join([first, middle, last], pattern)
                  end
                end
              end
            else
              MapSet.new([word]) # mantain lowcase words
            end
            partial_vocab
          end
        )
        s2 = MapSet.new(l2)

        s2
      end
    )

    foo = fn l, acc ->
      if not is_nil(l) do
        if not is_nil(acc) do
          MapSet.union( MapSet.new(l), MapSet.new(acc) )
        else
          MapSet.union( MapSet.new(l), MapSet.new([]) )
        end
      end
    end

    new_wordlist_set = Enum.reduce(l, fn s, acc -> MapSet.union(s, acc) end)
    new_word_set = Enum.reduce(new_wordlist_set, foo)

    new_word_set
  end

  def remove_too_big(word_set, max_size) do
    Enum.filter(word_set, fn el -> (String.length(el) <= max_size) end)
  end

  def remove_uppercase(word_set) do
    Enum.filter(word_set, fn el -> not tem_maiusc(el) end)
  end

  # word_set precisa começar com um elemento
  def generate_vocab(word_set, grammar, max_size, last_clean_size) do

    clean_word_set = remove_too_big(word_set, max_size)

    if cadeia_maiusc(clean_word_set) do
      new_word_set = generate_partial_vocab(clean_word_set, grammar)

      new_clean_size = Enum.count(clean_word_set)

      if last_clean_size != new_clean_size do
        generate_vocab(new_word_set, grammar, max_size, new_clean_size)
      else
        remove_uppercase(new_word_set)
      end
    else
      remove_uppercase(clean_word_set)
    end
  end

  def find_word_on_vocab(init, grammar, word) do
    vocab = Cadeias.generate_vocab(MapSet.new(init), grammar, String.length(word), 0)
    # IO.inspect(vocab)
    Enum.member?(vocab, word)
  end

end
