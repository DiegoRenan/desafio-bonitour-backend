class CreateAttractions < ActiveRecord::Migration[5.2]
  def change
    create_table :attractions do |t|
      t.string :code
      t.string :name
      t.integer :duration
      t.string :lat
      t.string :long

      t.timestamps
    end
  end
end
