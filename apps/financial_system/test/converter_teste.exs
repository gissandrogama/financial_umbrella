defmodule ConverterTest do
  use ExUnit.Case
  doctest FinancialSystem.Converter

  # Using function exchange!, returning the converted value
  test "cross currency conversion test: :BRL to :USD, return " do
    FinancialSystem.Converter.exchange(100.00, :BRL, :USD) == 22.79
  end

  test "cross currency conversion test: :USD to :BRL, return " do
    FinancialSystem.Converter.exchange(100.00, :BRL, :USD) == 438.82
  end

  test "currency value conversion test: :USD to :USD, return " do
    FinancialSystem.Converter.exchange(100.00, :USD, :USD) == 100.0
  end

  # Using function exchange, returning the converted
  test "cross currency conversion test: :BRL to :AFN, return " do
    FinancialSystem.Converter.exchange(100.00, :BRL, :AFN) == 1753.68
  end

  test "cross currency conversion test: :AFN to :BRL, return " do
    FinancialSystem.Converter.exchange(100.00, :AFN, :BRL) == 5.7
  end

  test "currency value conversion test: :BRL to :BRL, return " do
    FinancialSystem.Converter.exchange(100.00, :BRL, :BRL) == 100.0
  end

  # test when trying to convert invalid currency to ISO 4217
  test "invalid currency conversion attempt" do
    assert_raise RuntimeError, fn ->
      FinancialSystem.Converter.exchange(1.00, :USD, :BLL)
    end
  end

  test "invalid currency conversion attempt" do
    assert_raise RuntimeError, fn ->
      FinancialSystem.Converter.exchange(1.00, :RRR, :USD)
    end
  end
end
