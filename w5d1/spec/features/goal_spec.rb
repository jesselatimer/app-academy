
require 'rails_helper'
require_relative '../support/auth_helper'

feature "redirects unless logged in" do
  scenario "at sign up page" do
    visit(new_goal_url)
    expect(page).to have_content "Sign in"
  end
end


feature "new goal process" do
  let(:user) { create(:user) }
  before(:each) do
    log_in(user)
  end

  let(:goal) { build(:goal) }
  scenario "has a new goal page" do
    visit(new_goal_url)
    expect(page).to have_content "New Goal"
  end

  scenario "creates new goal" do
    visit(new_goal_url)
    fill_in "Goal", with: goal.text
    click_on "submit"
    expect(page).to have_content goal.text
  end

  let(:user2) { create(:user) }
  scenario "creates a private goal" do
    visit(new_goal_url)
    fill_in "Goal", with: goal.text
    click_on "submit"
    expect(page).to have_content "private"
    click_on "signout"

    log_in(user2)
    visit(goals_url)
    expect(page).to_not have_content goal.text
  end

  scenario "creates a public goal" do
    visit(new_goal_url)
    fill_in "Goal", with: goal.text
    check "Public?"
    click_on "submit"
    expect(page).to have_content "public"
    click_on "signout"

    log_in(user2)
    visit(goals_url)
    expect(page).to have_content goal.text
  end
end

feature "edit goal process" do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user_id: user.id) }
  before(:each) do
    log_in(user)
  end

  scenario "successfully updates goal" do
    visit(edit_goal_url(goal))
    fill_in 'Goal', with: "new text"
    click_on "submit"
    expect(page).to have_content "new text"
  end
end

feature "delete goal process" do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user_id: user.id) }
  before(:each) do
    log_in(user)
  end

  scenario "successfully deletes goal" do
    visit(goal_url(goal))
    click_on "delete"
    expect(page).to have_content "Gooooooooooooaaaaaaaaaals!"
    expect(page).to_not have_content goal.text
  end
end
