defmodule MaquinaDeterministica do
  def machineCicle(tape, state_graph, state, head_position) do

    input = Enum.at(tape,head_position)
    next_state = state_graph[state][input]

    if(head_position < Enum.count(tape)) do
      machineCicle(tape, state_graph, next_state, head_position + 1)
    else
      state_graph[state][:is_accept_state]
    end
  end
end
defmodule MaquinaNaoDeterministica do
  def machineCicle(tape, state_graph, state, head_position) do

    input = Enum.at(tape,head_position)
    next_state = state_graph[state][input]

    if(head_position < Enum.count(tape)) do
      machineCicle(tape, state_graph, next_state, head_position + 1)
    else
      state_graph[state][:is_accept_state]
    end
  end
end

tape = [:giro,:giro,:giro,:moeda, :giro]
state_graph = %{fechado: %{moeda: :aberto, giro: :fechado, is_accept_state: True},
                 aberto: %{moeda: :aberto, giro: :fechado, is_accept_state: False}
                }
IO.inspect(MaquinaDeterministica.machineCicle(tape, state_graph, :fechado, 0))
