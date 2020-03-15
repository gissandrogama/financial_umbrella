defmodule FinancialSystem.Converter do
  alias FinancialSystem.Coin, as: Coin

  @moduledoc """
  Module that deals with operations such as currency value conversion. Uses the dollar as a base to make the other conversions.
  If the currency is not ISO 4217 standard and an error is returned.
  """

  @doc false
  def exchange(amount, from_coin, to_coin) when from_coin == to_coin do
    case Coin.is_valid?(from_coin) do
      true -> amount
      false -> {:error, "Coin (#{from_coin}) not valid compared to ISO 4271"}
    end

    case Coin.is_valid?(to_coin) do
      true -> amount
      false -> {:error, "Coin (#{to_coin}) not valid compared to ISO 4271"}
    end
  end

  def exchange(amount, from, :USD) do
    case Coin.is_valid?(from) do
      true ->
        from = Atom.to_string(from)
        rates = Coin.currency_rate
        value_amount = Decimal.from_float(amount)
        rate_from = 
          rates
          |> Enum.find(fn {currency, _value} -> currency == from end)
          |> elem(1)
          |> Decimal.from_float()

        converted_amount =
          Decimal.div(value_amount, rate_from)
          |> Decimal.round(2)
          |> Decimal.to_float()

        converted_amount

      false ->
        {:error, "Coin (#{from}) not valid compared to ISO 4271"}
    end
  end

  def exchange(amount, :USD, to) do
    case Coin.is_valid?(to) do
      true ->
        to = Atom.to_string(to)
        rates = Coin.currency_rate
        value_amount = Decimal.from_float(amount)
        rate_to = 
          rates
          |> Enum.find(fn {currency, _value} -> currency == to end)
          |> elem(1)
          |> Decimal.from_float()

        converted_amount =
          Decimal.mult(value_amount, rate_to)
          |> Decimal.round(2)
          |> Decimal.to_float()

        converted_amount

      false ->
        {:error, "Coin (#{to}) not valid compared to ISO 4271"}
    end
  end

  @doc """
  The exchange function takes as arguments a value such as float and two types of atom currencies.
  And it uses axillary functions to perform currency conversion and verification operations.
  To perform the conversion of values ​​is based in a cunsult api, where get the values ​​for each currency.

  ## Examples

        iex(1)> FinancialSystem.Converter.exchange(100.00, :BRL, :USD)
        22.79
        iex(2)> FinancialSystem.Converter.exchange(100.00, :USD, :BRL)
        438.82
        iex(3)> FinancialSystem.Converter.exchange(100.00, :BRL, :ANF)
        {:error, "Coins (BRL 'or' ANF) not valid compared to ISO 4271"}
        iex(4)> FinancialSystem.Converter.exchange(100.00, :BRL, :AFN)
        1753.68
        iex(5)> FinancialSystem.Converter.exchange(100.00, :AFN, :BRL)
        5.7
        iex(6)> FinancialSystem.Converter.exchange(100.00, :AFF, :USD)
        {:error, "Coin (AFF) not valid compared to ISO 4271"}

  """
  @spec exchange(float, atom, atom) :: float | {:error, String.t()}
  def exchange(amount, from, to) do
    case !Coin.is_valid?(from) or !Coin.is_valid?(to) do
      true ->
        {:error, "Coins (#{from} 'or' #{to}) not valid compared to ISO 4271"}

      false ->
        usd_value = FinancialSystem.Converter.exchange(amount, from, :USD)
        FinancialSystem.Converter.exchange(usd_value, :USD, to)
    end
  end
end
