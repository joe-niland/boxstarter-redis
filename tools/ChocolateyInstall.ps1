try {

   choco install redis-64 -y

   if (!(Test-Path d:\redis-conf)) { mkdir d:\redis-conf }
   
   if (!(Test-Path d:\redis-db)) { mkdir d:\redis-db }
   
   # Copy default config to custom config location
   copy C:\ProgramData\chocolatey\lib\redis-64\redis.windows-service.conf d:\redis-conf\

   # Configure log file
   # Doesn't work in PowerShell 2
   (Get-Content d:\redis-conf\redis.windows-service.conf).replace('logfile "Logs/redis_log.txt"', '# logfile "Logs/redis_log.txt"') | Set-Content d:\redis-conf\redis.windows-service.conf

   # Bind locally only
   (Get-Content d:\redis-conf\redis.windows-service.conf).replace('# bind 127.0.0.1', 'bind 127.0.0.1') | Set-Content d:\redis-conf\redis.windows-service.conf

   redis-server --service-install d:\redis-conf\redis.windows-service.conf --loglevel verbose
   redis-server --service-start

} catch {
  throw $_.Exception
}