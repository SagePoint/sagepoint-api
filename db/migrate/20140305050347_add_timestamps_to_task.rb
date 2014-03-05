class AddTimestampsToTask < ActiveRecord::Migration
  def change
    add_column(:task_profiles, :created_at, :datetime)
    add_column(:task_profiles, :updated_at, :datetime)
  end
end
