require 'rspec'
require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

RSpec.describe Round do
  before :each do
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @cards = [@card_1, @card_2, @card_3]
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @round = Round.new(@deck)
  end

  it 'exists' do
    expect(@round).to be_instance_of(Round)
  end

  it 'shows the current card' do
    expect(@round.current_card). to eq(@card_1)
  end

  it 'has a deck' do
    expect(@round.deck).to be_instance_of(Deck)
  end

  it 'has turns' do
    expect(@round.turns).to eq([])
  end

  it 'shows the number of correct answers' do
    @new_turn = @round.take_turn("Juneau")

    expect(@round.number_correct). to eq(1)
    expect(@new_turn.correct?).to eq(true)
  end

  it 'shows the number of correct answers by category' do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    expect(@round.number_correct_by_category(:STEM)).to eq(0)
    expect(@round.number_correct_by_category(:Geography)).to eq(1)
  end

  it 'shows the percent correct' do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    expect(@round.percent_correct).to eq(50.0)
  end

  it 'shows the percent correct by category' do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    expect(@round.percent_correct_by_category(:Geography)).to eq(100.0)
  end
end
