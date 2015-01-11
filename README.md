# Programming

See the [wiki](https://www.reddit.com/r/ksptomars/wiki/flightsoftware) for more info.

-------------------------------

* **Mission-Application-Executive** (MAE): The main executable script. Depending on the current phase of flight, MAE will select the appropriate flight program for execution.

* **Mission-Application-Library** (MAL): A collection of flight programs to handle each phase of flight to and from Mars.

* **Mission-Services-Library** (MSL): A collection of utility routines made available to any Mission Application (create circularization node, execute next node, etc.)

* **Globals**: A database of system-adjustable parameters, dynamic real-time flight data, and universal constants.

-------------------------------

**How to run**

Copy *all* \*.ks files to <KSP_dir>/Ships/Script (no sub-directories allowed in here, only \*.ks files).

If you are going to space today, type in the following at the kOS terminal:

    run mae.


