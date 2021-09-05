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
