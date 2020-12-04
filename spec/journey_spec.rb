require './lib/oystercard'

describe Journey do
let(:card) {Oystercard.new}

  describe "#fare" do
    it 'returns penalty fare' do
      card.top_up(15)
      subject.complete
      card.touch_out("Waterloo")
      expect(card.journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns minimum fare' do
      card.top_up(10)
      card.touch_in("x")
      card.touch_out("y")
      expect(card.journey.fare).to eq Journey::MINIMUM_FARE
    end
  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(card.journey.in_journey?).to eq(false)
    end
  end

  describe '#entry_station' do

    it 'stores the entry station' do
      card.top_up(10)
      card.touch_in("Waterloo")
      expect(card.journey.entry_station).to eq "Waterloo"
    end
  end

  describe '#exit_station' do

    it 'stores the exit station' do
      card.top_up(10)
      card.touch_in("Waterloo")
      card.touch_out("Tooting")
      expect(card.journey.exit_station).to eq "Tooting"
    end
  end

end
