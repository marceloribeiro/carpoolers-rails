# frozen_string_literal: true

Given('there is a chapter for {string}') do |location|
  city, state = location.split(',').map(&:strip)
  @chapter = FactoryBot.create :chapter, city: city, state: state
end

Then('I should see a chapter for {string}') do |location|
  city, state = location.split(',').map(&:strip)
  @chapter = Chapter.where(city: city, state: state).first
  expect(page).to have_content(@chapter.name)
end

When('I fill in the chapter form') do
  page.fill_in 'Name', with: 'SanFran'
  page.fill_in 'City', with: 'San Francisco'
  page.fill_in 'State', with: 'CA'
end

Then('I should see my chapter') do
  @chapter = Chapter.last
  expect(page).to have_content(@chapter.name)
end
