require 'erb'
require 'mail'
class Mailer
	def initialize host: nil, port: 25, user: nil, password: nil, mail_sender: nil
		@host = host
    @port = port
		@user = user
		@password = password
		@mail_sender = mail_sender
	end
	def deliver to_email: nil, to_fullname: nil, attachment: nil, title: nil
		file_name = "#{title}.pdf"
  	b = binding
  	html = ERB.new(html_template).result(b)
  	text = ERB.new(text_template).result(b)
		from_mail = mail_sender
  	mail = Mail.new do
  		charset = "UTF-8"
			to 			"#{to_fullname} <#{to_email}>"
			from		from_mail
			subject title
		  text_part do
		  	content_type "text/plain; charset=UTF-8"
		    body text
		  end
		  html_part do
		    content_type 'text/html; charset=UTF-8'
		    body html
		  end
		  add_file filename: file_name, content: attachment
		end
		mail.delivery_method :smtp, address: host, user_name: user, password: password, port: port
		mail.deliver
	end
	private
	attr_reader :host, :user, :password, :mail_sender, :port
  def html_template
    File.read "template.html.erb"
  end
  def text_template
    File.read "template.txt.erb"
  end
end
