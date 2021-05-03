# Run using watch
# watch -n30 '/path/to/cron.sh >> /tmp/cowin.log'

# Add to crontab
# crontab -e
# * * * * * /path/to/cron.sh >> /tmp/cowin.log 2>&1

export PATH=/usr/local/bin:$PATH

date=${1:-`date +"%d-%m-%Y"`}
district_id=${2:-294}
# age_limit=${3:-18}

echo "[$(date +"%r")] Searching on $date in district $district_id for ages 18+"

curl -X GET "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=$district_id&date=$date" -H "accept: application/json" -H "Accept-Language: hi_IN" | json_pp > /tmp/out.json
jq -r '.centers[] | select(any(.sessions[]; .min_age_limit == 18 and .available_capacity > 0)) | [.name, .sessions[].session_id, .sessions[].available_capacity, .sessions[].min_age_limit, .sessions[].date] | @csv' /tmp/out.json > /tmp/found.csv
if [ -s /tmp/found.csv ]
then
        echo "Slots found"
        cat /tmp/found.csv | terminal-notifier -sound default
else
        echo "No slots found"
fi
