class CanvasController < ActionController::Base
  protect_from_forgery
  def index
  end

  def hook
    
    # message = {
    #   type: 'text',
    #   text: 'hello'
    # }
    # client = Line::Bot::Client.new { |config|
    #     config.channel_secret = "<channel secret>"
    #     config.channel_token = "<channel access token>"
    # }
    # response = client.reply_message("<replyToken>", message)
    # p response
    if is_break(params) then
      return
    end

    reply_token = get_reply_token(params)

    if has_message_event(params) then
      text = get_status_text(params)
      ReplySendMessageJob.perform_later(text, reply_token)
      return
    end

    uid = get_uid(params)
    end_user_line = get_enduser_line(uid)

    if not end_user_line.present? then
      render status: 400, json: { error_code: 'b1', error_message: 'lineアカウントが見つかりません' }
      return
    end

    if not end_user_line.entries.present? then
      render status: 400, json: { error_code: 'b2', error_message: 'entryが見つかりません' }
      return
    end

    entry = end_user_line.entries.last
    post_back_action(params, entry, reply_token)

    render json: {status: :ok}
  end
end
