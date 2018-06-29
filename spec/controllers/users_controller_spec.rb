require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  context "#new" do
    it "200レスポンスを返すこと" do
      get :new
      expect(response).to be_successful
    end
  end

  context "#create" do
    it "200レスポンスを返すこと" do
      @user = create(:user)
      sign_in @user
      expect(response).to have_http_status "200"
    end
  end
end
