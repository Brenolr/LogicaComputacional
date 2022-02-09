defmodule Relacoes do
  def compose(a, b) do
    compose(a, b, 0, 0, [])
  end

  def compose(a, b, ai, bi, acc) do
    # IO.inspect([a, b, ai, bi, acc])
    # IO.inspect(ai < Enum.count(a))

    if(ai < Enum.count(a)) do
      aa = Enum.at(a, ai)
      bb = Enum.at(b, bi)
      # IO.inspect([a, b, ai, bi, acc, aa, bb])

      if Enum.at(aa, 1) == Enum.at(bb, 0) do
        new = [Enum.at(aa, 0), Enum.at(bb, 1)]
        acc2 = acc ++ [new]
        # IO.inspect(acc2)
        # IO.inspect("teste 1")

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
  def rec(0, d, _r, _rn, acc) do
    dup = Enum.map(d, fn x-> [x, x] end)
    Enum.uniq((acc ++ dup))
  end


  def rec(n, d, r, rn, acc) do
    novo_rn = compose(r,rn)
    update_acc = Enum.uniq((acc ++ novo_rn))
    rec(n - 1, d, r, novo_rn, update_acc)
  end
  def alg(d,r) do
    rec(Enum.count(d), d, r, r, r)
  end
end

# a = MapSet.new([[1, 2], [3, 2], [2, 2], [4, 1]])
# b = MapSet.new([[1, 2], [2, 1], [1, 3]])
c = [[1, 1],[1, 2],[2, 3]]
# IO.inspect(MapSet.union(a,b))
# [[1,2],[3,1],[2,3]]
# IO.inspect(Relacoes.compose(a, b))
# IO.inspect(Relacoes.rec(3, c, c, c))
IO.inspect(Relacoes.alg([1,2,3,4,5], c))
