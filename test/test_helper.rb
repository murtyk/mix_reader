$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mix_reader'

require 'minitest/autorun'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

def set_api_secret(key = "abcd")
  MixReader.configure do |config|
    config.api_secret = key
  end
end

def reset_api_secret
  MixReader.configure do |config|
    config.api_secret = nil
  end
end
