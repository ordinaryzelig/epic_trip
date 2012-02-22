class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :calendar, null: false
      t.date :started_on, null: false
      t.date :ended_on, null: false
      t.string :name
      t.text :notes

      t.timestamps
    end
    add_index :events, :calendar_id
    add_index :events, :started_on
    add_index :events, :name
  end
end
