class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :phones
      t.string :address
      t.string :photo

      t.timestamps
    end
  end
end
