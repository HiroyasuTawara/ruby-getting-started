class LinebotController < ApplicationController
require "line/bot"  # gem "line-bot-api"

 protect_from_forgery :except => [:callback]

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end
    

def janken(hand)
    bot_hand = ["グー", ""]
    
    if hand =~ /グ/
       message = {
                  type: "text",
                  text: ["パー！おれの勝ち!","パー！何で負けたか考えといて下さい","パー！残念！次はがんばりましょう"].shuffle.first
                }
        return message
    elsif hand =~/パ/
        message = {
            type: "text",
            text: ["チョキ！おれの勝ち！","チョキ！何で負けたか考えといて下さい","チョキ！残念！次はがんばりましょう"]
        }
        return message
    elsif hand =~/チョキ/
        message = {
            type: "text",
            text: ["グー！おれの勝ち！","グー！何で負けたか考えといて下さい","グー！残念！次はがんばりましょう"]
        }
        return message
    
    else
        message = {
                  type: "text",
                  text: "君の負け!"
                }
        return message
    end
end
  
    
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
             if event.message['text'] == "グー！" || event.message['text'] == "チョキ！" || event.message['text'] == "パー！"
                message = janken(event.message['text'])
                 client.reply_message(event["replyToken"], message)
             else
                message = {
                  type: "text",
                  text: "#{event.message['text']}!"
                }
                client.reply_message(event["replyToken"], message)
              end
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
