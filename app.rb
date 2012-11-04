require 'sinatra'
require 'twilio-rb'

@account_sid = 'ACacce7accff8f3b232da7f94d4b7c05ea'
@auth_token =  'd182a62755fd30ea218f969ad01d523d'

@client = Twilio::REST::Client.new(@account_sid, @auth_token)
ACCOUNT = @client.account

get '/script' do
  Twilio::TwiML::Response.new do |r|
      r.Say 'Yo! Whats going on? Leave me a message!'
      r.Record :action => '/handle_recording', :transcribe => true, :transcribeCallback => '/transcribe'
    end.text
end

get '/transcriptions' do
  @transcription = ACCOUNT.transcriptions.list.map(&:transcription_text).join('<br/>')
end

post '/transcribe' do
  puts "TRANSCRIPTION"
  puts params
end

post '/handle_recording' do
  puts "GOGOOGO"
  puts params
end
