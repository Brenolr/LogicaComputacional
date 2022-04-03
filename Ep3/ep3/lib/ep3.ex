defmodule Machines do
  def deterministicMachine(tape, state_graph, state, head_position) do
    #valor atual na fita
    input = Enum.at(tape,head_position)
    #qual o proximo estado
    next_state = state_graph[state][input]

    #testa se a fita acabou, se não continua, se sim retorna se era ou não aceitação
    if(head_position < Enum.count(tape)) do
      deterministicMachine(tape, state_graph, next_state, head_position + 1)
    else
      state_graph[state][:is_accept_state]
    end
  end
  #Easter Egg: Não há um easter egg aqui
  def nonDeterministicMachine(tape, state_graph, state, head_position) do
    #valor atual na fita
    input = Enum.at(tape,head_position)
    #qual os proximos estados
    next_state = state_graph[state][input]

    #testa se a fita acabou, se não continua, se sim retorna se era ou não aceitação
    if(head_position < Enum.count(tape)) do
      #chama para cada possivel caminho
      list_next_state = Enum.map(next_state, fn st -> nonDeterministicMachine(tape,state_graph, st, head_position + 1) end)
      #retorna se teve algum true
      Enum.reduce(list_next_state, fn st, acc ->  acc or st end)
    else
      state_graph[state][:is_accept_state]
    end
  end
end
