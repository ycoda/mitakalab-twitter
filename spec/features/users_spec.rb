require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "ユーザーの新規登録ができること", js: true do
    user = build(:user)

    visit root_path
    click_link "Sign up"
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    pass = user.password
    fill_in "Password", with: pass
    fill_in "Password confirmation", with: pass

    expect {
      click_button "Sign up"
    }.to change(User, :count).by(1)
  end
end
