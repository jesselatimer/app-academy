require 'rails_helper'
require_relative '../support/auth_helper'

feature "User can't make comments if not logged in" do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user_id: user.id) }

  scenario "redirects to sign-in page" do
    visit(user_url(user))
    expect(page).to have_css("h1", text: "Sign in")
    visit(goal_url(goal))
    expect(page).to have_css("h1", text: "Sign in")
  end
end

feature "User can make comments" do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user_id: user.id) }
  before(:each) { log_in(user) }

  scenario "makes comment on user" do
    make_comment(user_url(user))
  end

  scenario "makes comment on goal" do
    make_comment(goal_url(goal))
  end
end

feature "edit comments" do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:goal) { create(:goal, user_id: user.id) }
  before(:each) do
    log_in(user)
    make_comment(user_url(user))
  end

  scenario "can edit own comment" do
    click_on "edit_comment"
    fill_in "Comment", with: "I am become death, the destroyer of worlds."
    click_on "submit"
    expect(page).to have_content "I am become death, the destroyer of worlds."
  end

  scenario "can't edit other person's comments" do
    click_on "signout"
    log_in(user2)
    visit(user_url(user))
    expect(page).to_not have_link "edit_comment"
  end

end

feature "delete comments" do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:goal) { create(:goal, user_id: user.id) }
  before(:each) do
    log_in(user)
    make_comment(user_url(user))
  end

  scenario "can delete own comment" do
    click_on "delete_comment"
    expect(page).to_not have_content "Anything you can do I can do better."
  end

  scenario "can't delete other person's comments" do
    click_on "signout"
    log_in(user2)
    visit(user_url(user))
    expect(page).to_not have_button "delete_comment"
  end
end
