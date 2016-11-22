try {

   Set-Variable -Name DB_DIR -Value d:\redis-db\ -Option Constant
   Set-Variable -Name CONF_DIR -Value d:\redis-conf\ -Option Constant
   Set-Variable -Name CONF_FILE -Value redis.windows-service.conf -Option Constant

   $redisConfig = (Join-Path $CONF_DIR $CONF_FILE)

   choco install redis-64 -y

   if (!(Test-Path $CONF_DIR)) { mkdir $CONF_DIR }
   
   if (!(Test-Path $DB_DIR)) { mkdir $DB_DIR }
   
   # Copy default config to custom config location
   copy C:\ProgramData\chocolatey\lib\redis-64\redis.windows-service.conf $CONF_DIR

   # Configure log file
   # Doesn't work in PowerShell 2
   if ($PSVersionTable.PSVersion.Major -le 2) {
      $content = Get-Content -Path $redisConfig | Out-String
   } else {
      $content = Get-Content $redisConfig
   }

   $content = $content.replace('logfile "Logs/redis_log.txt"', '# logfile "Logs/redis_log.txt"')
   $content.replace('# bind 127.0.0.1', 'bind 127.0.0.1') | Set-Content $redisConfig

   redis-server --service-install $redisConfig --loglevel verbose
   redis-server --service-start

} catch {
  throw $_.Exception
}