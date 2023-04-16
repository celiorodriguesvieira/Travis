#!/bin/bash

cd ./cypress/cucumber-json/


TEST=`cat Google.cucumber.json | jq -r '.[].elements[].id'| wc -l `

limit=`cat Google.cucumber.json | jq '. | length'`

FAILURES=0
SKIP=0
PENDING=0

for i in $(seq 0 $limit); do
for j in $(seq 0 $limit); do
   if [ $i -ge 0 ] 
   then
        if [ `cat Google.cucumber.json | jq ".[$i].elements[$j]"| uniq -c | grep "status"| grep -v -e "skipped" | grep -v -e "pending"| grep -c "failed"` -gt 0 ]
        then   
            FAILURES=$((FAILURES+1));
        elif [ `cat Google.cucumber.json | jq ".[$i].elements[$j]"| uniq -c | grep "status"| grep -v -e "failed" |  grep -v -e "pending"| grep -c "skipped"` -gt 0 ]
        then   
            SKIP=$((SKIP+1));
        elif [ `cat Google.cucumber.json | jq ".[$i].elements[$j]"| uniq -c | grep "status"| grep -v -e "failed" |  grep -v -e "skipped" | grep -c "pending"` -gt 0 ]
        then   
            PENDING=$((PENDING+1));
    fi
    fi
done
done

TOTAL_SKIPPED=$((SKIP+PENDING)) 
PASSES=$((TEST - (FAILURES+SKIP+PENDING)))


echo "TEST_RESULTS: Tests: $TEST | ✔: $(( 100 * PASSES / TEST  ))"%" | ✖: $(( 100 * FAILURES / TEST ))"%" | Skipped: $(( 100 * TOTAL_SKIPPED / TEST ))"%""


export RESULT=$(( 100 * PASSES / TEST  ))
echo $RESULT
