defmodule MaquinaDeterministicaTest do
  use ExUnit.Case
  doctest Machines

  test "teste1" do
    tape = [:giro,:giro,:giro,:moeda, :giro]
    state_graph = %{fechado: %{moeda: :aberto, giro: :fechado, is_accept_state: true},
                    aberto: %{moeda: :aberto, giro: :fechado, is_accept_state: false}
                    }
    assert Machines.deterministicMachine(tape, state_graph, :fechado, 0) == true
  end
  test "teste2" do
    tape = [:b]
    state_graph = %{p: %{a: [:p], b: [:p, :q], is_accept_state: false},
                    q: %{a: [:q], b: [:q], is_accept_state: true}}
    assert Machines.nonDeterministicMachine(tape, state_graph, :p, 0) == true
  end
  test "teste3" do
    tape = [:a,:a, :b, :a]
    state_graph = %{s1: %{a: [:s2,:s3], b: [:s1, :s2], is_accept_state: false},
                    s2: %{a: [:s4,:s5], b: [:s2], is_accept_state: true},
                    s3: %{a: [:s3], b: [:s3], is_accept_state: false},
                    s4: %{a: [:s5], b: [:s2], is_accept_state: false},
                    s5: %{a: [:s5], b: [:s5], is_accept_state: false}
                    }
    assert Machines.nonDeterministicMachine(tape, state_graph, :s1, 0) == false
  end

end
