require 'csv'

class Music < ApplicationRecord
  def self.display(search, music=self.all)
    !!search ? self.title_search(search[:title]) : music.sort_by{|music| music.title}
  end

  def self.title_search(title)
    search = "%#{title.downcase}%"
    results = self.where('title LIKE ?', search)
    self.display(nil, results)
  end
end
