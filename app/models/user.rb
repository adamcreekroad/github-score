# frozen_string_literal: true

class User
  attr_accessor :username

  # @param attributes [Hash]
  # @option attributes [String] username
  def initialize(attributes = {})
    self.username = attributes[:username]
  end

  # @param force [Boolean] a truthy value will allow recalculation if score is cached
  #
  # @return [nil, Integer] nil will be returned if a user doesn't exist on Github
  def github_score(force: false)
    @github_score = nil if force

    @github_score ||= CalculateUserGithubScore.call(user: self)
  end
end
