// INTERPLANETARY FLIGHT SUITE
//
// name:        Mars Descent
// subsystem:   MAL
// description: Placeholder application for Mars landing sequence.
// 
//

// ========================================================================== //
// =====================   I N I T I A L I Z A T I O N   ==================== //
// ========================================================================== //
//
// insert any code that needs to run first. declare variables, input parameters,
// output variables... etc.
//

print "Mars Descent".
print " ".
print " ".

// init variables
// -----------------------------------------------------------------------------
SET MD_COUNT TO 0.

// vector drawings
set VEC_SHIP_TO_FUTURE_POS to VECDRAWARGS(V(0,0,0), V(0,0,0), RED,    "scan area",    1, TRUE).

set VEC_SRFPROGRADE to VECDRAWARGS(V(0,0,0), V(0,0,0), BLUE, "lookahead", 1, TRUE).

set VEC_LOOKAHEAD_SCAN1 to VECDRAWARGS(V(0,0,0), V(0,0,0), WHITE, "", 1, TRUE).
set VEC_LOOKAHEAD_SCAN2 to VECDRAWARGS(V(0,0,0), V(0,0,0), WHITE, "", 1, TRUE).
set VEC_LOOKAHEAD_SCAN3 to VECDRAWARGS(V(0,0,0), V(0,0,0), WHITE, "", 1, TRUE).
set VEC_LOOKAHEAD_SCAN4 to VECDRAWARGS(V(0,0,0), V(0,0,0), WHITE, "", 1, TRUE).
set VEC_LOOKAHEAD_SCAN_HI to VECDRAWARGS(V(0,0,0), V(0,0,0), MAGENTA, "", 1, FALSE).
set VEC_LOOKAHEAD_SCAN_LO to VECDRAWARGS(V(0,0,0), V(0,0,0), MAGENTA, "", 1, FALSE).


// ========================================================================== //
// ========================   E N T R Y   P O I N T   ======================= //
// ========================================================================== //
//
// insert main code to execute
//

until MD_COUNT > 20000 {
  run msl_scan_terrain(1000,200,5).
  
  set VEC_SHIP_TO_FUTURE_POS:VECTOR to MSL_ST_SCAN_GEOPOS_CTR:ALTITUDEPOSITION(MSL_ST_SCAN_GEOPOS_CTR:TERRAINHEIGHT).
  
  set VEC_SRFPROGRADE:VECTOR to MSL_ST_LOOKAHEAD_VECTOR.
  
  set VEC_LOOKAHEAD_SCAN1:VECTOR to MSL_ST_SCAN_POINTS[0]:ALTITUDEPOSITION(MSL_ST_SCAN_POINTS[0]:TERRAINHEIGHT).
  set VEC_LOOKAHEAD_SCAN2:VECTOR to MSL_ST_SCAN_POINTS[1]:ALTITUDEPOSITION(MSL_ST_SCAN_POINTS[1]:TERRAINHEIGHT).
  set VEC_LOOKAHEAD_SCAN3:VECTOR to MSL_ST_SCAN_POINTS[2]:ALTITUDEPOSITION(MSL_ST_SCAN_POINTS[2]:TERRAINHEIGHT).
  set VEC_LOOKAHEAD_SCAN4:VECTOR to MSL_ST_SCAN_POINTS[3]:ALTITUDEPOSITION(MSL_ST_SCAN_POINTS[3]:TERRAINHEIGHT).
  
  set VEC_LOOKAHEAD_SCAN_HI:VECTOR to MSL_ST_SCAN_POINT_HI_GEOPOS:ALTITUDEPOSITION(MSL_ST_SCAN_POINT_HI_GEOPOS:TERRAINHEIGHT).
  set VEC_LOOKAHEAD_SCAN_LO:VECTOR to MSL_ST_SCAN_POINT_LO_GEOPOS:ALTITUDEPOSITION(MSL_ST_SCAN_POINT_LO_GEOPOS:TERRAINHEIGHT).
  
  clearscreen.
  print "Current Location".
  print "* LAT    = " + ROUND(MSL_ST_CURRENT_GEOPOS:LAT,8).
  print "* LNG    = " + ROUND(MSL_ST_CURRENT_GEOPOS:LNG,8).
  print "* SEALV  = " + ROUND(SHIP:ALTITUDE,3).
  print "* RADAR  = " + ROUND(SHIP:ALTITUDE - SHIP:GEOPOSITION:TERRAINHEIGHT,3).
  print "* HEIGHT = " + ROUND(SHIP:GEOPOSITION:TERRAINHEIGHT,3).
  print " ".
  
  print "Predicted Location".
  print "* LAT    = " + ROUND(MSL_ST_SCAN_GEOPOS_CTR:LAT,8).
  print "* LNG    = " + ROUND(MSL_ST_SCAN_GEOPOS_CTR:LNG,8).
  print "* HEIGHT = " + ROUND(MSL_ST_SCAN_GEOPOS_CTR:TERRAINHEIGHT,3).
  print "* SLOPE  = " + ROUND(MSL_ST_SCAN_SLOPE,5).
  if (MSL_ST_IS_GOOD_LANDING) {
    print "*** GOOD LANDING SPOT FOUND ***".
  } else {
    print " ".
  }
  print " ".
  
  wait 0.5.
}

print "Mars Descent FINISHED".

