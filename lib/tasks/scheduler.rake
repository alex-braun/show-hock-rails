desc 'Set show expired attr to true, remove old calendars if date has passed'

task expired_shows: :environment do
  @shows = Show.where('end_date < ?', Date.today)
  @shows.update_all(expired: true)
end

task remove_calendars: :environment do
  # @calendars = Calendar.where(show_id: @shows.map(&:id))
  @calendars = Calendar.where('end_date < ?', Date.today - 2.days)
  @calendars.delete_all
end

task ping_dyno: :environment do
  require 'unirest'
  @ping_url = Rails.application.secrets.ping_url
  Unirest.get @ping_url
end
