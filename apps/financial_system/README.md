# FinancialSystem

A simple system designed for Stone's technical challenge, this system was developed in the Elixir language. It has module and functions that allow the creation of an account, analyze if the currency is in the standards of [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217), conversion of values ​​between currencies of different, transfer between accounts, deposit of a value and debit.

# Requirements and Dependencies

* [Elixir](https://elixir-lang.org/) 1.9 - Used language to develop of the system.
* [Decimal](https://hexdocs.pm/decimal/readme.html) 1.8 - For deal with operation arithmetic with float.
* [Money](https://hexdocs.pm/money/Money.html) 1.6.1 - For deal with de operation with money and symbol of currency.
* [Dialixir](https://github.com/jeremyjh/dialyxir) 0.5 - library that simplifies the use of Dialyzer.
* [Tesla](https://github.com/teamon/tesla) 1.3.0 - The flexible HTTP client library for Elixir, with support for middleware and multiple adapters.
* [jason](https://hexdocs.pm/jason/Jason.html) 1.1.2 - A blazing fast JSON parser and generator in pure Elixir.
* [Hackney](https://github.com/benoitc/hackney) 1.15.2 - Simple HTTP client in Erlang

# Used

* `mix deps.get` installing dependencies.
* `iex -S mix` starting Elixir's interactive shell.

# Test

* `mix test` to run unit tests.
* `mix format` to format the code ensuring proper style (`.formatter.exs` rules).
* `mix dialyzer` to run dialyzer static code analysys and ensures code quality and control.

# Documentation

  In the interactive shell use the `mix docs` command to generate documentation that assists in using the system.

# Some examples of how to use the system

  It is important when doing operations that you have to set the value to '_00'. For monetary operations to go well.

## Example

If you want to create an account with a balance of '$ 250.47' the amount to be passed will be 250_47.

## Create account

```elixir
account1 = FinancialSystem.Account.new("Bacara Silva","bacara@gmail.com", 100, :BRL)
  %FinancialSystem.Account{
    balance: %Money{amount: 100, currency: :BRL},
    email: "bacara@gmail.com",
    name: "Bacara Silva"
  }
```

## Converting Currency

  Currency exchange values ​​from 'txt' file are old.

```elixir
 iex(1)> FinancialSystem.Converter.exchange(100.00, :BRL, :USD)
```

## Account transfer

```elixir
iex(9)> {account1, [account4]} = FinancialSystem.transaction(account1, [account4], 10_00)

iex(4)> {account3, [account1, account2]} = FinancialSystem.transaction(account3, [account1, account2], 1000_00)
```