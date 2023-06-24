#/bin/bash
set +x

count=10
total_channels=5

for i in $(seq 1 ${count}); do
  channels=""
  num_channels=$(shuf -i 1-${total_channels} -n 1)
  selected_channel_numbers=$(shuf -i 1-${total_channels} -n ${num_channels})
  for selected_channel_number in ${selected_channel_numbers}; do
    channels+="channel${selected_channel_number},"
  done
  channels=`echo $channels | rev | cut -c2- | rev`
  echo $channels
