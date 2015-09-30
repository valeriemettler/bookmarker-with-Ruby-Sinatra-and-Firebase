require 'sinatra'
require 'firebase'

fb = Firebase::Client.new('https://girldevchat.firebaseio.com/')

get '/' do
    return "123 Hello World!"
end


get '/fb' do
    h = "<html><body><h1>Bookmarks and Tags:</h1>"
    h = h +  "<form action='/form' method='post'>
        <input type='text'id='urlInput'name='url'placeholder='URL'>
        <input type='text'id='tagInput'name='tag'placeholder='Tag'>
        <input type='submit'>
    </form>"
    # x = fb.get("bookmark").body
    x = fb.get("bookmark").body


    x.each do |key, value|
        h = h + "<div>" + value["url"] + " #" + value["tag"] + "</div>"
    end
    # h = "<html><body><h1>output starts here...</h1>"
    # h = h + x.to_json
    h = h + "</body></html>"
    return h
end

post '/form' do
    fb.push("bookmark", { :url => params[:url], :tag => params[:tag]})
    redirect '/fb'
end
