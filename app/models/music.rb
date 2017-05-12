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
