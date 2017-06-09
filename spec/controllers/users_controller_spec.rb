require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user) {FactoryGirl.create(:user)}
  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end
  describe "GET #show" do
    before{get :show, params: {id: 1}}
    context "load success" do
      it "success" do
        expect(user).to eq user
      end
    end

    context "load error" do
      it "success" do
        expect(flash[:danger]).to eq(I18n.t("flash.danger_message"))
      end
    end
  end
end
