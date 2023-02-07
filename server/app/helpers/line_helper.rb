# require 'line/bot'
module LineHelper
    def get_raw_line_client
        return Line::Bot::Client.new { |config|
            config.channel_id = Rails.application.credentials.dig(:LINE, :channel_id)
            config.channel_secret = Rails.application.credentials.dig(:LINE, :channel_secret)
        }
    end
    def get_line_client
        @client ||=  Line::Bot::Client.new { |config|
            config.channel_id = Rails.application.credentials.dig(:LINE, :channel_id)
            config.channel_secret = Rails.application.credentials.dig(:LINE, :channel_secret)
            #config.channel_token = 'DJWrR53s05onp4YH2lZfOFPOLAbm7FHce88rr0qDp9JxMkKi3lyX7Ds4PPDHslCUZJFiPMs09bH5EqId+w2RFRnNGMxMHzbnoufVbhYWtXDtz8QZd0z6faltn0imjzWJpBy2llF0ep1j+5vrm4UxGwdB04t89/1O/w1cDnyilFU='
            config.channel_token = get_token
        }
    end

    def get_token
        if @token.present? && @token['access_token']
            t = Time.now.to_i - 24 * 3600 * 10
            if(@token['expires_dt'] > t)
                return @token['access_token']
            end
        end
        client = get_raw_line_client
        res = client.issue_channel_token
        if !res.is_a?(Net::HTTPOK) 
            raise 'LINE SETTING ILLEGAL'
        end
        @token = JSON.parse(res.body)
        @token['expires_dt'] = Time.now.to_i + @token['expires_in'].to_i
        return @token['access_token']
    end
    
    def send_message(message)
        client = get_line_client
        erb = ERB.new(message.body)
        attr = attributes.merge({reserve_label: reserve.label})
        if message.message_type == 'text'
            payload = {
                type: message.message_type,
                text: erb.result_with_hash(attr)
            }
        elsif message.message_type == 'flex'
            payload = {
                type: message.message_type,
                altText: 'メッセージ'
            }
            txt = erb.result_with_hash(attr)
            json = JSON.parse(txt)
            payload["contents"] = json
        else
            json = JSON.parse(message.body)
            payload = json
        end
        p payload
        p response = client.push_message(self.line_id, payload)
        p response.body
    end

    def register_line
        message = Message.getMessage('line', 'register')
        if message.nil?
            raise 'register message not found'
        end
        LinePushMessageJob::perform_now(self, message)
    end

    def update_line
        message = Message.getMessage('line', 'update')
        if message.nil?
            raise 'update message not found'
        end
        LinePushMessageJob::perform_now(self, message)
    end

    def cancel_line
        message = Message.getMessage('line', 'cancel')
        if message.nil?
            raise 'cancel message not found'
        end
        LinePushMessageJob::perform_now(self, message)
    end

    def checkin_line
        message = Message.getMessage('line', 'checkin')
        if message.nil?
            raise 'checkin message not found'
        end
        LinePushMessageJob::perform_now(self, message)
    end

    def remind_today_line
        message = Message.getMessage('line', 'remind_today')
        if message.nil?
            raise 'remind today message not found'
        end
        LinePushMessageJob::perform_now(self, message)
    end

    def remind_one_before_day_line
        message = Message.getMessage('line', 'remind_one_before_day')
        if message.nil?
            raise 'remind one before day message not found'
        end
        LinePushMessageJob::perform_now(self, message)
    end

    def after_line
        message = Message.getMessage('line', 'after')
        if message.nil?
            raise 'after message not found'
        end
        LinePushMessageJob::perform_now(self, message)
    end

    def floor_image_line
        message = Message.getMessage('line', 'floor')
        if message.nil?
            raise 'floor message not found'
        end
        LinePushMessageJob::perform_now(self, message)
    end
end