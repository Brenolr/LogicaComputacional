defmodule Testes do
    def test(n), do
        test(n,0)
    end
    def test(0,acc), do: acc
    def test(n,acc) do
        test(n - 1,acc + 10)
    end

    
end
IO.puts(Testes.test(100))