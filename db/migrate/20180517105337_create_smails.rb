class CreateSmails < ActiveRecord::Migration
  def change
    create_table :smails do |t|
      t.text :message
      t.timestamp :scheduled_at

      t.timestamps
    end
  end
end
