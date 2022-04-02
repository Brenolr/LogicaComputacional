defmodule Relacoes do
  def compose(l1, l2) do
    IO.inspect(l1)
    IO.inspect(l2)
    comp =  for [a0, a1] <- l1 do
              IO.inspect([a0, a1])
              for [b0, b1] <- l2 do
                # IO.inspect([b0, b1])
                if a1 == b0 do
                    # IO.inspect("Kenobi")
                    [a0, b1]
                end
              end
            end
    # IO.inspect(comp)
    for [el] <- comp do
      el
    end
    end

    def rec(0,r,rn,u), do: u
    def rec(n,r,rn,u) do
        novo_rn = compose(r,rn)
        update_u = Enum.uniq((u ++ novo_rn))
        rec(n-1,r,novo_rn,update_u)
    end

end
a = [[1,2], [3, 2]]
b = [[2,1]]
# IO.inspect(MapSet.union(a,b))
# [[1,2],[3,1],[2,3]]
IO.inspect(Relacoes.compose(a,b))
# IO.inspect(Relacoes.compose([[1,2], [3, 2]], [[2, 1]]))

