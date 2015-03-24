#!/bin/bash
for i in {100..200..100}
do
	for j in {001..099}
	do
		wget "http://cdn.loc.gov/service/pnp/prok/00$i/00$(expr $i + $j )v.jpg"
   	done
done