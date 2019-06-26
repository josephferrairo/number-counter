# Number-Counter

## To Run
- `docker-compose up --build`

### To Test
- `cd number-counter`
- `curl -i -X POST -H "Content-Type: application/json" -d '{"number": 8}' http://localhost:4567/`
  - Change the number value to whatever you want to test

### Example Output
```
HTTP/1.1 200 OK
Content-Type: text/html;charset=utf-8
Content-Length: 7
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Server: WEBrick/1.4.2 (Ruby/2.5.5/2019-03-15)
Date: Wed, 26 Jun 2019 13:01:50 GMT
Connection: Keep-Alive

{"8":1}%
```

### To Run Tests
- You do need to be running a redis-server locally and not in docker
- `bundle exec rspec`
