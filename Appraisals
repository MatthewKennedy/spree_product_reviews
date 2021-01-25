appraise "spree-3-7" do
  gem "spree", branch: "3-7-stable", git: "https://github.com/spree/spree.git"
  gem "spree_auth_devise", "~> 3.4.0"
  gem "rails-controller-testing"
end

appraise "spree-4-2" do
  gem "spree", "~> 4.2.0.rc2"
  gem "spree_auth_devise", "~> 4.2.0"
  gem "rails-controller-testing"
end

appraise "spree-master" do
  gem "spree", github: "spree/spree", branch: "master"
  gem "spree_auth_devise", github: "spree/spree_auth_devise", branch: "master"
  gem "rails-controller-testing"
end
