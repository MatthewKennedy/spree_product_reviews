feature "Reviews", :js do
  let!(:someone) { create(:user, email: "admin1@person.com", password: "password", password_confirmation: "password") }
  let!(:review) { create(:review, :approved, user: someone) }

  before do
    SpreeProductReviews::Config.include_unapproved_reviews = false
  end

  context "product with no review" do
    let!(:product_no_reviews) { create(:product) }
    it "informs that no reviews has been written yet" do
      visit spree.product_path(product_no_reviews)
      expect(page).to have_text Spree.t(:no_reviews_available)
    end

    # Regression test for #103
    context "shows correct number of previews" do
      before do
        create_list :review, 3, product: product_no_reviews, approved: true
        SpreeProductReviews::Config[:preview_size] = 2
      end

      it "displayed reviews are limited by the set preview size" do
        visit spree.product_path(product_no_reviews)
        expect(page.all(".review").count).to be(2)
      end
    end
  end

  context "when anonymous user" do
    context "visit product with review" do
      before do
        visit spree.product_path(review.product)
      end

      it "can see review title" do
        expect(page).to have_text review.title
      end

      it "can see a prompt to review" do
        expect(page).to have_text Spree.t(:read_reviews)
      end
    end
  end

  context "when logged in user" do
    context "visit product with review" do
      before do
        visit spree.product_path(review.product)
      end

      it "can see review title" do
        expect(page).to have_text review.title
      end

      it "can see create new review button" do
        expect(page).to have_text Spree.t(:read_reviews)
      end

      it "can create new review" do
        user = create(:user, email: "admin4546@person.com", password: "password", password_confirmation: "password")

        click_on Spree.t(:write_your_own_review)
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        if Spree.version.to_f < 4.0
          click_button "Login"
        else
          click_button "Log in"
        end
        expect(page).to have_text Spree.t(:leave_us_a_review_for, name: review.product.name)
        expect(page).not_to have_text "Show Identifier"

        within "#new_review" do
          click_star(3)

          fill_in "review_name", with: someone.email
          fill_in "review_title", with: "Great product!"
          fill_in "review_review", with: "Some big review text.."
          click_on "Submit your review"
        end

        expect(page).to have_text Spree.t(:review_successfully_submitted)
        expect(page).not_to have_text "Some big review text.."
      end
    end
  end

  private

  def click_star(num)
    find("label[for='#{num}-star']").click
  end
end
