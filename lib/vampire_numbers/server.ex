defmodule VampireNumbers.Server do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link(list) do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil)
    GenServer.cast(pid, {:compute, list})
    {:ok, pid}
  end

  def handle_cast({:compute, list}, _state) do
    state =
      list
      |> Enum.map(fn n -> VampireNumbers.Core.check(n) end)
      |> Enum.filter(fn n -> n != nil end)
    
    {:noreply, state}
  end

  def handle_call(:get_result, _from, state) do
    {:reply, state, nil}
  end
end
