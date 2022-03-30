# frozen_string_literal: true

RSpec.describe CalculateUserGithubScore do
  subject(:service) { described_class.call(user:) }

  let(:username) { 'shogie1234' }
  let(:user) { User.new(username:) }

  let(:github_client) { instance_double('Github::Client') }
  let(:user_events) do
    [
      {
        'id' => '12347',
        'type' => 'IssueCommentEvent'
      },
      {
        'id' => '12346',
        'type' => 'PushEvent'
      },
      {
        'id' => '12345',
        'type' => 'WatchEvent'
      }
    ]
  end

  before do
    allow(Github::Client).to receive(:new).and_return(github_client)
    allow(github_client).to receive(:user_events).with(username).and_return(user_events)
  end

  it { is_expected.to eq(10) }

  context 'when the user does not exist on github' do
    let(:username) { 'bogus1234' }

    before do
      allow(github_client).to receive(:user_events).with(username).and_raise(Github::Client::NotFoundError)
    end

    it { is_expected.to be_nil }
  end
end
