class ChangePhonesToPhone01 < ActiveRecord::Migration
  def change
    rename_column :users, :phones, :phone01
  end

  def change
    add_column :users, :phone02, :string
  end

end
