RSpec.describe Spree::Admin::ReviewSettingsController, type: :controller do
  stub_authorization!

  before do
    reset_spree_preferences
    user = create(:admin_user)
    allow(controller).to receive(:try_spree_current_user).and_return(user)
  end

  context "#update" do
    it "redirects to review settings page" do
      put :update, params: {preferences: {preview_size: 4}}
      expect(response).to redirect_to spree.edit_admin_review_settings_path
    end

    context 'For parameters:
            include_unapproved_reviews: true
            preview_size: 4,
            feedback_rating: true,
            track_locale: true' do
      subject { SpreeProductReviews::Config }

      it "sets preferred_include_unapproved_reviews to false" do
        put :update, params: {preferences: {include_unapproved_reviews: true}}
        expect(subject.preferred_include_unapproved_reviews).to be(true)
      end

      it "sets preferred_preview_size to 4" do
        put :update, params: {preferences: {preview_size: 4}}
        expect(subject.preferred_preview_size).to be(4)
      end

      it "sets preferred_track_locale to true" do
        put :update, params: {preferences: {track_locale: true}}
        expect(subject.preferred_track_locale).to be(true)
      end

      it "sets number of stars to 4" do
        put :update, params: {preferences: {number_of_stars: 6}}
        expect(subject.preferred_number_of_stars).to be(6)
      end
    end
  end

  context "#edit" do
    it "renders the edit template" do
      get :edit
      expect(response).to render_template(:edit)
    end
  end
end
