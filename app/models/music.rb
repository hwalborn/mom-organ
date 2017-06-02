require 'net/http'

class Music < ApplicationRecord

  def self.downcase_n_save(music_params)
    music = Music.new(music_params)
    music.composer.downcase!
    music.book.downcase!
    music.title.downcase!
    music.hymn_tune_title.downcase!
    music.save
    music
  end

  def self.to_csv
    attributes = ["id", "title", "hymn_tune_title", "book", "page_number", "composer", "holiday"]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.sort_by{|music| music.title}.each do |music|
        music.title = music.title.titleize
        csv << music.attributes.values_at(*attributes)
      end
    end
  end

  def self.post_authorize(token)
    grant = Base64.strict_encode64("#{Rails.application.secrets.client_id}:#{Rails.application.secrets.client_secret}")
    options = {grant_type: 'authorization_code',
               code: token,
               redirect_uri: 'http://localhost:3000/callback'}
    RestClient.post("https://accounts.spotify.com/api/token", body=options, headers={'Authorization' => "Basic #{grant}"})
  end

  def self.authorize
    response = RestClient.get("https://accounts.spotify.com/authorize/?client_id=427aca466f7b4a67bf78a85d5af51b3a&response_type=code&redirect_uri=http%3A%2F%2Flocalhost:3000%2Fcallback")
    # response = RestClient.get("https://accounts.spotify.com/authorize/?client_id=#{Rails.application.secrets.client_id}&response_type=code&redirect_uri=http%3A%2F%2Flocalhost:3000%2Fcallback")
    byebug
  end

  def self.display(search, music=self.all)
    !!search ? self.title_search(search[:search_by], search[:query]) : music.sort_by{|music| music.title}
  end

  def self.title_search(column, query)
    search = "%#{query.downcase}%"
    col = column.gsub(' ', '_')
    results = self.where("#{col} LIKE ?", search)
    self.display(nil, results)
  end
end
