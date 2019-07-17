class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.date :start_date
      t.date :end_date
      t.integer :people

      t.timestamps
    end
  end
end
