
require 'rails_helper'
require_relative '../support/auth_helper'

feature "the signup process" do
  scenario "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content "Sign up"
  end

  feature "signing up a user" do
    before(:each) do
      visit(new_user_url)
      fill_in 'Username', with: "biscuits"
      fill_in 'Password', with: "gravies"
      click_on "submit"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "biscuits"
    end
  end
end

feature "logging in" do
  let(:user) { create(:user) }
  scenario "shows username on the homepage after login" do
    log_in(user)
    expect(page).to have_content user.username
  end
end

feature "logging out" do
  let(:user) { create(:user) }
  scenario "begins with logged out state" do
    visit(root_url)
    expect(page).to have_link "Sign in"
  end

  scenario "doesn't show username on the homepage after logout" do
    log_in(user)
    expect(page).to have_button("signout")
    click_on "signout"
    expect(page).to_not have_content user.username
  end
end
