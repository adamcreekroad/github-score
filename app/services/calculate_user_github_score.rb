# frozen_string_literal: true

class CalculateUserGithubScore < Service
  EVENT_RANKS = {
    'IssueEvent' => 1,
    'IssueCommentEvent' => 2,
    'PushEvent' => 3,
    'PullRequestReviewCommentEvent' => 4,
    'WatchEvent' => 5,
    'CreateEvent' => 6
  }.freeze

  # @note events not defined in our ranking system will be ignored
  #
  # @return [Integer]
  def call
    github_client.user_events(user.username).sum { |event| EVENT_RANKS.fetch(event['type'], 0) }
  rescue Github::Client::NotFoundError
    nil
  end

  private

  # @return [Github::Client]
  def github_client
    @github_client ||= Github::Client.new
  end
end
