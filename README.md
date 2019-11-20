# Vampire Numbers

Computes the vampire numbers between the specified limits, distributing the
computation across all the available processor cores on the machine or network.

Each worker handles 100 numbers. Therefore for a range of 100000 numbers
(e.g., between 100000 and 200000), the number of worker actors created was **1000**.

## Instructions

Run the program with the command
```
mix run proj1.exs [lower_limit] [upper_limit]
```

## Results

The following timings were obtained for different sizes of worker actors
(executing the program for the range 100000 to 200000):

| Size of worker actors | Time - real | Time - user | Time - sys | Parallelism | 
|-----------------------|-------------|-------------|------------|-------------| 
| 1                     | 0m14.177s   | 0m26.459s   | 0m1.253s   | 1.958       | 
| 5                     | 0m11.851s   | 0m39.509s   | 0m0.653s   | 3.388       | 
| 10                    | 0m10.649s   | 0m39.422s   | 0m0.463s   | 3.754       | 
| 20                    | 0m10.748s   | 0m38.801s   | 0m0.383s   | 3.645       | 
| 30                    | 0m10.414s   | 0m38.800s   | 0m0.357s   | 3.76        | 
| 50                    | 0m11.395s   | 0m37.490s   | 0m0.393s   | 3.324       | 
| 100                   | 0m10.039s   | 0m37.186s   | 0m0.307s   | 3.735       | 
| 200                   | 0m10.147s   | 0m37.688s   | 0m0.311s   | 3.745       | 


The above runs were performed one after to simulate a consistent load on the system.
We chose the size of the worker actors to be **100** for our computer
(though smaller worker sizes resulted in more parallelism) as:
- The computer was able to handle 100 numbers in each actor.
- If we choose a smaller size, there would be more actors and the process limit would
be met for a larger range.
- If we choose a smaller size, more time would be spent in communication (ideally we
want to spend more time in computation).

## Sample Output

```
$ mix run proj1.exs 100000 200000 102510 510 201
104260 401 260
105210 501 210
105264 516 204
105750 705 150
108135 801 135
110758 701 158
115672 761 152
116725 725 161
117067 701 167
118440 840 141
120600 600 201
123354 534 231
124483 443 281
125248 824 152
125433 543 231
125460 615 204 510 246
125500 500 251
126027 627 201
126846 486 261
129640 926 140
129775 725 179
131242 422 311
132430 410 323
133245 423 315
134725 425 317
135828 588 231
135837 387 351
136525 635 215
136948 938 146
140350 401 350
145314 414 351
146137 461 317
146952 942 156
150300 501 300
152608 608 251
152685 585 261
153436 431 356
156240 651 240
156289 581 269
156915 951 165
162976 926 176
163944 414 396
172822 782 221
173250 750 231
174370 470 371
175329 759 231
180225 801 225
180297 897 201
182250 810 225
182650 650 281
186624 864 216
190260 906 210
192150 915 210
193257 591 327
193945 491 395
197725 719 275
```

### Running time for the above sample output
```
$ time mix run proj1.exs 100000 200000
...
real 0m9.925s
user 0m36.048s
sys 0m0.351s
```
Ratio of CPU time to real time = (36.048 + 0.351) / 9.925 = **3.667**

### Larger problems
* We could solve the following problem (100,000 to 1,000,000)

```
$ time mix run proj1.exs 100000 1000000
...
809964 906 894
815958 951 858
829696 926 896
841995 945 891
939658 986 953

real 1m27.608s
user 5m7.971s
sys 0m1.461s
```

* The last vampire number we could find was 939658 (when we executed the program for the range 100000 to 6000000)

> Note: All runs were performed on 1.8 GHz Intel Core i5 (i5-5350U) with 2 physical cores and 4 threads.
