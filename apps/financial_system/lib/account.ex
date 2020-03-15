defmodule FinancialSystem.Account do
  @moduledoc """
  Account structure module and function to create an account, using the lib Money.
  """

  defstruct name: nil, email: nil, balance: Money.new(0, :BRL)

  alias __MODULE__

  @typedoc """
  Type that makes the specifications of the most descriptive function.
  """
  @type t :: %FinancialSystem.Account{name: String.t(), email: String.t(), balance: Money.t()}

  @doc """
  Function for create a new account.

  Example
    
      account1 = FinancialSystem.Account.new("Bacara Silva","bacara@gmail.com", 100, :BRL)
      %FinancialSystem.Account{
        balance: %Money{amount: 100, currency: :BRL},
        email: "bacara@gmail.com",
        name: "Bacara Silva"
      }

  """
  @spec new(String.t(), String.t(), integer, atom) :: FinancialSystem.Account.t()
  def new(name, email, amount, currency) do
    %Account{name: name, email: email, balance: Money.new(amount, currency)}
  end
end
