require 'test_helper'

describe MixReader do
  describe "People" do
    def query(args)
      MixReader::People.query(args)
    rescue => error
      return error.to_s
    end

    describe "#api_secret" do
      before do
        set_api_secret
      end
      after do
        reset_api_secret
      end
      it "gets from config" do
        people = MixReader::People.new("")
        assert(people.send(:api_secret) == "abcd")
      end
    end

    describe "#query" do
      describe "when invalid args" do
        it "raises exception" do
          error = query("")
          assert(error == "invalid arguments")
        end
      end

      describe "when valid params" do
        before do
          set_api_secret("api_secret_key")
          VCR.insert_cassette "people"
        end
        after do
          reset_api_secret
          VCR.eject_cassette
        end

        it "fetches one person" do
          people = query(email: "murtyk@example.com")
          assert(people[0]["$city"] == "Jackson")
        end

      end
    end
  end
end
