require 'rails_helper'

RSpec.feature "Tweets", type: :feature do
  scenario "ツイートしてからツイートを削除する", js: true do
    user = create(:user)

    visit root_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "つぶやく"
    fill_in "Title", with: "first tweet"
    fill_in "Content", with: "日新やきそばUFO"
    expect {
      click_button "Create Tweet"
    }.to change(user.tweets, :count).by(1)

    expect {
      click_link 'ツイートを削除する'
    }.to change(user.tweets, :count).by(-1)
  end
end
