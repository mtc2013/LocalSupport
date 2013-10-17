And(/^I have not approved cookie policy$/) do
  pending
  expect(cookies_accepted?).to eq false
end

Then(/^I should see an approve cookie policy message$/) do
  pending # express the regexp above with the code you wish you had
end

And(/^I have approved cookie policy$/) do
# set cookie directly in the test browser, skipping the UI 
  headers = {}
  cookie_string = headers['Set-Cookie']
  Capybara.current_session.driver.browser.set_cookie(cookie_string)
end

Then(/^I should not see an approve cookie policy message$/) do
  expect(page).to have_no_content("We will ask you to consent to our use of cookies")
end

