class Api::ImageController < ApplicationController
  # has_one_attached :image
  def index
      create()
  end

  def create
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    client = LineBot.get_line_client
    
    puts "ぱらむ"
    # puts params[:dataURL]
     uri = URI.parse(params[:dataURL])
    if uri.scheme == "data" then
      data = decode(uri)
      extension = extension(uri)
      avatar = put_s3 data, extension
    end
    puts "avatar"
    puts avatar
    # user = User.create(email: params[:email], avatar: avatar)
    # render json: user


    # message = {
    #   type: 'text',
    #   text: params[:postText]
    # };
    message = {
      "type": "image",
      "originalContentUrl": avatar,
      "previewImageUrl": avatar
    }
    response = client.push_message("U89341262df9bad23d72cadd6375d258b", message)
    # Image.create({ text: params[:postText] })
    p response
  end

  def decode(uri)
    opaque = uri.opaque
    data = opaque[opaque.index(",") + 1, opaque.size]
    Base64.decode64(data)
  end

  def extension(uri)
    opaque = uri.opaque
    mime_type = opaque[0, opaque.index(";")]
    case mime_type
    when "image/png" then
      ".png"
    when "image/jpeg" then
      ".jpg"
    else
      raise "Unsupport Content-Type"
    end
  end

  def put_s3(data, extension)
    file_name = Digest::SHA1.hexdigest(data) + extension
    s3 = Aws::S3::Resource.new(
      :region => 'ap-northeast-1',
      :access_key_id => Rails.application.credentials.dig(:aws, :access_key_id),
      :secret_access_key => Rails.application.credentials.dig(:aws, :secret_access_key)
    )
    bucket = s3.bucket("test-takechi")
    obj = bucket.object("img/#{file_name}")
    obj.put(acl: "public-read", body: data)
    obj.public_url
  end
end
