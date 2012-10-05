class AddMetaInfoToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :fit, :string
    # great, ok, souring
    add_column :assignments, :interest_level, :string
    # interesting, average, 0, enh

    
  end

  def self.down
    remove_column :assignments, :fit
    remove_column :assignments, :interest_level
  end
end
