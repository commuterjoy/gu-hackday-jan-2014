
require 'rest_client'
require 'sinatra'
require 'fileutils'
require 'base64'
require './pa_client.rb'


get '/favicon.ico' do
end

get '/player/:id' do

    player = [
        {
            :name => 'appearances',
            :uri => '/api/football/player/appearances/{apiKey}/{playerID}/{startDate}/{endDate}'
        },
        {
            :name => 'events',
            :uri => '/api/football/player/events/{apiKey}/{playerID}/{startDate}/{endDate}'
        },
        {
            :name => 'stats',
            :uri => '/api/football/player/stats/summary/{apiKey}/{playerID}/{startDate}/{endDate}'
        }
    ]
    
    id = params[:id]
    player.map { |k|
        tokens.merge({:playerID => id}).each { |key, value|
            k[:uri].gsub!(/{#{key}}/, value.to_s)
        }
    }
    
    player.each { |k|
        xmlFile = "/tmp/#{key(k[:uri])}"
        stash(xmlFile, k[:uri])
        k[:xmlFile] = xmlFile
    }

    merged = ''
    player.each { |k| 
        merged += transform(k[:xmlFile], k[:name] + '.xsl', { :params => { :playerId => id } })
    }

    merged

end

get '/*' do
    path = params[:splat].first
    Press.new(path).get().transform(params[:xsl])
    
end

