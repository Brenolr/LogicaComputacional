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
      # Enum.map(next_state, fn st -> ndMachineCicle(tape,state_graph, st, head_position + 1) end)
      # IO.inspect("next_state")
      # IO.inspect(next_state)
      list_next_state = Enum.map(next_state, fn st -> ndMachineCicle(tape,state_graph, st, head_position + 1) end)
      # IO.inspect("list_next_state")
      # IO.inspect(list_next_state)
      foo = fn el, acc ->  acc or el end
      Enum.reduce(list_next_state, fn st, acc ->  acc or st end)
      # Enum.reduce(list_next_state, fn st, acc ->  acc or Enum.reduce(st, foo) end)
      # Enum.reduce(list_next_state, fn st, acc ->  acc ++ st end)
    else
      state_graph[state][:is_accept_state]
    end
  end
  def nonDeterministicMachine(tape, state_graph, state, head_position) do
    outputs = ndMachineCicle(tape, state_graph, state, head_position)
    IO.inspect(outputs)
    # Enum.any?(outputs, fn out -> out == true end)
  end
end

# tape = [:a,:a,:a,:a,:a,:a,:a,:a]
tape = [:a,:a,:b]
state_graph = %{s1: %{a: [:s2,:s3], b: [:s1, :s2], is_accept_state: false},
                s2: %{a: [:s4,:s5], b: [:s2], is_accept_state: true},
                s3: %{a: [:s3], b: [:s3], is_accept_state: false},
                s4: %{a: [:s5], b: [:s2], is_accept_state: false},
                s5: %{a: [:s5], b: [:s5], is_accept_state: false}
                }
IO.inspect(Machines.nonDeterministicMachine(tape, state_graph, :s1, 0))
