class LineBot
    @@token = nil
    def self.get_raw_line_client
        return Line::Bot::Client.new { |config|
            config.channel_id = Rails.application.credentials.dig(:LINE, :channel_id)
            config.channel_secret = Rails.application.credentials.dig(:LINE, :channel_secret)
        }
    end

    def self.get_line_client
        @@client ||=  Line::Bot::Client.new { |config|
            config.channel_id = Rails.application.credentials.dig(:LINE, :channel_id)
            config.channel_secret = Rails.application.credentials.dig(:LINE, :channel_secret)
            #config.channel_token = 'DJWrR53s05onp4YH2lZfOFPOLAbm7FHce88rr0qDp9JxMkKi3lyX7Ds4PPDHslCUZJFiPMs09bH5EqId+w2RFRnNGMxMHzbnoufVbhYWtXDtz8QZd0z6faltn0imjzWJpBy2llF0ep1j+5vrm4UxGwdB04t89/1O/w1cDnyilFU='
            config.channel_token = get_token
        }
    end

    def self.get_token
        if @@token.present? && @@token['access_token']
            t = Time.now.to_i - 24 * 3600 * 10
            if(@@token['expires_dt'] > t)
                return @@token['access_token']
            end
        end
        client = get_raw_line_client
        res = client.issue_channel_token
        if !res.is_a?(Net::HTTPOK) 
            raise 'LINE SETTING ILLEGAL'
        end
        @@token = JSON.parse(res.body)
        @@token['expires_dt'] = Time.now.to_i + @@token['expires_in'].to_i
        return @@token['access_token']
    end

end
