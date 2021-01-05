RSpec.describe Spree::ReviewsHelper, type: :helper do
  context "last star percentage" do
    let(:product) { build(:product) }
    specify do
      allow(product).to receive(:avg_rating).and_return(3.7)
      expect(last_star_percentage(product)).to be(70.0)

      allow(product).to receive(:avg_rating).and_return(1.4)
      expect(last_star_percentage(product)).to be(40.0)

      allow(product).to receive(:avg_rating).and_return(4.5)
      expect(last_star_percentage(product)).to be(50.0)
    end
  end

  context "accurate_average" do
    let(:product) { build(:product) }
    specify do
      allow(product).to receive(:avg_rating).and_return(3.70826)
      expect(accurate_average(product)).to be(3.7)

      allow(product).to receive(:avg_rating).and_return(1.412223)
      expect(accurate_average(product)).to be(1.4)

      allow(product).to receive(:avg_rating).and_return(4.5654343)
      expect(accurate_average(product)).to be(4.6)
    end
  end

  context "txt_stars" do
    specify do
      expect(txt_stars(2, true)).to eq "2 out of 5"
    end

    specify do
      expect(txt_stars(3, false)).to be_a String
      expect(txt_stars(3, false)).to eq("3")
    end
  end
end
