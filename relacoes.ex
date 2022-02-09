defmodule Relacoes do
    # def compor(a,b) do
    #     Enum.map(a, 
    #         fn [a0,a1] -> Enum.map(b, 
    #             fn [b0,b1] -> if(a1==b0) do 
    #                     [a0,b1]
    #                 end
    #             end
    #             )
    #         end
    #         )    
    # end
    def compor(a,b) do
        r = []
        Enum.each(a, 
            fn [a0,a1] -> Enum.each(b, 
                fn [b0,b1] -> if(a1==b0) do 
                    r = [[a0,b1]|r]
                    IO.inspect([a0,b1])
                    IO.inspect(r)
                    end
                end
                )
            end
            )
        r    
    end
    def rec(0,r,rn,u), do: u
    def rec(n,r,rn,u) do 
        novo_rn = compor(r,rn)
        update_u = MapSet.union(u,novo_rn)
        rec(n-1,r,novo_rn,update_u)
    end

end
a = MapSet.new([[1,2],[3,2],[2,2]])
b = MapSet.new([[1,2],[2,1],[1,3]])
# IO.inspect(MapSet.union(a,b))
# [[1,2],[3,1],[2,3]]
IO.inspect(Relacoes.compor_rec(a,b))

