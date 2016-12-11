require "mix_reader/version"
require "mix_reader/configuration"
require "mix_reader/base"
require "mix_reader/people"
require "mix_reader/events"

module MixReader
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
