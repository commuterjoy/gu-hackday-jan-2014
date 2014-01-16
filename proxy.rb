
require 'rest_client'
require 'sinatra'
require 'fileutils'
require 'base64'
require 'hmac-sha1'

teams = { 
    :man_city => 11,
    :blackburn => 22
    }

tokens = { 
        :matchID => 3695871,
        :apiKey => 'dxj451p9',
        :startDate => 20140115,
        :endDate => 20140115,
        :competitionID => 300
    }

match = [
            'api/football/competition/matchDay/{apiKey}/{competitionID}/{startDate}',
            'api/football/match/actions/{apiKey}/{matchID}',
            'api/football/match/commentary/{apiKey}/{matchID}',
            'api/football/match/eaIndex/{apiKey}/{matchID}',
            'api/football/match/enhancedCommentary/{apiKey}/{matchID}',
            'api/football/match/events/{apiKey}/{matchID}',
            'api/football/match/fastevents/{apiKey}/{matchID}',
            'api/football/match/images/{apiKey}/{matchID}',
            'api/football/match/info/{apiKey}/{matchID}',
            'api/football/match/lineUps/{apiKey}/{matchID}',
            'api/football/match/mobileCommentary/{apiKey}/{matchID}',
            'api/football/match/postMatchStats/{apiKey}/{matchID}',
            'api/football/match/PreMatchPreview/{apiKey}/{matchID}',
            'api/football/match/preview/{apiKey}/{matchID}',
            'api/football/match/referee/{apiKey}/{matchID}/{startDate}/{endDate}',
            'api/football/match/report/{apiKey}/{matchID}',
            'api/football/match/stats/{apiKey}/{matchID}',
            'api/football/match/venue/{apiKey}/{matchID}'
        ]

# ---------------

def key(url)
    Base64.encode64(url).strip
end

def stash(file, url)
    host = 'http://pads6.pa-sport.com/'
    RestClient.get(host + url) { |response, request, result|
        puts "******** #{host + url} - #{response.code}, written to #{file}" 
        if (response.code == 200)
            File.open(file, 'w') { |f| f.write(response.body) }
            puts "********* written to ok" 
        end
        return response
    }
end

# Theo Walcott misses per season
# 15th yellow card for dissent that Everton have had

def transform(xmlFile, xsl)
    out = "#{xmlFile}.out"

    puts "*********** java -jar lib/saxon9he.jar -o #{out} #{xmlFile} #{xsl}"

    `java -jar lib/saxon9he.jar -o "#{out}" "#{xmlFile}" #{xsl}`
    File.open(out, 'r') { |f| f.read }
end

get '/favicon.ico' do
end

get '/*' do
    
    path = params[:splat].first
    tokens.each { |key, value|
        path.gsub!(/{#{key}}/, value.to_s)
    }

    puts "*********** #{params[:xsl]}"
    
    xmlFile = "/tmp/#{key(path)}"
    xml = stash(xmlFile, path)
    html = transform(xmlFile, params[:xsl])
    html 
    
end

