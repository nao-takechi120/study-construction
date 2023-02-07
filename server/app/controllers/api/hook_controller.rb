class Api::HookController < ApplicationController
  def index
      hook()
  end

  def create
      hook()
  end

  def hook
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    client = LineBot.get_line_client
    message = {
      type: 'text',
      text: params[:postText]
    };
    response = client.push_message("U89341262df9bad23d72cadd6375d258b", message)
    p response
  end
end
