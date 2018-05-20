class AddEnqueuedToSmails < ActiveRecord::Migration
  def change
    add_column :smails, :enqueued, :boolean, default: false
  end
end
