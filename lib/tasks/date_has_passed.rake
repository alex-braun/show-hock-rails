namespace :date_has_passed do
  desc 'Set show expired attr to true, remove old calendars if date has passed'

  task expired_shows: :environment do
    @shows = Show.where('end_date < ?', Date.today + 1.days)
    @shows.update_all(expired: true)
    puts 'hello'
    @calendars = Calendar.where('end_date < ?', Date.today + 1.days)
    @calendars.update_all(expired: true)
    puts 'hello'
  end

  task remove_calendars: :environment do
    # @calendars = Calendar.where(show_id: @shows.map(&:id))
    @calendars = Calendar.where('end_date < ?', Date.today - 2.days)
    @calendars.delete_all
  end

  task put_back: :environment do
    Show.update_all(expired: false)
  end
end
