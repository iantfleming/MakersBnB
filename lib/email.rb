require 'mail'

options = { 
  :address              => 'smtp.gmail.com',
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => 'happyhost123@gmail.com',
  :password             => 'makers123',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }


Mail.defaults do
delivery_method :smtp, options
end