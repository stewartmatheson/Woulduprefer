gem('twitter4r', '0.3.0')
require('twitter')

class TwitterClient 
  def post_status(status)

    Twitter::Client.configure do |conf|
      conf.application_name = ''
      conf.application_version = '1.0'
      conf.application_url = ''
    end
  end
end