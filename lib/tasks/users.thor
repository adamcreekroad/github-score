# frozen_string_literal: true

class Users < Thor
  desc 'github_score username1 username2 username3', 'Prints out github scores for users provided in descending order'
  def github_score(*usernames)
    if usernames.empty?
      puts 'At least one username must be provided.'
      return
    end

    users = usernames.map { |username| ::User.new(username:) }.select(&:github_score)

    users.sort_by(&:github_score).reverse_each.with_index do |user, index|
      puts "#{index + 1}. #{user.username}: #{user.github_score}"
    end
  end
end
