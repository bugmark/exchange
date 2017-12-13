#!/bin/bash
curl -X GET --header 'Accept: application/json' 'https://bugmark.net/api/v1/events' > all_events.json
