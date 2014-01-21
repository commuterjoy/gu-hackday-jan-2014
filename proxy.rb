
require 'rest_client'
require 'sinatra'
require 'fileutils'
require 'base64'
require './lib/pa/client.rb'

# read the api-key from a local configuration file
apiKey = IO.read('api-key').strip

get '/' do
    erb :index
end

get '/favicon.ico' do
end

get '/players/:id' do
    id = params[:id]
    Press.new([
        '/api/football/player/appearances/{apiKey}/{playerID}/{startDate}/{endDate}',
        '/api/football/player/events/{apiKey}/{playerID}/{startDate}/{endDate}'
    ], { 
        :playerID => id,
        :apiKey => apiKey
    }).get().cache().transform('base.xsl', { :params => { :player => id } })
end

get '/competitions/:id/stats' do
    Press.new([
        '/api/football/competition/stats/summary/{apiKey}/'+params[:id]+'/20130701/20140131',
        '/api/football/competition/eaindexfull/{apiKey}/'+params[:id]+'/{startDate}/{endDate}'
    ], {
        :apiKey => apiKey
    }).get().cache().transform('competitions.stats.xsl') 
end

get '/competitions/:id/results' do
    Press.new([
        '/api/football/competition/results/{apiKey}/' + params[:id]
    ], {
        :apiKey => apiKey
    }).get().cache().transform('results.xsl') 
end

get '/competitions' do
    Press.new([
        '/api/football/competitions/{apiKey}'
    ], {
        :apiKey => apiKey
    }).get().cache().transform('competitions.xsl') 
end

get '/matches/:id' do
    Press.new([
        '/api/football/match/actions/{apiKey}/{params[:id]}'
    ], {
        :apiKey => apiKey
    }).get().cache().transform('actions.xsl') 
end

get '/*' do
    Press.new([
        '/' + params[:splat].first
    ], {
        :apiKey => apiKey
    }).get().cache().transform(params[:xsl]) 
end
