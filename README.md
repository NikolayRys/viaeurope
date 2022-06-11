# Nikolay's test task for ViaEurope

## Requirements 

Given a CSV file that contains a list of parcels and their respective weight and client name. You'll need to write a program that will efficiently group these parcels into shipments. The conditions are:

- a shipment has a maximum weight of 2311 kg;
- one client's parcels may not be in multiple shipments;
- a shipment may contain parcels from multiple clients;
- a single parcel may not be split between shipments;
- the code must be written in Ruby;
- units of weight don't matter, since there's no need for conversion or split, but for the sake of the exercise, all weight units can be assumed to be in kilograms.

The goal is to group parcels into as few shipments as possible. For the sake of this task, it can be assumed that no client's total weight of parcels will be bigger than the maximum weight of a shipment. Output CSV file in the same format as the input file with generated shipment IDs.
Attached you may find a sample input and output CSV files.


## My comments
NP-complete optimization problem.input.csv
output.csv

Cannot be efficiently solved in most practical cases.

1. Heuristic solution with n(log n) complexity: Refined first-fit algorithm.
2. Exhaustive search with n^2 complexity: Branch and bound.

## Most important files
