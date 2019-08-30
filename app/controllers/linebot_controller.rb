class LinebotController < ApplicationController
require "line/bot"  # gem "line-bot-api"

 protect_from_forgery :except => [:callback]

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end
    
    if event.message['text'] == "じゃんけん"
        message = [
            {
             puts "じゃんけん・・・・"

def janken
puts "[0]グー\n[1]チョキ\n[2]パー"

player=gets.to_i
program=rand(3)

<<<<<<< HEAD
jankens = ["グー!","チョキ!","パー!"]
=======
jankens = ["グー","チョキ","パー"]
>>>>>>> 96fb635662dde9fb5ce16ee521219a98c8ba23f9
puts "あなたの手:#{jankens[player]},相手の手:#{jankens[program]}"

if player == program
  puts "あいこで"
  return true

elsif(player == 0 && program==1)||(player==1 && program == 2)||(player==2 && program == 0)
  puts "あなたの勝ちです"
  return false

else
  puts "あなたの負けです"
  return false
end
end

nextgame = true
while nextgame 
  nextgame = janken
<<<<<<< HEAD
end   
            }
            ]
=======
end
>>>>>>> 96fb635662dde9fb5ce16ee521219a98c8ba23f9
    
    def callback
      body = request.body.read
  
      signature = request.env["HTTP_X_LINE_SIGNATURE"]
      unless client.validate_signature(body, signature)
        error 400 do "Bad Request" end
      end
  
      events = client.parse_events_from(body)
  
      events.each { |event|
        case event
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            message = {
              type: "text",
              text: event.message["text"] + "!"
            }
            client.reply_message(event["replyToken"], message)
          when Line::Bot::Event::MessageType::Location
            message = {
              type: "location",
              title: "あなたはここにいますか？",
              address: event.message["address"],
              latitude: event.message["latitude"],
              longitude: event.message["longitude"]
            }
            client.reply_message(event["replyToken"], message)
          end
        end
      }
  
      head :ok
    end
end
