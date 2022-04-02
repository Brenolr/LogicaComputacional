defmodule Recursion do
  def print_multiple_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end

  def print_multiple_times(_msg, 0) do
    :ok
  end

  def cartesian(l1, l2) do
    prod = for x <- l1, y <- l2, do: {x, y}
    MapSet.new(prod)
    # prod = MapSet.new()
    # Enum.each l1, fn(el1) ->
    #   Enum.each l2, fn(el2) ->
    #     IO.inspect([el1, el2])
    #   end
    # end
    # prod
  end

  def compose(l1, l2) do
    r = []
    comp =  for [a0, a1] <- l1 do
              IO.inspect([a0, a1])
              for [b0, b1] <- l2 do
                IO.inspect([b0, b1])
                if a1 == b0 do
                  r = [[a0, b1]|r]
                end
              end
            end
    IO.inspect(comp)
    IO.inspect(r)

    comp2 = for el <- comp do
          for [el21, el22] <- el do
            [el21, el22]
        end
      end
    IO.inspect(comp2)
    Enum.at(comp2,0)
  end

  # def compose_rec(item, list, result) do
  #   if()
  # end

  # def compose_2(l1, l2) do
  #   for a <- l1 do
  #     #cham outra função
  #   end
  # end
end

# IO.puts("Hello world from Elixir")
# l1 = [1,2,3, 1]
# l2 = [1,2,3]

# Recursion.print_multiple_times("Hello!", 3)
# IO.inspect(Recursion.cartesian(l1, l2))
IO.inspect(b)
# IO.inspect(Recursion.compose([[1,2], [3, 2]], [[2, 1],[1,1],[2,4]]))
