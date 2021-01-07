RSpec.describe Spree::ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  let(:review_params) do
    {params:
          {product_id: product,
           review: {rating: 3,
                    name: "Random Man",
                    title: "Great Effin Product",
                    review: "Some long review text.. yadda yadda"}}}
  end

  before do
    allow(controller).to receive(:spree_current_user).and_return(user)
    allow(controller).to receive(:spree_user_signed_in?).and_return(true)
  end

  context "#index" do
    context "for a product that does not exist" do
      it "responds with a 404" do
        expect {
          get :index, params: {product_id: "not_real"}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "for a valid product" do
      it "lists approved reviews" do
        approved_reviews = [
          create(:review, :approved, product: product),
          create(:review, :approved, product: product)
        ]
        get :index, params: {product_id: product.slug}
        expect(assigns[:approved_reviews]).to match_array(approved_reviews)
      end
    end
  end

  context "#new" do
    context "for a product that does not exist" do
      it "responds with a 404" do
        expect {
          get :index, params: {product_id: "not_real"}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    it "fail if the user is not authorized to create a review" do
      allow(controller).to receive(:authorize!) { raise }
      expect {
        post :new, params: {product_id: product.slug}
        expect(response.body).to eq("ryanbig")
      }.to raise_error
    end

    it "renders the new template" do
      get :new, params: {product_id: product.id}
      expect(response.status).to be(200)
      expect(response).to render_template(:new)
    end
  end

  context "#create" do
    before do
      allow(controller).to receive(:spree_current_user).and_return(user)
    end

    context "for a product that does not exist" do
      it "responds with a 404" do
        expect {
          post :create, params: {product_id: "not_real"}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    it "creates a new review" do
      expect {
        post :create, review_params
      }.to change(Spree::Review, :count).by(1)
    end

    it "sets the ip-address of the remote" do
      allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return("127.0.0.1")
      post :create, review_params
      expect(assigns[:review].ip_address).to eq "127.0.0.1"
    end

    it "flashes the notice" do
      post :create, review_params
      expect(flash[:notice]).to eq Spree.t(:review_successfully_submitted)
    end

    it "redirects to product page" do
      post :create, review_params
      expect(response).to redirect_to spree.product_path(product)
    end

    it "removes all non-numbers from ratings param" do
      post :create, review_params
      expect(controller.params[:review][:rating]).to eq("3")
    end

    it "sets the current spree user as reviews user" do
      post :create, review_params
      assigns[:review][:user_id] = user.id
      expect(assigns[:review][:user_id]).to eq(user.id)
    end

    context "with invalid params" do
      it "renders new when review.save fails" do
        allow_any_instance_of(Spree::Review).to receive(:save).and_return(false)
        post :create, review_params
        expect(response).to render_template :new
      end

      it "does not create a review" do
        expect(Spree::Review.count).to be(0)
        post :create, params: {
          product_id: product,
          review: {rating: "not_a_number",
                   name: "Greta Thunder Chunks",
                   title: "Great Product",
                   review: "Big review text.."}
        }

        expect(Spree::Review.count).to be(0)
      end
    end

    # It always sets the locale so preference pointless
    context "when config requires locale tracking:" do
      it "sets the locale" do
        SpreeProductReviews::Config.preferred_track_locale = true
        post :create, review_params
        expect(assigns[:review].locale).to eq I18n.locale.to_s
      end
    end
  end
end
