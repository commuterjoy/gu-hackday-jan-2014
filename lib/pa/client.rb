
require 'rest_client'
require 'fileutils'
require 'base64'
require 'nokogiri'

class Press
    
    attr_accessors = :tokens, :host, :cache_root, :cache_path, :paths, :xml, :xsl_src

    def initialize(paths, tokens = {})
        @host = 'http://pads6.pa-sport.com'
        @cache_root = './target/'
        @xsl_src = './views/xsl/'
        @tokens = { 
                :matchID => 3695871,
                :startDate => 20130702,
                :endDate => 20140120,
                :competitionID => 300,
                :host => @host,
                :cache_root => @cache_root
        }.merge(tokens)
        @paths = paths.map { |path|
            @tokens.each { |key, value|
                path.gsub!(/{#{key}}/, value.to_s)
            }
            path
        }
    end

    def key
        @cache_root + Base64.encode64(@paths.first).strip
    end

    def cache
        File.open(self.key, 'w') { |f| f.write("<pa>#{@xml.join}</pa>") }
        self
    end

    # get and merge n xml files together
    def get
        @xml = @paths.map { |path|
            puts "GET\t#{@host + path}"
            RestClient.get(@host + path) { |response, request, result|
                puts "RESPONSE #{response.code}"
                response.body
            }
        }.map { |response|
            Nokogiri::XML(response).xpath("/*").to_s
        }
        self
    end

    # xsl transformer
    def transform(xsl, opts={:params=>{}})
        out = "#{self.key}.out"
        params = opts[:params].merge(@tokens).map { |key, value|
            "#{key}=#{value}" % [key, value]
        }.join(' ')
        puts "java -jar vendor/saxon9he.jar -o #{out} #{params} #{self.key} #{@xsl_src + xsl}"
        `java -jar vendor/saxon9he.jar -o:"#{out}" -s:"#{self.key}" -xsl:#{@xsl_src + xsl} #{params}`
        File.open(out, 'r') { |f| f.read }
    end
    
end

# rspec :)
#
# pa = [
#   '/api/football/competition/fixtures/dxj451p9/100',
#    '/api/football/competition/fixtures/dxj451p9/300',
#    '/api/football/competition/fixtures/dxj451p9/101',
#]
#
#puts Press.new(pa).get().inspect
#
#:.transform('events.xsl', { :params => { :foo => 1 }})
