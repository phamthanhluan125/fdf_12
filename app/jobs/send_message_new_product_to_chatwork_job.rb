class SendMessageNewProductToChatworkJob < ApplicationJob
  queue_as :default

  def perform product
    SendMessageNewProductToChatworkService.new(product).send
  end
end