module Modules

  module ModuleSlack

    def send_message_to_slack(channel, message)
      if Rails.env.production?
        notifier = Slack::Notifier.new channel
        notifier.ping message
      else
        puts message
      end
    end

  end

end
