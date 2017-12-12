#!/bin/bash

tr '\n' ',' < eventstore.decoded.txt | perl -pe 's/,---------------------------------,/\n/g' > eventstore.decoded.csv
