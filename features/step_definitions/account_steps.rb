# frozen_string_literal: true

Given('I am on the home page') do
  page.visit '/'
end

When('I click {string}') do |label|
  page.click_link label
end

When('I fill in the signup form') do
  page.fill_in 'First name', with: 'John'
  page.fill_in 'Last name', with: 'Doe'
  page.fill_in 'E-mail', with: 'johndoe@email.com'
  page.fill_in 'Password', with: 'change123'
  page.fill_in 'Re-enter Password', with: 'change123'
end

When('I press {string}') do |button_title|
  page.click_button button_title
end

Then('I should be logged in') do
  expect(page).to have_content('My Account')
end
