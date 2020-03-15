defmodule FinancialSystem.Coin do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "http://apilayer.net/api")
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.DecodeJson)

  @api_key "17dab43de91dedc4ea8e0dc86ec3ae69"

  @moduledoc """
  The 'Coin' module it has functions that handles that has currency information and checks if the currency is valid as 
  stipulated by ISO 4217. The rates and currencies are requested from the website https://currencylayer.com/ using a 
  free trial api. To handle the information obtained behind the requests, libs tesla, jason and hackney were used. 
  Ever wehave information actuali of value of each currency.
  """

  @doc """  
  The function currency_list displays a list with the atoms that correspond to all currencies considered by ISO 4217. 

  ## Example
  
        list = FinancialSystem.Coin.currency_list

  """  

  def currency_list() do
    {:ok, response} = get("/list?%20access_key=#{@api_key}")
    response = response.body
    response
    |> Map.fetch("currencies")
    |> elem(1)    
    |> Enum.map(fn {currency, _descrition} -> String.to_atom(currency) end)
  end

  @doc """   
  The currency rate function displays a list with currency quotes based on the dollar, 
  values ​​updated due to the information being taken from a specific currency quote api. 

  ## Example

        rates = FinancialSystem.Coin.currency_rate           
  
  """ 

  def currency_rate() do
    {:ok, response} = get("live?access_key=#{@api_key}&format=1")
    response = response.body 
    |> Map.fetch("quotes")
    |> elem(1)
    
    response_value =
      response
      |> Enum.map(fn {_currency, value} -> value end)

    # deixar apenas os simbolos de moedas 
    response_currecy =
      response
      |> Enum.map(fn {currency, _value} -> currency end)
      # remover o prefixo USD
      |> Enum.map(fn x -> prefix_remove(x, "USD") end)

    #junta as variaveis em uma lista
    Enum.zip(response_currecy, response_value)    
  end

  # function to remove prefix of a string
  defp prefix_remove(full, prefix) do
    base = byte_size(prefix)
    binary_part(full, base, byte_size(full) - base)
  end

  @doc """
  Function that validates the currency according to the code established by ISO 4217.

  ## Examples

        iex(2)> FinancialSystem.Coin.is_valid?(:USD)
        true
        iex(3)> FinancialSystem.Coin.is_valid?(:USS)
        false
  
  """
  @spec is_valid?(atom) :: boolean()
  def is_valid?(currency_validetion) do
    currency_list()
    |> Enum.any?(fn currency -> currency == currency_validetion end)
  end
end
