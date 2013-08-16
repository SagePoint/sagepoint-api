class CreateResourceProfile < ActiveRecord::Migration
  def change
    create_table :resource_profiles do |t|
    	t.string :email, index: true
    	t.integer :employer_id
    	t.integer :emp_serial_no
    	t.string :first_name, index: true
    	t.string :surname, index: true
    	t.integer :pay_type_id
    	t.integer :commited_tasks
    	t.integer :completed_tasks
    	t.integer :contact_profile_id
    	t.integer :user_id
    	t.datetime :hire_date
    	t.text :about_me
    	t.integer :commitment, default: 0
    	t.string :pm_rating
    	t.datetime :contract_end_date
    	t.integer :manager_id
    	t.integer :title_id
    	t.integer :division_id
    	t.boolean :is_enabled, default: 1
    	t.string :external_profile_link
    	t.text :custom_field_0
    	t.text :custom_field_1
    	t.text :custom_field_2
    	t.boolean :needs_update, default: 0
    	t.timestamps
    end
  end
end
