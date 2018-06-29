require 'rails_helper'

RSpec.feature Users::SessionsController, type: :feature do
  scenario "新規登録したユーザーはログインできること" do
    user = create(:user)

    visit root_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content('つぶやく')
  end
end
