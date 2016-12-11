require 'test_helper'
require 'date'

describe MixReader do
  describe "Events" do
    def query(args)
      MixReader::Events.query(args)
    rescue => error
      return error.to_s
    end

    describe "#api_secret" do
      let(:events) { MixReader::Events.new("") }
      before do
        set_api_secret
      end
      after do
        reset_api_secret
      end
      it "gets from config" do
        assert(events.send(:api_secret) == "abcd")
      end
    end

    describe "#query" do
      describe "when invalid args" do
        let(:error) { query("") }

        it "raises exception" do
          assert(error == "invalid arguments")
        end
      end

      describe "when valid params" do
        let(:params) {{ from_date: Date.new(2016,12,11), to_date: Date.new(2016,12,11), event_selectors: [{event: "$campaign_open"}] }}
        let(:events) { query(params) }

        before do
          set_api_secret("api_secret_key")
          VCR.insert_cassette "events"
        end
        after do
          reset_api_secret
          VCR.eject_cassette
        end

        it "fetches one person" do
          assert(events.count == 2)
        end
      end
    end
  end
end
