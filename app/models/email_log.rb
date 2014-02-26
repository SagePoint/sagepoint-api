class EmailLog < ActiveRecord::Base  
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id"

  scope :past_day, where("date(created_at) >= DATE(DATE_SUB(NOW(),INTERVAL 1 DAY))")
  def EmailLog.log!(sender,receiver,message_type)
    email_log = EmailLog.new()
    email_log.sender = sender
    email_log.sender_email = sender.email.strip rescue nil
    email_log.receiver = receiver
    email_log.receiver_email = receiver.email.strip rescue nil
    email_log.message_type = message_type
    email_log.save!
  end
  def EmailLog.log_by_email!(sender_email,receiver_email,message_type)
    email_log = EmailLog.new()
    email_log.sender_email = sender_email.strip
    email_log.receiver_email = receiver_email.strip
    email_log.message_type = message_type
    email_log.save!
  end
end