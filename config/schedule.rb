every 1.day, :at => '4:30am' do
  rake "map:dopplr_trip_or_last_post"
  rake "photos:refresh"
end
