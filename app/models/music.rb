require 'csv'

class Music < ApplicationRecord
  def self.display(search, music=self.all)
    !!search ? self.title_search(search[:title]) : music.sort_by{|music| music.title}
  end

  def self.title_search(title)
    results = self.where("title = '#{title.titleize}'")
    self.display(nil, results)
  end
end
