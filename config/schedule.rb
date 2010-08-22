every 1.day, :at => '4:30am' do
  rake "map:current_dopplr_trip"
  rake "photos:refresh"
end
