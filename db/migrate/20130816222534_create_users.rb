class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :login, index: true, default: nil
    	t.string :password, default: nil
    	t.string :active_user_code, default: nil
    	t.integer :employer_id, default: nil
    	t.datetime :last_login_time, default: nil
    	t.datetime :last_report_update, default: nil
    	t.string :report_seq, default: nil
    	t.boolean :is_enabled, default: 1
    	t.boolean :tos_accepted, default: nil
    	t.timestamps
    end
  end
end
