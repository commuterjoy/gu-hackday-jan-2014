
require 'rest_client'
require 'fileutils'
require 'base64'

class Press
    
    attr_accessors = :tokens, :host, :cache_root, :cache_path, :path

    def initialize(path)
        @host = 'http://pads6.pa-sport.com/'
        @cache_root = '/tmp/'
        @path = path
        { 
                :matchID => 3695871,
                :apiKey => 'dxj451p9',
                :startDate => 20130701,
                :endDate => 20140120,
                :competitionID => 300
        }.each { |key, value|
            @path.gsub!(/{#{key}}/, value.to_s)
        }
    end

    def key
        @cache_root + Base64.encode64(@path).strip
    end

    def get
        RestClient.get(@host + @path) { |response, request, result|
            if (response.code == 200)
                File.open(self.key, 'w') { |f| f.write(response.body) }
            end
        }
        self
    end

    def transform(xsl, opts={:params=>{}})
        out = "#{self.key}.out"
        params = opts[:params].map { |key, value|
            [key, value]
        }.join('=')
        puts "java -jar lib/saxon9he.jar -o #{out} #{params} #{self.key} #{xsl}"
        `java -jar lib/saxon9he.jar -o "#{out}" "#{self.key}" #{xsl} #{params}`
        File.open(out, 'r') { |f| f.read }
    end
    
end

#puts Press.new('/api/football/competition/fixtures/dxj451p9/100').get().transform('events.xsl', { :params => { :foo => 1} })

