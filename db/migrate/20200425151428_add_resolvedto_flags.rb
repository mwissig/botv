class AddResolvedtoFlags < ActiveRecord::Migration[5.2]
  def change
        add_column :flags, :closed, :boolean, :default => false
  end
end
