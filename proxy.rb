
require 'rest_client'
require 'sinatra'
require 'fileutils'
require 'base64'
require './lib/pa/client.rb'

apiKey = IO.read('api-key').strip

get '/' do
    erb :index
end

get '/favicon.ico' do
end

get '/players/:id' do
    urls = [
        '/api/football/player/appearances/{apiKey}/{playerID}/{startDate}/{endDate}',
        '/api/football/player/events/{apiKey}/{playerID}/{startDate}/{endDate}'
    ]
    id = params[:id]
    Press.new(urls, { 
        :playerID => id,
        :apiKey => apiKey
    }).get().cache().transform('foo.xsl', { :params => { :player => id } })
end

get '/competitions/:id/stats' do
    urls = [
        '/api/football/competition/stats/summary/{apiKey}/'+params[:id]+'/20130701/20140131',
        '/api/football/competition/eaindexfull/{apiKey}/'+params[:id]+'/{startDate}/{endDate}'
    ]
    Press.new(urls, {
        :apiKey => apiKey
    }).get().cache().transform('competitions.stats.xsl') 
end


get '/competitions' do
    urls = [
        '/api/football/competitions/{apiKey}'
    ]
    Press.new(urls, {
        :apiKey => apiKey
    }).get().cache().transform('competitions.xsl') 
end

get '/*' do
    path = '/' + params[:splat].first
    Press.new([path], {
        :apiKey => apiKey
    }).get().cache().transform(params[:xsl]) 
end
