namespace :otp do
  desc 'Rake task to activate two-factor authentication'
  task :activate  => :environment do
    User.each do |user|
      user.otp_required_for_login = true
      user.otp_secret = User.generate_otp_secret
      user.save!
      puts "=> Two-factor authenticated activated for '#{user.email}'."
    end
  end

  desc 'Rake task to deactivate two-factor authentication'
  task :deactivate  => :environment do
    User.each do |user|
      user.otp_required_for_login = false
      user.save!
      puts "=> Two-factor authenticated deactivated for '#{user.email}'."
    end
  end

end
