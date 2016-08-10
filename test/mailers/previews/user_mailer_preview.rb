# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def devise_invitation_instructions
    Devise::Mailer.invitation_instructions(User.first, 'dummy token')
  end

  def devise_confirmation_instructions
    Devise::Mailer.confirmation_instructions(User.first, 'dummy token')
  end
end
