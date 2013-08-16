class CreateUserAlias < ActiveRecord::Migration
  def change
    create_table :user_aliases do |t|
    	t.integer :user_id, null: false
    	t.text :alias_hash
    end
  end
end
