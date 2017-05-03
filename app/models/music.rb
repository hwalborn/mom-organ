require 'csv'

class Music < ApplicationRecord
  def get_json
    CSV.open('lib/moms-music.csv', :headers => true).map do |x|
      x.to_h
    end
  end
end
