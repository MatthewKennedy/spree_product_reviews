RSpec.describe SpreeProductReviews::Configuration do
  subject { described_class.new }

  before do
    reset_spree_preferences
  end

  it "have the include_unapproved_reviews preference" do
    expect(subject).to respond_to(:preferred_include_unapproved_reviews)
    expect(subject).to respond_to(:preferred_include_unapproved_reviews=)
    expect(subject.preferred_include_unapproved_reviews).to be(false)
  end

  it "have the preview_size preference" do
    expect(subject).to respond_to(:preferred_preview_size)
    expect(subject).to respond_to(:preferred_preview_size=)
    expect(subject.preferred_preview_size).to be(3)
  end

  it "have the show_email preference" do
    expect(subject).to respond_to(:preferred_show_email)
    expect(subject).to respond_to(:preferred_show_email=)
    expect(subject.preferred_show_email).to be(false)
  end

  it "have the track_locale preference" do
    expect(subject).to respond_to(:preferred_track_locale)
    expect(subject).to respond_to(:preferred_track_locale=)
    expect(subject.preferred_track_locale).to be(false)
  end

  it "have the show_identifier preference" do
    expect(subject).to respond_to(:preferred_show_identifier)
    expect(subject).to respond_to(:preferred_show_identifier=)
    expect(subject.preferred_show_identifier).to be(false)
  end

  it "have the number_of_stars preference" do
    expect(subject).to respond_to(:preferred_number_of_stars)
    expect(subject).to respond_to(:preferred_number_of_stars=)
    expect(subject.preferred_number_of_stars).to be(5)
  end
end
