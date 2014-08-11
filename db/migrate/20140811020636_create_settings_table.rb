class CreateSettingsTable < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :streak, default: 3
      t.integer :end, default: 10
    end
  end
end
