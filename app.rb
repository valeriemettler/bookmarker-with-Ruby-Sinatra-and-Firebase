require 'sinatra'
require 'firebase'

fb = Firebase::Client.new('https://girldevchat.firebaseio.com/')

get '/' do
  return "123 Hello World!"
end


get '/fb' do

  h = "<html><body><h1>Bookmarks and Tags:</h1>"
  h = h +  "<form action='/fb' method='post'>
        <input type='text'id='urlInput'name='url'placeholder='URL'>
        <input type='text'id='tagInput'name='tag'placeholder='Tag'>
        <input type='submit'>
    </form>"

  x = fb.get("bookmark").body

  x.each do |key, value|
    h = h + "<div>" + value["url"] + " #" + value["tag"] + "</div>"
  end

  h = h + "</body></html>"

  return h
end

post '/fb' do
  fb.push("bookmark", { :url => params[:url], :tag => params[:tag]})
  redirect '/fb'
end
