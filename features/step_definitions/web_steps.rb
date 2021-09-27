# frozen_string_literal: true

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

When('show me the page') do
  # rubocop:disable Lint/Debugger
  save_and_open_page
  # rubocop:enable Lint/Debugger
end

Then('I should be on the {string} page') do |website_location|
  path =  case website_location
          when 'specific'
            root_path
          else
            send("#{website_location.tr(' ', '_').underscore}_path")
          end

  expect(page).to have_current_path(path)
end

When('I select {string} from {string}') do |option, selector|
  page.select option, from: selector
end

When('I select {string} as the date for {string}') do |date_string, field|
  if date_string.match?(%r{/from now/})
    components  = date_string.split(' ')
    number      = components.shift
    date        = number.to_i.send(components.join('_'))
    fill_in field, with: date.strftime("'%m/%d/%Y'")
  end
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end
