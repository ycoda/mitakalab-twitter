require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  describe "GET #index" do
    before do
      @user = FactoryBot.create(:user)
    end
    context "許可されたユーザー" do
      it "returns http success" do
        sign_in @user
        get :index
        expect(response).to have_http_status("200")
      end
    end
  end

  describe "#new" do
    it "returns http success" do
      @user = create(:user)
      sign_in @user
      get :new
      expect(response).to be_successful
    end
  end
end
