require 'rails_helper'

RSpec.describe Domain, type: :model do
  subject {FactoryGirl.create(:domain)}

  context "Relationship" do
    it {is_expected.to have_many :user_domains}
    it {is_expected.to have_many :shop_domains}
    it {is_expected.to have_many :product_domains}
    it {is_expected.to have_many :users}
    it {is_expected.to have_many :shops}
    it {is_expected.to have_many :products}
    it {is_expected.to have_many :request_shop_domains}
    it {is_expected.to have_many :orders}
  end

  describe "#slug_candidates" do
    domain = Domain.new(name: "test modal", status: :professed, owner: 1)
    domain.save
    it {expect("test-modal").to eq domain.slug}
  end

  describe "#owner?" do
    domain = Domain.new(name: "test modal", status: :professed, owner: 1)
    user = User.new id: 1
    it {expect(true).to eq domain.owner? user.id}
  end

  describe "#manage_by?" do
    domain = Domain.new(name: "test modal", status: :professed, owner: 1)
    user = User.new id: 1
    it {expect(false).to eq domain.manage_by? user}
  end
end
