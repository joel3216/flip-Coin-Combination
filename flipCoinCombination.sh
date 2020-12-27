#! /bin/bash

# flip coin combination assignment
heads=1
tails=0
limit=10
declare -A singlets
declare -A singletPercent

for ((i=0;i< $limit;i++))
do
	flipCoin1=$((RANDOM%2))
	flipCoin2=$((RANDOM%2))
	if [[ $flipCoin1 -eq $heads ]]
	then
		flipCoin1="H"
	else
		flipCoin1="T"
	fi

	if [[ $flipCoin2 -eq $heads ]]
	then
		flipCoin2="H"
	else
		flipCoin2="T"
	fi

	singlets[$i]=$flipCoin1$flipCoin2

done

for combination in ${singlets[@]}
do
	singletPercent[$combination]=$((${singletPercent[$combination]}+1))
done

echo ${singlets[@]}
for combination in ${!singletPercent[@]}
do
	singletPercent[$combination]=`awk 'BEGIN {print ('${singletPercent[$combination]}'/'$limit'*100)}'`
	echo $combination" "${singletPercent[$combination]}"%"
done
