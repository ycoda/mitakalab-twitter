require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user_or_usernameメソッド' do
    it 'name or usernameのどちらにも名前が無ければ無効' do
      user = User.create(name: "", username: "")
      user.valid?
      expect(user.errors[:name_or_username]).to include("can't be blank")
    end
  end

  context 'create_unique_emailメソッド' do
    it "メソッドが呼ばれたら有効なメールアドレスを作ること" do
      email = User.create_unique_email
      expect(email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    end

    it "一意なメールアドレスが作られること" do
      email = User.create_unique_email
      another_email = User.create_unique_email
      expect(email).to_not eq another_email
    end
  end
end
