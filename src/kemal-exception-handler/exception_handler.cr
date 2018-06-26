class ExceptionHandler < Kemal::Handler
  @@exception_process_map = {} of Exception.class => HTTP::Server::Context, Exception -> String

  def self.put_process(mapped_exception : Exception.class, &block : HTTP::Server::Context, Exception -> _)
    @@exception_process_map[mapped_exception] = ->(context : HTTP::Server::Context, ex : Exception) { block.call(context, ex).to_s }
  end

  def call(context)
    begin
      call_next context
    rescue ex : Exception
      if @@exception_process_map.has_key?(ex.class)
        context.response.print @@exception_process_map[ex.class].call(context, ex)
        return context
      end
      # if it's not mapped, raise to Kemal::ExceptionHandler
      raise ex
    end
  end
end

def exception(mapped_exception : Exception.class, &block : HTTP::Server::Context, Exception -> _)
  ExceptionHandler.put_process mapped_exception, &block
end

add_handler ExceptionHandler.new

require "./exception_handler/*"
