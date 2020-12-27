#! /bin/bash

# flip coin combination assignment
heads=1
tails=0
limit=10
declare -A triplets
declare -A tripletPercent

for ((i=0;i< $limit;i++))
do
	flipCoin1=$((RANDOM%2))
	flipCoin2=$((RANDOM%2))
	flipCoin3=$((RANDOM%2))
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

	if [[ $flipCoin3 -eq $heads ]]
	then
		flipCoin3="H"
	else
		flipCoin3="T"
	fi

	triplets[$i]=$flipCoin1$flipCoin2$flipCoin3

done

for combination in ${triplets[@]}
do
	tripletPercent[$combination]=$((${tripletPercent[$combination]}+1))
done

echo ${triplets[@]}
for combination in ${!tripletPercent[@]}
do
	tripletPercent[$combination]=`awk 'BEGIN {print ('${tripletPercent[$combination]}'/'$limit'*100)}'`
	echo $combination" "${tripletPercent[$combination]}"%"
done
