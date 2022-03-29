# frozen_string_literal: true

module Github
  class Client
    class NotFoundError < StandardError; end
    class InternalServerError < StandardError; end

    API_ORIGIN = 'https://api.github.com/'

    # @param username [String]
    #
    # @return [Array<Hash>]
    def user_events(username)
      perform_get("/users/#{username}/events")
    end

    private

    # @return [Faraday::Connection]
    def client
      @client ||= Faraday.new(
        url: API_ORIGIN,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    # @param path [String]
    #
    # @return [Hash, Array<Hash>]
    def perform_get(path)
      send_request(:get, path)
    end

    # @param path [String]
    # @param params [Hash]
    #
    # @return [Hash, Array<Hash>]
    def perform_post(path, params)
      send_request(:post, path, params)
    end

    # @param path [String]
    # @param params [Hash]
    #
    # @return [Hash, Array<Hash>]
    def perform_put(path, params)
      send_request(:put, path, params)
    end

    # @param path [String]
    #
    # @return [Hash, Array<Hash>]
    def perform_delete(path)
      send_request(:delete, path)
    end

    # @param path [String]
    # @param params [Hash]
    #
    # @return [Hash, Array<Hash>]
    def send_request(method, path, params = {})
      response = client.send(method, path, params)

      handle_errors(response)

      MultiJson.load(response.body)
    end

    # @param response [Faraday::Response]
    #
    # @raise [NotFoundError]
    # @raise [InternalServerError]
    def handle_errors(response)
      case response.status
      when 500.. then raise(InternalServerError)
      when 404 then raise(NotFoundError)
      end
    end
  end
end
