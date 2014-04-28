require 'doc_raptor'
require_relative 'mailer'
require_relative 'data_processor'
mailer = Mailer.new host: config['MAIL_HOST'], port: config['MAIL_PORT'], user: config['MAIL_USER'], password: config['MAIL_PASSWORD'], mail_sender: config['MAIL_SENDER']
doc_raptor_token = config['DOCRAPTOR_TOKEN']
DocRaptor.api_key doc_raptor_token
processor = DataProcessor.new mailer: mailer
processor.process_data params
