# cowin-notifier

Query [Cowin API](https://apisetu.gov.in/public/api/cowin#/) using curl+jq and notify on Mac OSX status bar if vaccine slots available

# Usage

## Prerequisites

* Works only on Mac OSX
* curl
* [jq](https://stedolan.github.io/jq/download/)
* [terminal-notifier](https://github.com/julienXX/terminal-notifier)
* json_pp

## Run as cron

```
$ crontab -e
* * * * * /path/to/cron.sh >> /tmp/cowin.log 2>&1
```

## Run using watch

```
$ watch -n60 '/path/to/cron.sh >> /tmp/cowin.log'
```

## Options

### Change District id

For changing district id, use `/v2/admin/location/states` API and `/v2/admin/location/districts/{state_id}` API in [Cowin API](https://apisetu.gov.in/public/api/cowin#/) to find district_id and pass it as param to cron.sh
