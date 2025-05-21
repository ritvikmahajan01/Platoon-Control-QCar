# QCar Platoon Control System

This repository contains MATLAB/Simulink models and scripts for implementing and testing platoon control strategies using Quanser [QCar](https://www.quanser.com/products/qcar/) and virtual vehicles. A license to [QUARC](https://www.quanser.com/products/quarc-real-time-control-software/) is required to run the hardware experiments

## MATLAB Scripts

- `prerun.m`

  This script loads the required parameters for the experiments. The estimated transfer function model for the virtual vehicles, motor parameters, number of vehicles in the platoon, PID parameters, communication time delay, and the distance policy can be changed in this file. **This file needs to be run before running the experiments in Simulink/hardware!**

- `modelling.m`

  Based on the step response of the QCar (rise time, settling time, maximum overshoot), this file generates a 2nd-order transfer function model for the QCar. This model can be used for virtual agents in mixed-reality experiments



## Simulink Models

- `Parameter_Estimation_2020b.slx` (Quanser example)

  This file can be used to obtain the motor current, voltage, and speed from the given motor command using onboard sensors.

- `Parameter_Evaluation_2020b.slx` (Quanser example)

  This file can be used to compare the accuracy of a least-squares-based estimated model of the motor with the actual (processed and transformed) sensor readings.

 - `models_compare.slx`

    This is a file to compare the performance of the transfer function-based model for the QCar, the least-squares-based model, and the actual sensor readings.

- `Manual_Drive.slx` (Quanser example)

  This file can be used to control a QCar manually through a joystick.

- `platoon.slx`

  This file simulates a virtual platoon, with the vehicles following the estimated model of the QCar.

- `platoon1.slx`

  This is a mixed-reality platoon file. There is one physical QCar and several virtual agents. The position of the QCar, the number of agents, the information policy, etc., can be changed by modifying the blocks. By removing the QCar block (and modifying the other connections/blocks accordingly), a completely virtual platoon can also be simulated.

- `QCar1_control.slx`

  This file contains a PID-based control scheme to make the QCar follow a given velocity and heading trajectory. 

- `QCar1_platoon.slx` and `QCar2_platoon.slx`

  These are the main files to run for the mixed-reality platoon. These files contain mixed-reality platoons where each file has one physical QCar and several virtual agents. **The two files should be run on two different Ground Control Stations (GCSs) connected to the same wifi network! Also note that one GCS can run only one QCar through Simulink at a time** Through wifi, information (like position information of the platoon members) is shared between the two GCSs (and hence the two QCars).
