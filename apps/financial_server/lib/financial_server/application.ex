defmodule FinancialServer.Application do

  @moduledoc false

  use Application

  
  def start(_type, _args) do
    
    port = String.to_integer(System.get_env("PORT") || "4040")
    
    children = [
      {Task.Supervisor, name: FinancialServer.TaskSupervisor},
      Supervisor.child_spec({Task, fn -> FinancialServer.accept(port) end}, restart: :permanent)
    ]
  
    opts = [strategy: :one_for_one, name: FinancialServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
