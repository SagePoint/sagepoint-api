class CreateEmailLog < ActiveRecord::Migration
  def change
    create_table :email_logs do |t|
      t.integer :sender_id
      t.string :sender_email
      t.integer :receiver_id
      t.string :receiver_email
      t.string :message_type
      t.timestamps
    end
  end
end
