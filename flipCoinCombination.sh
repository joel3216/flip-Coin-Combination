#! /bin/bash

# flip coin combination assignment
heads=1
tails=0
flipCoin=$((RANDOM%2))

if [[ $flipCoin -eq $heads ]]
then
	echo "Heads"
else
	echo "Tails"
fi
