class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.string :description
      t.string :provider_odesk_id
      t.string :client_odesk_id
      t.string :max_hours
      t.decimal :rate, :precision => 5, :scale => 2 
      t.decimal :hours_worked, :precision => 5, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
