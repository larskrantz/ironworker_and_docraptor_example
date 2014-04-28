require 'doc_raptor'
class DataProcessor
	attr_reader :mailer
	def initialize mailer: nil
		@mailer = mailer
	end
  def process_data data
    status_id = data['status_id']
    status = DocRaptor.status(status_id)
    timeout_time = Time.now + 300 # 5 minutes
    while !(['completed','failed'].include? status['status']) && Time.now <= timeout_time
      sleep 10
      status = DocRaptor.status(status_id)
    end
    if status['status'] == 'completed'
      file = DocRaptor.download(status['download_key'])
      mailer.deliver(to_email: data['send_to_mail'], to_fullname: data['fullname'], attachment: file, title: data['title'])
      puts "Sent #{data['title']}-pdf to #{data['fullname']} (#{data['send_to_mail']})"
    else
      message = "Error when creating #{data['title']}-pdf for #{data['send_to_mail']}"
      status_message = status['validation_errors'] if status
      err_msg = "#{message} #{status_message}"
      puts err_msg
      raise err_msg
    end
  end
end
