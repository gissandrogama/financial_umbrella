defmodule AccountTest do
  use ExUnit.Case
  doctest FinancialSystem.Account

  # Test to create user 

  setup_all do
    {:ok,
     [account1: FinancialSystem.Account.new("Gissandro", "gissandrogama@gmail.com", 100, :BRL)]}
  end

  test "Users create accounts in any currencies" do
    assert FinancialSystem.Account.new("João Bacara", "bacara@gmail.com", 200, :BRL)
    assert FinancialSystem.Account.new("Antonio Kiba", "kiba@gmail.com", 300, :USD)
    assert FinancialSystem.Account.new("Gleison Cupu", "cupu@gmail.com", 400, :EUR)
  end
end
