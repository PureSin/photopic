class Mailer < ActionMailer::Base
  default from: 'kelvin.ma23@gmail.com'

  def test_email(msg)
    mail to: "kelvin@codecademy.com", subject: "Success! You did it."
  end

  def self.test(msg)
    puts msg
  end

end
