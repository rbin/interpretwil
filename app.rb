require 'sinatra'
require 'twilio-ruby'

@account_sid = 'YOUR_ACC_ID'
@auth_token =  'AUTH_TOKEN'

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
