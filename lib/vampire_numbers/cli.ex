defmodule VampireNumbers.CLI do
  @moduledoc """
  Entry point into the code. Run main() to start the project
  """

  # Number of numbers in the range handled by each worker
  @worker_size 100

  @doc """
  Runs the script

  ## Parameters

    - args: The arguments comprising of two integer strings in a list
  """
  def main(args) do

    # :observer.start()

    if length(args) != 2 do
      IO.puts "Usage: mix run vampire_numbers.exs n1 n2"
      exit(:shutdown)
    end

    n1 = Enum.at(args, 0) |> String.to_integer
    n2 = Enum.at(args, 1) |> String.to_integer

    children = n1..n2
      |> Enum.chunk_every(@worker_size)
      |> Enum.map(fn x -> Supervisor.child_spec({VampireNumbers.Server, x}, id: Enum.at(x, 0)) end)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VampireNumbers.Supervisor]
    Supervisor.start_link(children, opts)

    # IO.inspect Supervisor.which_children(VampireNumbers.Supervisor)

    result = 
      Supervisor.which_children(VampireNumbers.Supervisor)
      |> Enum.map(fn {_, pid, :worker, _} -> pid end)
      |> Enum.map(fn pid -> GenServer.call(pid, :get_result) end)
      |> Enum.filter(fn i -> i != [] end)
      |> Enum.sort

    Enum.map(result, fn line ->
      IO.puts Enum.join(line, "\n")
    end)
  end
end
