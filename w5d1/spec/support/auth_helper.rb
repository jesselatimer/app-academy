def log_in(user)
  visit(new_session_url)
  fill_in 'Username', with: user.username
  fill_in 'Password', with: user.password
  click_on "submit"
end

def make_comment(path)
  visit(path)
  fill_in "make snarky comment", with: "Anything you can do I can do better."
  click_on "submit"
  expect(page).to have_content "Anything you can do I can do better."
end
