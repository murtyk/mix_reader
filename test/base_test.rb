require 'test_helper'

describe MixReader do
  describe "Base" do
    def new_error
      base = MixReader::Base.new("")
    rescue => error
      return error.to_s
    end
    describe "#new" do
      it "raises exception" do
        assert(new_error == "can not instantiate base class")
      end
    end
  end
end
