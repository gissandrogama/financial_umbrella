defmodule CoinTest do
  use ExUnit.Case
  doctest FinancialSystem.Coin

  # test generate list currency to ISO 4217
  test "generet list of currency" do
    assert FinancialSystem.Coin.currency_list()
  end

   # test generate list currencys and values to ISO 4217
   test "generet list of currencys and values" do
    assert FinancialSystem.Coin.currency_rate()
  end

  # Currency verification test if in accordance with ISO 4217
  test "check if currency abbreviation exists according to ISO 4217" do
    assert FinancialSystem.Coin.is_valid?(:BRL) == true
  end

  test "check if currency abbreviation does not exist according to ISO 4217" do
    assert FinancialSystem.Coin.is_valid?(:LLL) == false
  end
end
