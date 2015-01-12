// INTERPLANETARY FLIGHT SUITE
//
// name:        Globals_Init_SAP
// subsystem:   Globals
// description: Sets up system-adjustable parameters (SAP's)
// 
//

// Earth-related parameters
//------------------------------------------------------------------------------

// initial orbit to launch
SET SAP_EARTH_ORBIT_ALTITUDE    TO  229000. // meters
SET SAP_EARTH_ORBIT_INCLINATION TO   2.795. // degrees
SET SAP_EARTH_ORBIT_RIGHT_ASC   TO 203.805. // degrees

// return landing coordinates
SET SAP_EARTH_LANDING_LAT       TO   65.58. // degrees
SET SAP_EARTH_LANDING_LNG       TO   22.14. // degrees

// Mars-related parameters
//------------------------------------------------------------------------------

// initial insertion orbit
SET SAP_MARS_ORBIT_ALTITUDE     TO  100000. // meters
SET SAP_MARS_ORBIT_INCLINATION  TO       0. // degrees

// landing coordinates
SET SAP_MARS_LANDING_LAT        TO   22.48. // degrees
SET SAP_MARS_LANDING_LNG        TO  -49.97. // degrees
