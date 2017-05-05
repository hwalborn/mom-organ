require 'csv'

class Music < ApplicationRecord
  def get_json
    CSV.open('lib/moms-music.csv', :headers => true).map do |x|
      x.to_h
    end
  end

  def self.display(search, music=self.all)
    !!search ? self.title_search(search[:title]) : music.sort_by{|music| music.title}
  end

  def self.title_search(title)
    results = self.where("title = '#{title}'")
    self.display(nil, results)
  end
end
