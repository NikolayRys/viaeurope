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
The task is essentially a NP-complete optimization problem, so it cannot be solved optimally in most practical cases.

From the engineering standpoint, I'm implemented a hybrid approach, that tries to quickly achieve reasonable results with heuristics, 
and then if time is left, tries to find the optimal solution.

There are many algorithms known in academical research that can used for both steps. Since this implementation is PoC, I've 
went with the simplest ones, but there are more advanced ones available.

1. Best-fit-decreasing - a heuristic algo with O(n(log n)) complexity.
2. Brute-force - an exhaustive search with O(n!) complexity that is guaranteed to find the optimal solution if sufficient time is given. I've also found an academical paper that allows to estimate required amount of bins for optimal solution, so I'm saving some time only iterating over the combinations for a particular number of bins.

I'm using this hybrid strategy for the parcel processing script.

## How to use the script
```
bundle install
rspec
./assign_shipments.rb input.csv output2.csv 3
```
The integer parameter means "time budget" and is used to specify time in seconds for attempting to improve the heuristic solution with the exhaustive search.

## What would you I do if I have more time?
There can be many improvements that are likely to be out of the scope of the task.

– Use more sophisticated heuristic to improve probability of success. First, there are other modern general-purpose algorithms as Modified First-Fit-Decreasing, that provides better guarantees than used BFD. Second, we likely can use statistical analysis of the real shipping data, to narrow down the problem domain.
– Use more sophisticated exhaustive search algorithm - e.g. Branch-and-Bound or Bin-packing, that reduce the problem space compared to the brute-force.
- Rework the exhaustive algorithm to use it's own stack instead of recursion.
– Parallelize the search
- Find a way to meaningfully control the budget for exhaustive search depending on the system load and input size.
