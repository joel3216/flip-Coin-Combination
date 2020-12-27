#! /bin/bash

# flip coin combination assignment
heads=1
tails=0
limit=10
declare -A singlets
declare -A singletPercent
declare -A doublets
declare -A doubletPercent
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

	singlets[$i]=$flipCoin1
	doublets[$i]=$flipCoin1$flipCoin2
	triplets[$i]=$flipCoin1$flipCoin2$flipCoin3

done

function combinationCount(){

	local -n dict=$1
	local -n dictPercent=$2
	for combination in ${dict[@]}
	do
		dictPercent[$combination]=$((${dictPercent[$combination]}+1))
	done
}

function combinationPercent(){
	local -n dictPercent=$1
	local limit=$2
	for combination in ${!dictPercent[@]}
	do
		dictPercent[$combination]=`awk 'BEGIN {print ('${dictPercent[$combination]}'/'$limit'*100)}'`
		echo $combination" "${dictPercent[$combination]}"%"
	done
}

function percentSort(){
local -n dictPercent=$1
local -n percentArray=$2
count=0
for percent in ${dictPercent[@]}
do
	percentArray[$count]=$percent
	count=$(($count+1))
done

arrLimit=${#percentArray[@]}
for ((i=0;i<arrLimit;i++))
do
	for ((j=0;j<arrLimit-i-1;j++))
	do
		if [[ `awk 'BEGIN {if( '${percentArray[$j]}' > '${percentArray[$j+1]}' ) print "true"}'` ]]
		then
			temp=${percentArray[$j]}
			percentArray[$j]=${percentArray[$j+1]}
			percentArray[$j+1]=$temp
		fi
	done
done
echo ${percentArray[@]}
maxPos=$(($arrLimit-1))
for combination in ${!dictPercent[@]}
do
	if [[ ${percentArray[$maxPos]} -eq ${dictPercent[$combination]} ]]
	then
		echo "the winning combination is "$combination
	fi
done

}

combinationCount singlets singletPercent
combinationPercent singletPercent $limit
percentSort singletPercent singletPercentArray

combinationCount doublets doubletPercent
combinationPercent doubletPercent $limit
percentSort doubletPercent doubletPercentArray

combinationCount triplets tripletPercent
combinationPercent tripletPercent $limit
percentSort tripletPercent tripletPercentArray



