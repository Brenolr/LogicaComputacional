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

  def nonDeterministicMachine(tape, state_graph, state, head_position) do

    input = Enum.at(tape,head_position)
    next_state = state_graph[state][input]

    if(head_position < Enum.count(tape)) do
      list_next_state = Enum.map(next_state, fn st -> nonDeterministicMachine(tape,state_graph, st, head_position + 1) end)
      Enum.reduce(list_next_state, fn st, acc ->  acc or st end)
    else
      state_graph[state][:is_accept_state]
    end
  end
end

