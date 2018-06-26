module Config
  PORT = ENV["PORT"] ||= "3000"
end

require "logger"
LOGGER = Logger.new(STDOUT)
