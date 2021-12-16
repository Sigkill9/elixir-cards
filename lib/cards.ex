defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards

    ## Examples

      iex> deck = Cards.create_deck
      iex> Enum.count(deck)
      52
      
  """
  def create_deck do
    suits   = ["Spades", "Clubs", "Hearts", "Diamonds"]
    values  = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

@doc """
  Divides a deck into a hand and the remainder of the deck
  the `hand_size` argument indicates how many cards should
  be in the hand.

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(1)> {hand, _deck} = Cards.deal(deck, 1)
      iex(1)> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Determines whether a deck contains a given card

    ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Queen of Hearts")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Persists the deck to the file system


    ##  Examples:
      iex> deck = Cards.create_deck
      iex> Cards.save(deck, 'my_deck')
      :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a previously saved deck

  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "The file #{filename} does not exist"
    end
  end

  @doc """
    Creates a hand of specified length

    ## Examples
    
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
