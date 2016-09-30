# Prometheus plugs performance test app
===========================

1) Prometheus_plugs disabled (commented)
```
~/wrk/wrk -d30s -c256 -t16 http://localhost:8088/profiles/1/
Running 30s test @ http://localhost:8088/profiles/1/
  16 threads and 256 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.62ms    1.29ms  29.34ms   89.28%
    Req/Sec     3.50k   509.45     8.03k    84.80%
  1676601 requests in 30.10s, 427.22MB read
Requests/sec:  55703.20
Transfer/sec:     14.19MB
```
2) Prometheus_plugs enabled:
```
~/wrk/wrk -d30s -c256 -t16 http://localhost:8088/profiles/1/
Running 30s test @ http://localhost:8088/profiles/1/
  16 threads and 256 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     8.82ms    2.70ms  38.39ms   81.31%
    Req/Sec     1.83k   361.99     2.60k    74.65%
  875530 requests in 30.01s, 223.09MB read
Requests/sec:  29176.49
Transfer/sec:      7.43MB
```

**Please also see screenshots (cpu load).**
