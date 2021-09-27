# frozen_string_literal: true

def build_carpools(table, user = nil)
  data    = table.raw
  headers = data.shift

  @carpools = data.each_with_object([]) do |item, all|
    atts = {}
    item.each_with_index { |value, index| atts[headers[index].to_sym] = value }

    atts[:chapter]  = Chapter.where(name: atts.delete(:chapter_name)).first
    atts[:user]     = user if user.present?
    all << FactoryBot.create(:carpool, atts)
  end
end

Given('the following carpools exist:') do |table|
  build_carpools(table)
end

Given('I created the following carpools:') do |table|
  build_carpools(table, @user)
end

Then('I should have joined a carpool') do
  expect(@user.carpool_passengers.count).to eql(1)
end

Then('my joined carpool status should be {string}') do |status|
  @carpool_passenger = @user.carpool_passengers.first
  expect(@carpool_passenger.status).to eql(status)
end

Then('I should have created a carpool') do
  expect(@user.carpools.count).to eql(1)
end

# rubocop:disable Metrics/LineLength
Then('my {string} carpool {string} location should be {string}') do |status, type, loc|
  case status
  when 'joined'
    @carpool = @carpool_passenger.carpool
  when 'created'
    @carpool = @user.carpools.last
  end

  expect(@carpool.send("#{type}_pickup_location").location).to eql(loc)
end

Given('my carpool to {string} has a request to join from {string}') do |location, user_name|
  @carpool = @user.carpools.select do |c|
    c.end_pickup_location.location == location
  end.first
  first, last = user_name.split(' ')
  @passenger = FactoryBot.create :user, first_name: first, last_name: last
  @passenger.request_to_join_carpool(@carpool)
end
# rubocop:enable Metrics/LineLength

Then('{string} carpool request should be approved') do |user_name|
  first, last = user_name.split(' ')
  @passenger = User.where(first_name: first, last_name: last).first
  expect(@passenger.carpool_passengers.first.status).to eql('approved')
end
