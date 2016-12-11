require 'test_helper'

describe MixReader do
  describe "#configure" do
    describe "#api_secret" do
      it "defaults to nil" do
        assert(MixReader.configuration.api_secret.nil?)
      end
    end

    describe "#api_secret=" do
      before do
        MixReader.configure do |config|
          config.api_secret = "abcd"
        end
      end

      after do
        MixReader.configure do |config|
          config.api_secret = nil
        end
      end

      it "can set value" do
        config = MixReader.configuration
        assert(config.api_secret == "abcd")
      end
    end
  end
end
