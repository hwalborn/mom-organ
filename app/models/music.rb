
class Music < ApplicationRecord

  def self.downcase_n_save(music_params)
    music = Music.new(music_params)
    music.title.downcase!
    music.save
    music
  end

  def self.to_csv
    attributes = ["id", "title", "hymn_tune_title", "book", "page_number", "composer", "holiday"]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |music|
        csv << music.attributes.values_at(*attributes)
      end
    end
  end

  def self.display(search, music=self.all)
    !!search ? self.title_search(search[:title]) : music.sort_by{|music| music.title}
  end

  def self.title_search(title)
    search = "%#{title.downcase}%"
    results = self.where('title LIKE ?', search)
    self.display(nil, results)
  end
end
