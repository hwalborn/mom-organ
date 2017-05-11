# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


case Rails.env
when "development"
  CSV.open('lib/moms-music.csv', :headers => true).map do |x|
    music = x.to_h
    Music.create(title: music['title'].downcase, hymn_tune_title: music['hymn_tune_title'], book: music['book'].downcase, page_number: music['page_number'], composer: music['composer'].downcase, holiday: music['holiday'])
  end
  Account.create(username: 'rchildress', password: 'password')
  Account.create(username: 'holt', password: 'password')
when "production"
  CSV.open('lib/moms-music.csv', :headers => true).map do |x|
    music = x.to_h
    Music.create(title: music['title'].downcase, hymn_tune_title: music['hymn_tune_title'], book: music['book'].downcase, page_number: music['page_number'], composer: music['composer'].downcase, holiday: music['holiday'])
  end
  Account.create(username: 'rchildress', password: 'password')
  Account.create(username: 'holt', password: 'password')
end
