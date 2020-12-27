#! /bin/bash -x

# flip coin combination assignment
heads=1
tails=0
limit=10
declare -A singlets
declare -A singletPercent

for ((i=0;i< $limit;i++))
do
	flipCoin=$((RANDOM%2))
	if [[ $flipCoin -eq $heads ]]
	then
		singlets[$i]="H"
	else
		singlets[$i]="T"

	fi
done

for combination in ${singlets[@]}
do
	singletPercent[$combination]=$((${singletPercent[$combination]}+1))
done

echo ${singlets[@]}
for combination in ${!singletPercent[@]}
do
	singletPercent[$combination]=`awk 'BEGIN {print ('${singletPercent[$combination]}'/'$limit'*100)}'`
done
