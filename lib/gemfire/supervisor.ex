defmodule Gemfire.Supervisor do
  @moduledoc false
  
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(arg) do

    poolboy_config = [
        {:name, {:local, :gemclient}},
        {:worker_module, Gemfire.Client},
        {:size, 10},
        {:max_overflow, 1}
     ]
    children = [
      :poolboy.child_spec(:gemclient, poolboy_config, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end