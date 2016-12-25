# Formation-Algorithm
Multi agent flocking and formation algorithm.
The most recent GUI is "FormationGUI3.m". The algorithm should be run from this. 
On initialization, use of 35 drones or fewer is recommended for best results. 
Ensure to enable offset within the GUI.
the main adjacency algorithm and most calculations are performed within the file "collectiveaverage.m".

The Purpose of the project was to simulate formation of drones based on a self updating adjacency matrix determined by radius of confidence calculations. The algorithm detects which drones are within a given radius of convergence of any others and preforms averaging calculations to cause the drones to flock into a specific pattern. The drones orient themselves in a closest packing formationion where no two are too close together. 

The project was developped for application in flocking of muliagent systems specifically under the pretenses of automated fire fighting. The drones would carry water over drop sites for forest fire fighting in remote locations. 
