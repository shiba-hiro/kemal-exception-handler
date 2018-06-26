# kemal-exception-handler

kemal-exception-handler is a sample implementation of the original exception handler for [Kemal](https://github.com/kemalcr/kemal) web app.


## Map particular exceptions with particular processes

[exception_handler.cr](https://github.com/shiba-hiro/kemal-exception-handler/blob/master/src/kemal-exception-handler/exception_handler.cr) enables you to make exception handlers like below;

```ruby
exception SampleException do |env, ex|
  LOGGER.info "SampleException is mapped."
  LOGGER.error ex.inspect_with_backtrace
  env.response.content_type = "application/json"
  halt env, status_code: 500, response: Hash{"message" => "Internal Server Error", "cause" => "SampleException"}.to_json
end
```


## What you'll need

1. Install Crystal  
https://crystal-lang.org/docs/installation/


## Quick start

```
$ git clone https://github.com/shiba-hiro/kemal-exception-handler
$ cd kemal-exception-handler
$ shards install
$ crystal run src/kemal-exception-handler.cr
```


## Usage

This example use [httpie](https://httpie.org/), of course curl is also OK.

```
$ http GET http://localhost:3000/v1/sample
HTTP/1.1 500 Internal Server Error
Connection: keep-alive
Content-Length: 61
Content-Type: application/json
X-Powered-By: Kemal

{
    "cause": "SampleException", 
    "message": "Internal Server Error"
}
```

At the same time, you can see logs in the terminal executing `kemal-exception-handler`

```
$ crystal run src/kemal-exception-handler.cr
[development] Kemal is ready to lead at http://0.0.0.0:3000
I, [2018-06-26 22:10:06 +09:00 #12558]  INFO -- : GET /v1/sample is called.
I, [2018-06-26 22:10:06 +09:00 #12558]  INFO -- : SampleException instance is created.
I, [2018-06-26 22:10:06 +09:00 #12558]  INFO -- : SampleException is mapped.
E, [2018-06-26 22:10:06 +09:00 #12558] ERROR -- : Operation rejected!! (SampleException)
  from src/kemal-exception-handler/resource/sample_resource.cr:3:3 in '->'
  from lib/kemal/src/kemal/route.cr:255:3 in '->'
  from lib/kemal/src/kemal/route_handler.cr:255:3 in 'process_request'
  from lib/kemal/src/kemal/route_handler.cr:15:7 in 'call'
  from /usr/share/crystal/src/http/server/handler.cr:24:7 in 'call_next'
  from lib/kemal/src/kemal/websocket_handler.cr:13:14 in 'call'
  from /usr/share/crystal/src/http/server/handler.cr:24:7 in 'call_next'
  from src/kemal-exception-handler/exception_handler.cr:10:7 in 'call'
  from /usr/share/crystal/src/http/server/handler.cr:24:7 in 'call_next'
  from lib/kemal/src/kemal/static_file_handler.cr:56:9 in 'call'
  from /usr/share/crystal/src/http/server/handler.cr:24:7 in 'call_next'
  from lib/kemal/src/kemal/exception_handler.cr:8:7 in 'call'
  from /usr/share/crystal/src/http/server/handler.cr:24:7 in 'call_next'
  from lib/kemal/src/kemal/log_handler.cr:10:35 in 'call'
  from /usr/share/crystal/src/http/server/handler.cr:24:7 in 'call_next'
  from lib/kemal/src/kemal/init_handler.cr:12:7 in 'call'
  from /usr/share/crystal/src/http/server/request_processor.cr:39:11 in 'process'
  from /usr/share/crystal/src/http/server/request_processor.cr:16:3 in 'process'
  from /usr/share/crystal/src/http/server.cr:271:5 in 'handle_client'
  from /usr/share/crystal/src/http/server.cr:234:11 in '->'
  from /usr/share/crystal/src/fiber.cr:255:3 in 'run'
  from /usr/share/crystal/src/fiber.cr:29:34 in '->'
  from ???

2018-06-26 22:10:06 +09:00 500 GET /v1/sample 132.09ms
```
