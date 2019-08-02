class CreateAttractionTours < ActiveRecord::Migration[5.2]
  def change
    create_table :attraction_tours do |t|
      t.date :data
      t.string :checkin
      t.string :checkout
      t.references :attraction, foreign_key: true
      t.references :tour, foreign_key: true

      t.timestamps
    end
  end
end
