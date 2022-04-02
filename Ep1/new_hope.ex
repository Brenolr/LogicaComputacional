defmodule Hope do
  def compose(a, b) do
    compose(a, b, 0, 0, [])
  end

  def compose(a, b, ai, bi, acc) do
    IO.inspect([a, b, ai, bi, acc])
    IO.inspect(ai < Enum.count(a))

    if(ai < Enum.count(a)) do
      aa = Enum.at(a, ai)
      bb = Enum.at(b, bi)
      IO.inspect([a, b, ai, bi, acc, aa, bb])

      if Enum.at(aa, 1) == Enum.at(bb, 0) do
        new = [Enum.at(aa, 0), Enum.at(bb, 1)]
        acc2 = acc ++ [new]
        IO.inspect(acc2)
        IO.inspect("teste 1")

        if(bi == Enum.count(b) - 1) do
          compose(a, b, ai + 1, 0, acc2)
        else
          compose(a, b, ai, bi + 1, acc2)
        end
      else
        # IO.inspect([ai,bi])
        if(bi == Enum.count(b) - 1) do
          compose(a, b, ai + 1, 0, acc)
        else
          compose(a, b, ai, bi + 1, acc)
        end
      end
    else
      acc
    end
  end
end

a = [[1, 2], [3, 4],[10,3]]
b = [[2, 1], [3, 1],[2,5]]
IO.inspect(Hope.compose(a, b))
