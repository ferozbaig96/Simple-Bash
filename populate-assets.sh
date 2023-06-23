#!/bin/bash

# This script will create a JSON payload with dynamic values to be uploaded to a DynamoDB database via an API Gateway
# JSON payload will look like
# {
#       "assetTitle": "sample-asset-1",
#       "assetDescription": "sample asset 1 description",
#       "channels": [ "channel2","channel6" ],
#       "createdBy": "Thompson",
#       "assetType": "3D assets",
#       "usageRights": "On request",
#       "licenseDateValidity": "",
#       "assetCategories": [ "Sustainability","DBS Foundation" ],
#       "dueDate": "08/10/2023",
#       "datePublished": "18/11/2023",
#       "platforms": [ "In-app","Metaverse","Press/Media" ],
#       "campaigns": [ "campaign3","campaign4","campaign5" ],
#       "priority": "Low",
#       "markets": [ "All","Singapore","Taiwan","Thailand","UAE","Vietnam","Others","Australia","Hong Kong","India","Indonesia","Korea","Malaysia" ],
#       "tags": [ "tag1","tag2","tag3","tag6","tag7","tag8","tag10" ],
#       "advancedRights": [ "Archive" ],
#       "assetLocation": {"bucket": "dbs-cmm","key": "0c09853b-be48-4a4d-8eba-872dc212e900_abc.png"},
#       "previewLocation": {"bucket": "dbs-cmm","key": "visual-asset-management-system.png"},
#       "originalFilename": "sample_file.png"
#     }


debug=false
count=1

function get_any_one_item() {
  USAGE="get_any_one <list>"

  # Example:
  # list=("a" "b" "c" "d" "e" "f")
  # item=`get_any_one_item "${list[@]}"`    # https://superuser.com/questions/400109/how-to-preserve-white-space-in-bash-arguments
  # echo $item

  list=("$@") # https://askubuntu.com/q/674333
  list_size=${#list[@]}
  selected_number=$((RANDOM % list_size)) # list range: 0 to size-1
  chosen_item=${list[selected_number]}
  echo ${chosen_item}
}

function get_arbitrary_items() {
  USAGE="get_arbitrary_items <list>"

  # Example:
  # list=("a" "b" "c" "d" "e" "f")
  # items=`get_arbitrary_items "${list[@]}"`
  # echo $items

  selected_items=""
  list=("$@")
  list_size=${#list[@]}
  num_items=$(shuf -i 1-${list_size} -n 1)
  selected_numbers=$(shuf -i 0-$((list_size - 1)) -n ${num_items} | sort) # list range: 0 to size-1

  for num in ${selected_numbers}; do
    selected_items+="\"${list[$num]}\","
  done
  selected_items="[ $(echo "$selected_items" | rev | cut -c2- | rev) ]"
  echo "${selected_items}"
}

function generate_prefixed_list() {
  USAGE="generate_prefixed_list <size> <prefix>"

  # Example:
  # items=`generate_prefixed_list 5 channels`
  # echo $items

  size=$1
  prefix=$2

  if [[ ! $# -eq 2 ]]; then
    echo "$USAGE"
    exit 1
  fi

  values=""
  for i in $(seq 1 $size); do
    values+="$prefix$i,"
  done
  IFS=',' read -r -a list <<<"$values"
  echo "${list[@]}"
}

function future_date() {
  # Get the current time.
  now=$(date +%s)
  # Generate a random number between 0 and 365 and add those many day's seconds to current time
  random_future_epoch=$((now + 24 * 60 * 60 * (RANDOM % 365)))
  # Convert the epoch to a date.
  # random_future_date=$(date +%d/%m/%Y -d @$random_future_epoch) # for linux
  random_future_date=$(gdate +%d/%m/%Y -d @$random_future_epoch) # for mac
  echo "$random_future_date"
}

function populate_to_db() {
  USAGE="populate_db <json_payload>"
  if [[ ! $# -eq 1 ]]; then
    echo "$USAGE"
    exit 1
  fi

  json_payload=$1
  apigwurl='https://ue0v2tz1p2.execute-api.ap-southeast-1.amazonaws.com/v1/assets'

  curl -s -X 'POST' \
    "${apigwurl}" \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d "${json_payload}"
}

for i in $(seq 1 ${count}); do
  assetTitle="sample-asset-${i}"
  assetDescription="sample asset ${i} description"
  [[ ${debug} = true ]] && echo assetTitle "${assetTitle}"
  [[ ${debug} = true ]] && echo assetDescription "${assetDescription}"

  # generate channels - generate list with items of arbitrary size
  channels_list=$(generate_prefixed_list 5 channel)
  channels=$(get_arbitrary_items ${channels_list[@]}) # No double quotes enclosing here!
  [[ ${debug} = true ]] && echo channels "${channels}"

  # select createdBy - choose 1 from known list
  authors=("Mike" "Wayne" "Thompson" "David" "Ben")
  createdBy=$(get_any_one_item "${authors[@]}")
  [[ ${debug} = true ]] && echo createdBy "${createdBy}"

  # select assetType - choose 1 from known list
  asset_types=("Audio" "Document" "Graphic/Visual" "Photography" "Video" "3D assets")
  assetType=$(get_any_one_item "${asset_types[@]}")
  [[ ${debug} = true ]] && echo assetType "${assetType}"

  # select usageRights - choose 1 from known list
  usage_rights_list=("Available" "Confidential" "On request" "Licensed")
  usageRights=$(get_any_one_item "${usage_rights_list[@]}")
  [[ ${debug} = true ]] && echo usageRights "${usageRights}"

  # select licenseDateValidity - random future date in DD/MM/YYYY format
  licenseDateValidity=""
  if [[ $usageRights = "Licensed" ]]; then
    licenseDateValidity=$(future_date)
    [[ ${debug} = true ]] && echo licenseDateValidity "${licenseDateValidity}"
  fi

  # select assetCategories - choose arbitrary from known list
  asset_categories_list=("Brand Awareness" "Customer Loyalty" "New Customers" "Product Launch" "Sustainability" "DBS Foundation" "DBS Sparks")
  assetCategories=$(get_arbitrary_items "${asset_categories_list[@]}")
  [[ ${debug} = true ]] && echo assetCategories "${assetCategories}"

  # select dueDate - random future date in DD/MM/YYYY format
  dueDate=$(future_date)
  [[ ${debug} = true ]] && echo dueDate "${dueDate}"

  # select datePublished - random future date in DD/MM/YYYY format
  datePublished=$(future_date)
  [[ ${debug} = true ]] && echo datePublished "${datePublished}"

  # select platforms - choose arbitrary from known list
  platforms_list=("In-app" "Live Events" "Metaverse" "Outdoor/Out-of-home" "pWeb" "Press/Media" "Social")
  platforms=$(get_arbitrary_items "${platforms_list[@]}")
  [[ ${debug} = true ]] && echo platforms "${platforms}"

  # generate campaigns - generate list with items of arbitrary size
  campaigns_list=$(generate_prefixed_list 5 campaign)
  campaigns=$(get_arbitrary_items ${campaigns_list[@]}) # No double quotes enclosing here!
  [[ ${debug} = true ]] && echo campaigns "${campaigns}"

  # select priority - choose 1 from known list
  priority_list=("Low" "Medium" "High")
  priority=$(get_any_one_item "${priority_list[@]}")
  [[ ${debug} = true ]] && echo priority "${priority}"

  # select markets - choose arbitrary from known list
  markets_list=("All" "Singapore" "Australia" "Mainland China" "Hong Kong" "India" "Indonesia" "Japan" "Korea" "Malaysia" "Taiwan" "Thailand" "UAE" "United Kingdom" "Vietnam" "Others")
  markets=$(get_arbitrary_items "${markets_list[@]}")
  [[ ${debug} = true ]] && echo markets "${markets}"

  # generate tags - generate list with items of arbitrary size
  tags_list=$(generate_prefixed_list 10 tag)
  tags=$(get_arbitrary_items ${tags_list[@]}) # No double quotes enclosing here!
  [[ ${debug} = true ]] && echo tags "${tags}"

  # select advancedRights - choose arbitrary from known list
  advanced_rights_list=("Show watermark" "Archive")
  advancedRights=$(get_arbitrary_items "${advanced_rights_list[@]}")
  [[ ${debug} = true ]] && echo advancedRights "${advancedRights}"

  # assetLocation and previewLocation
  assetLocationBucket="dbs-cmm"
  assetLocationKey="0c09853b-be48-4a4d-8eba-872dc212e900_abc.png"
  previewLocationBucket="dbs-cmm"
  previewLocationKey="visual-asset-management-system.png"
  assetLocation="{\"bucket\": \"${assetLocationBucket}\",\"key\": \"${assetLocationKey}\"}"
  previewLocation="{\"bucket\": \"${previewLocationBucket}\",\"key\": \"${previewLocationKey}\"}"

  originalFilename="sample_file.png"

  # Request to populate to DB
  json_payload="{
      \"assetTitle\": \"$assetTitle\",
      \"assetDescription\": \"$assetDescription\",
      \"channels\": ${channels},
      \"createdBy\": \"$createdBy\",
      \"assetType\": \"$assetType\",
      \"usageRights\": \"$usageRights\",
      \"licenseDateValidity\": \"$licenseDateValidity\",
      \"assetCategories\": ${assetCategories},
      \"dueDate\": \"$dueDate\",
      \"datePublished\": \"$datePublished\",
      \"platforms\": ${platforms},
      \"campaigns\": ${campaigns},
      \"priority\": \"$priority\",
      \"markets\": ${markets},
      \"tags\": ${tags},
      \"advancedRights\": ${advancedRights},
      \"assetLocation\": ${assetLocation},
      \"previewLocation\": ${previewLocation},
      \"originalFilename\": \"$originalFilename\"
    }"
  echo "${json_payload}"

  populate_to_db "${json_payload}"

  echo -e "\n"
done
