#!/bin/bash
# Replace with your Cloudant URL that you can get in the credentials tab

url="https://4fde2747-1360-479e-b278-3742634efaee-bluemix:aedb9a613f633229177d7765ecbb95e1467e754317724057f5710963f303e69a@4fde2747-1360-479e-b278-3742634efaee-bluemix.cloudant.com"
for i in {1..22}; do
	curl -X POST -d @data${i}.json "$url/greatoutdoors/_bulk_docs" -H "Content-Type:application/json";
done;