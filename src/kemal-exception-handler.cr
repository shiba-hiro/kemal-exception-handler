require "kemal"

require "./kemal-exception-handler/*"

Kemal.config.port = Config::PORT.to_i
Kemal.run
