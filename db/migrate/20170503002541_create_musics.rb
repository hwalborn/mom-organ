class CreateMusics < ActiveRecord::Migration[5.0]
  def change
    create_table :musics do |t|
      t.string :title
      t.string :hymn_tune_title
      t.string :book
      t.string :page_number
      t.string :composer
      t.string :holiday
      t.timestamps
    end
  end
end
