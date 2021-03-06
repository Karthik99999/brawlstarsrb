require "httparty"
require "brawlstars/validation"

module Brawlstars
  class Error
    class Unauthorized < StandardError
      def message
        'The API token given was invalid or blocked.'
      end
    end
    class TagError < StandardError
      def message
        'The tag given was invalid.'
      end
    end
    class RegionError < StandardError
      def message
        'The region must be a valid 2 character country code.'
      end
    end
    class NotFoundError < StandardError
      def message
        'The tag given was not found.'
      end
    end
    class RateLimitError < StandardError
      def message
        'The rate limit has been hit.'
      end
    end
    class MaintainanceError < StandardError
      def message
        'There is a maintainance break. Try again later.'
      end
    end
    class ServerError < StandardError
      def message
        'The API is down. Try again later.'
      end
    end
  end
  class Client
    def initialize(token: false)
      raise "No authorization token was given!" if !token
      @token = token
    end
    
    # Get info about the API
    #
    # @return [Hash] info about the API

    def about
      get("/about")
    end
    
    # Get a player by their tag
    #
    # @param tag [String] tag of the player to get.
    # @return [Brawlstars::Player] data of the player that was searched.

    def getPlayer(tag)
      tag = validateTag(tag)
      Player.new(self, get("/player?tag=#{tag}"))
    end
    
    # Search for players by their name
    #
    # @param name [String] name to search for.
    # @return [Hash] players returned by the search.
    
    def playerSearch(name)
      get("/player/search?name=#{name.gsub(' ', '%20')}")
    end
    
    # Get a player's battle log by their tag
    #
    # @param tag [String] tag of the player to get.
    # @return [Hash] data of the player's battle log that was searched.
    
    def getBattleLog(tag)
      tag = validateTag(tag)
      get("/player/battlelog?tag=#{tag}")
    end
    
    # Get a club by its tag
    #
    # @param tag [String] tag of the club to get.
    # @return [Hash] data of the club that was searched.
    
    def getClub(tag)
      tag = validateTag(tag)
      get("/club?tag=#{tag}")
    end
    
    # Search for clubs by their name
    #
    # @param name [String] name to search for.
    # @return [Hash] clubs returned by the search.
    
    def clubSearch(name)
      get("/club/search?name=#{name.gsub(' ', '%20')}")
    end
    
    # Get upcoming events
    #
    # @return [Hash] upcoming events
    
    def getUpcomingEvents
      get("/events?type=upcoming")
    end
    
    # Get current events
    #
    # @return [Hash] current events
    
    def getCurrentEvents
      get("/events?type=current")
    end
    
    # Get miscellaneous data, like shop/season reset
    #
    # @return [Hash] miscellaneous data
    
    def getMisc
      get("/misc")
    end
    
    # Get top global clubs
    #
    # @param count [Integer] number of clubs to return.
    # @param region [String] 2 character country code for the region of leaderboard to return.
    # @return [Hash] clubs in order from 1st rank down.
    
    def getTopClubs(count=200, region="global")
      raise 'Count must be a number.' if !count.is_a? Integer
      raise 'Count must be between 1 and 200.' if !count.between?(1,200)
      validateRegion(region)
      get("/leaderboards/clubs?count=#{count}&region=#{region}")
    end
    
    # Get top global players
    #
    # @param count [Integer] number of players to return.
    # @param brawler [String] brawler leaderboard to return.
    # @param region [String] 2 character country code for the region of leaderboard to return.
    # @return [Hash] players in order from 1st rank down.
    
    def getTopPlayers(count=200, brawler="", region="global")
      raise 'Count must be a number.' if !count.is_a? Integer
      raise 'Count must be between 1 and 200.' if !count.between?(1,200)
      validateRegion(region)
      get("/leaderboards/players?count=#{count}&brawler=#{brawler}&region=#{region}")
    end
    
    protected
    
    # The method to send GET requests to the API
    #
    # @param ep [String] the endpoint to get.
    # @return [Hash] the response returned by the endpoint.
      
    def get(ep)
      url = "https://api.starlist.pro/v1#{ep}"
      begin
        res = HTTParty.get(url, {headers: {"Authorization" => @token}})
      rescue HTTParty::Error => e
        puts e
      end
      case res.code
        when 200
          res.parsed_response
        when 401
          raise Error::Unauthorized
        when 404
          raise Error::NotFoundError
        when 429
          raise Error::RateLimitError
        when 503
          raise Error::MaintainanceError
        when 500...600
          raise Error::ServerError
      end
    end
  end
  class Player
    def initialize(client, data)
      @client = client
      @data = data
    end
    
    def method_missing(name, *args, &block)
      if @data.respond_to?(name)
        @data.send(name, *args, &block)
      else
        super
      end
    end
    
    def getClub
      if !@data["club"]
        nil
      else
        @client.getClub(@data["club"]["tag"])
      end
    end
    
    def getBattleLog
      @client.getBattleLog(@data["tag"])
    end
    
    def to_s
      "#{@data}"
    end
  end
end
