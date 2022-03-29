# frozen_string_literal: true

RSpec.describe Github::Client do
  subject(:client) { described_class.new }

  describe '#user_events' do
    subject(:user_events) { client.user_events(username) }

    let(:username) { 'shogie123' }
    let(:events) do
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
      stub_request(:get, %r{/users/\w+/events}).to_return(body: MultiJson.dump(events), status: 200)
    end

    it { is_expected.to eq(events) }

    context 'when user can not be found' do
      before do
        stub_request(:get, %r{/users/\w+/events}).to_return(status: 404)
      end

      it 'raises a NotFoundError' do
        expect { user_events }.to raise_error(described_class::NotFoundError)
      end
    end

    context 'when Github returns an internal error' do
      before do
        stub_request(:get, %r{/users/\w+/events}).to_return(status: 500)
      end

      it 'raises an InternalServerError' do
        expect { user_events }.to raise_error(described_class::InternalServerError)
      end
    end
  end
end
