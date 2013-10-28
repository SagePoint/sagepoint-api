namespace :devise do
  desc 'Mass password reset and send email instructions'
  task :mass_password_reset => :environment do
    model = ENV['MODEL'] || 'User'
    begin
      model_mailer = "#{model}Mailer".constantize
      model = model.constantize

      model.find_each(:conditions => ['email = ?', "dev@sagepointsoftware.com"]) do |record|
        # Assign a random password
        random_password = User.send(:generate_token, 'encrypted_password').slice(0, 8)
        record.password = random_password
        record.save
        # Send change notification (Ensure you have created #{model}Mailer e.g. UserMailer)
        model_mailer.password_reset(record, random_password).deliver
      end
    rescue Exception => e
      puts "Error: #{e.message}"
    end
  end
end