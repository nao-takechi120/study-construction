namespace :push_message do
  desc 'プッシュメッセージ送信'
  task push_message: :environment do
    client = LineBot.get_line_client
    
    message = {
      type: 'text',
      text: '定期実行テスト'
    };
    response = client.push_message("U89341262df9bad23d72cadd6375d258b", message)
  end
  end
