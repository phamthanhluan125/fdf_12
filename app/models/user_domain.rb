class UserDomain < ApplicationRecord
  strip_attributes only: [:description, :name]

  belongs_to :user
  belongs_to :domain

  enum role: {owner: 0, manager: 1, member: 2}

  after_destroy :destroy_data

  scope :user_ids_by_domain, -> domain do
    where(domain_id: domain.id, role: :manager).pluck :user_id
  end

  scope :list_all_user_domains, -> domain {where domain_id: domain}

  def destroy_data
    self.user.products.each do |product|
      ProductDomain.destroy_all domain_id: self.domain.id, product_id: product.id
    end
    self.user.shops.each do |shop|
      ShopDomain.destroy_all domain_id: self.domain.id, shop_id: shop.id
    end
  end

  def create_event_add_user_domain user_id
    Event.create message: :join_domain,
      user_id: user_id, eventable_id: self.domain.id, eventable_type: UserDomain.name,
      eventitem_id: self.user.id
  end

  def create_event_add_manager_domain user_id
    if self.manager?
      Event.create message: self.role,
        user_id: user_id, eventable_id: self.domain.id, eventable_type: Domain.name,
        eventitem_id: self.id
    elsif self.member?
      Event.create message: self.role,
        user_id: user_id, eventable_id: self.domain.id, eventable_type: Domain.name,
        eventitem_id: self.user.id
    end
  end
end
