class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
    	t.string :name, null: false
    	t.integer :main_address_id
    	t.boolean :send_email_flag, default: 0
    	t.integer :survey_profile_id
    	t.integer :full_time_utilization, default: 40
    	t.boolean :suggestion_flag, default: 0
    	t.string :resource_columns, length: 512
    	t.boolean :resources_shared, default: 0
    	t.boolean :was_onboarded, default: 0
    	t.boolean :certs_enabled, default: 1
    	t.boolean :pc_enabled, default: 1
    	t.boolean :pc_public, default: 1
    	t.boolean :res_public, default: 0
    	t.string :sharing_key, length: 6
    	t.boolean :allow_unlock, default: 1
    	t.boolean :clearance_enabled, default: 0
    	t.boolean :use_similarity, default: 1
    	t.text :custom_field_names
    	t.string :custom_logo
    	t.boolean :allow_resource_task_editing, default: 0
     	t.timestamps
    end
  end
end
