defmodule Machines do
  def deterministicMachine(tape, state_graph, state, head_position) do
    input = Enum.at(tape,head_position)
    next_state = state_graph[state][input]

    if(head_position < Enum.count(tape)) do
      deterministicMachine(tape, state_graph, next_state, head_position + 1)
    else
      state_graph[state][:is_accept_state]
    end
  end

  def ndMachineCicle(tape, state_graph, state, head_position) do

    input = Enum.at(tape,head_position)
    next_state = state_graph[state][input]

    if(head_position < Enum.count(tape)) do
      Enum.map(next_state, fn st -> ndMachineCicle(tape,state_graph, st, head_position + 1) end)
    else
      state_graph[state][:is_accept_state]
    end
  end
  def nonDeterministicMachine(tape, state_graph, state, head_position) do
    outputs = ndMachineCicle(tape, state_graph, state, head_position)
    Enum.any?(outputs, fn out -> out == true end)
  end
end


