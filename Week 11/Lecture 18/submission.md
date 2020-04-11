Yeo Ying Xuan				1003835

40.014 Engineering Systems Architecture

Spring 2020

Lecture 18 Activity

# Q1

**Formulate the problem as a Multi-Objective Linear Program (specify decision variables, objective functions and ALL constraints). Attach a screenshot of the formulation page after you have completed it.**

min f(x) = [f<sub>1</sub>(x), f<sub>2</sub>(x), f<sub>3</sub>(x)]

​			= [0.52 x<sub>1</sub> + 1.4 x<sub>2</sub> + 2.1 x<sub>3</sub> + 4.51 x<sub>4</sub>,

​			    0.2 x<sub>1</sub> + 4 x<sub>2</sub> + 1.2 x<sub>3</sub> + 0.3 x<sub>4</sub>,

​			    0.03 x<sub>1</sub> + 0.08 x<sub>2</sub> + 0.1 x<sub>3</sub> + 0.06 x<sub>4</sub>]

s.t. x<sub>1</sub> + x<sub>2</sub> + x<sub>3</sub> + x<sub>4</sub> >= 250 000

​      0 <= x<sub>1</sub> <= 70 000

​	  0 <= x<sub>2</sub> <= 100 000

​	  0 <= x<sub>3</sub> <= 120 000

​      x<sub>4</sub> >= 0

where x<sup>T</sup> = [x<sub>1</sub>, x<sub>2</sub>, x<sub>3</sub>, x<sub>4</sub>] is a vector of four decision variables representing groundwater, surface water, imported water and desalinated water.

![Q1](/Users/yingxuan/Desktop/Q1.png)

# Q2

**What is the value of the objective functions obtained at the first iteration?** 

Energy x1 =  529057.5

Chemicals x2 = 211623.0

Manpower x3 = 17892.56

# Q3

For each iteration, report the selected alternative(s) and the corresponding classification for each objective function. For the second iteration, attach a screenshot of the “Analyse Results” page and visualize the alternatives using bar charts (attach screenshot as well).

## 1<sup>st</sup> Iteration

Classification of Objective Functions

 ![Screenshot 2020-04-10 at 11.09.24 PM](/Users/yingxuan/Desktop/Screenshot 2020-04-10 at 11.09.24 PM.png)

## 2<sup>nd</sup> Iteration

Selected Alternative

![Screenshot 2020-04-10 at 11.10.22 PM](/Users/yingxuan/Desktop/Screenshot 2020-04-10 at 11.10.22 PM.png)


Classification of Objective Functions

![Screenshot 2020-04-10 at 11.12.20 PM](/Users/yingxuan/Desktop/Screenshot 2020-04-10 at 11.12.20 PM.png)


![Screenshot 2020-04-10 at 11.16.27 PM](/Users/yingxuan/Desktop/Screenshot 2020-04-10 at 11.16.27 PM.png)


## 3<sup>rd</sup> Iteration

Visualisation

![Screenshot 2020-04-10 at 11.20.27 PM](/Users/yingxuan/Desktop/Screenshot 2020-04-10 at 11.20.27 PM.png)

Selected Alternatives

![Screenshot 2020-04-10 at 11.18.27 PM](/Users/yingxuan/Desktop/Screenshot 2020-04-10 at 11.18.27 PM.png)


Generate a solution between the two alternatives in the next iteration.

## 4<sup>th</sup> Iteration

Selected Alternative

![Screenshot 2020-04-10 at 11.23.54 PM](/Users/yingxuan/Desktop/Screenshot 2020-04-10 at 11.23.54 PM.png)


# Q4

For the last iteration, report the value of objective functions and decision variables. Provide a brief description/interpretation of your results.

![Screenshot 2020-04-10 at 11.25.32 PM](/Users/yingxuan/Desktop/Screenshot 2020-04-10 at 11.25.32 PM.png)


All groundwater available is used.

Only a fraction of surface and imported water is used.

Main source of water is desalinated water, hence the high energy usage.

