// INTERPLANETARY FLIGHT SUITE
//
// name:        Scan Terrain
// tag:         MSL_ST
// subsystem:   MSL
// description: Scans terrain below landing craft to make a determination
//              on a proper landing location.
//              
//              Scan location is specified as MSL_ST_LOOKAHEAD_DISTANCE out
//              toward spacecraft surface prograde direction, along the surface.
//              Four points are sampled around the scan location, at a radius
//              of MSL_ST_LOOKAHEAD_RADIUS meters. A good location is determined
//              if the ground slope at the scan location is less than
//              MSL_ST_LANDING_MAX_SLOPE degrees.
//
//              Return values:
//
//              MSL_ST_SCAN_GEOPOS       Geoposition struct pointing to scanned location.
//
//              MSL_ST_IS_GOOD_LANDING   Boolean set to true if slope at scanned location
//                                       is less than MSL_ST_LANDING_MAX_SLOPE
//

// ========================================================================== //
// =====================   I N I T I A L I Z A T I O N   ==================== //
// ========================================================================== //
//
// input arguments
declare parameter MSL_ST_LOOKAHEAD_DISTANCE.
declare parameter MSL_ST_LOOKAHEAD_RADIUS.
declare parameter MSL_ST_LANDING_MAX_SLOPE.

// return values
declare MSL_ST_IS_GOOD_LANDING.
declare MSL_ST_SCAN_GEOPOS.


// ========================================================================== //
// ========================   E N T R Y   P O I N T   ======================= //
// ========================================================================== //

set MSL_ST_CURRENT_GEOPOS          to SHIP:GEOPOSITION.

// vector to current ship position
set MSL_ST_CURRENT_RADIUS_ALTITUDE to SHIP:BODY:RADIUS + SHIP:ALTITUDE.
set MSL_ST_CURRENT_POS_VECTOR      to SHIP:UP:VECTOR * MSL_ST_CURRENT_RADIUS_ALTITUDE.

// vector to scan ahead
//set MSL_ST_LOOKAHEAD_VECTOR        to VCRS(SHIP:UP:VECTOR,V(0,1,0)):NORMALIZED * MSL_ST_LOOKAHEAD_DISTANCE.
set MSL_ST_LOOKAHEAD_VECTOR        to SHIP:SRFPROGRADE:VECTOR:NORMALIZED * MSL_ST_LOOKAHEAD_DISTANCE.
set MSL_ST_LOOKAHEAD_POS_VECTOR    to MSL_ST_CURRENT_POS_VECTOR + MSL_ST_LOOKAHEAD_VECTOR.

// flatten onto XZ plane
set MSL_ST_CURRENT_POS_VECTOR_XZ   to V(MSL_ST_CURRENT_POS_VECTOR:X,0,MSL_ST_CURRENT_POS_VECTOR:Z).
set MSL_ST_LOOKAHEAD_VECTOR_XZ     to V(MSL_ST_LOOKAHEAD_POS_VECTOR:X,0,MSL_ST_LOOKAHEAD_POS_VECTOR:Z).

// calculate current and lookahead position latitudes
set MSL_ST_CURRENT_POS_VECTOR_LAT  to ARCSIN(MSL_ST_CURRENT_POS_VECTOR:NORMALIZED:Y).
set MSL_ST_LOOKAHEAD_VECTOR_LAT    to ARCSIN(MSL_ST_LOOKAHEAD_POS_VECTOR:NORMALIZED:Y).

// calculate difference in lat/lng
set MSL_ST_LOOKAHEAD_LAT_DELTA     to MSL_ST_CURRENT_POS_VECTOR_LAT - MSL_ST_LOOKAHEAD_VECTOR_LAT.
set MSL_ST_LOOKAHEAD_LNG_DELTA     to VANG(MSL_ST_LOOKAHEAD_VECTOR_XZ,MSL_ST_CURRENT_POS_VECTOR_XZ).

set MSL_ST_LOOKAHEAD_LAT           to MSL_ST_CURRENT_GEOPOS:LAT + MSL_ST_LOOKAHEAD_LAT_DELTA.
set MSL_ST_LOOKAHEAD_LNG           to MSL_ST_CURRENT_GEOPOS:LNG + MSL_ST_LOOKAHEAD_LNG_DELTA.

// correct lng if past meridian
if (MSL_ST_LOOKAHEAD_LNG > 180) {
  set MSL_ST_LOOKAHEAD_LNG to MSL_ST_LOOKAHEAD_LNG - 360.
}

set MSL_ST_SCAN_GEOPOS_CTR         to LATLNG(MSL_ST_LOOKAHEAD_LAT, MSL_ST_LOOKAHEAD_LNG).

// convert length of MSL_ST_LOOKAHEAD_RADIUS to lat/lng degrees, at surface level
set MSL_ST_SCAN_GEOPOS_CTR_RADIUS  to SHIP:BODY:RADIUS + MSL_ST_SCAN_GEOPOS_CTR:TERRAINHEIGHT.
set MSL_ST_LOOKAHEAD_RADIUS_DEG    to (MSL_ST_LOOKAHEAD_RADIUS / MSL_ST_SCAN_GEOPOS_CTR_RADIUS) * 180 / CONSTANT():PI.

// determine four points around the center of the scanned area
set MSL_ST_SCAN_POINTS to LIST().
MSL_ST_SCAN_POINTS:ADD(LATLNG(MSL_ST_LOOKAHEAD_LAT + MSL_ST_LOOKAHEAD_RADIUS_DEG,MSL_ST_LOOKAHEAD_LNG)). // north
MSL_ST_SCAN_POINTS:ADD(LATLNG(MSL_ST_LOOKAHEAD_LAT - MSL_ST_LOOKAHEAD_RADIUS_DEG,MSL_ST_LOOKAHEAD_LNG)). // south
MSL_ST_SCAN_POINTS:ADD(LATLNG(MSL_ST_LOOKAHEAD_LAT,MSL_ST_LOOKAHEAD_LNG + MSL_ST_LOOKAHEAD_RADIUS_DEG)). // east
MSL_ST_SCAN_POINTS:ADD(LATLNG(MSL_ST_LOOKAHEAD_LAT,MSL_ST_LOOKAHEAD_LNG - MSL_ST_LOOKAHEAD_RADIUS_DEG)). // west

// determine highest/lowest point
set MSL_ST_SCAN_POINT_HI to 0.
set MSL_ST_SCAN_POINT_LO to SHIP:ALTITUDE.
for MSL_ST_GEOPOS in MSL_ST_SCAN_POINTS {
  if (MSL_ST_GEOPOS:TERRAINHEIGHT < MSL_ST_SCAN_POINT_LO) {
    set MSL_ST_SCAN_POINT_LO        to MSL_ST_GEOPOS:TERRAINHEIGHT.
    set MSL_ST_SCAN_POINT_LO_GEOPOS to MSL_ST_GEOPOS.
  }
  
  if (MSL_ST_GEOPOS:TERRAINHEIGHT > MSL_ST_SCAN_POINT_HI) {
    set MSL_ST_SCAN_POINT_HI        to MSL_ST_GEOPOS:TERRAINHEIGHT.
    set MSL_ST_SCAN_POINT_HI_GEOPOS to MSL_ST_GEOPOS.
  }
}.

// determine distance between points
set MSL_ST_SCAN_DISTANCE to MSL_ST_SCAN_POINT_LO_GEOPOS:ALTITUDEPOSITION(MSL_ST_SCAN_POINT_LO_GEOPOS:TERRAINHEIGHT) - MSL_ST_SCAN_POINT_HI_GEOPOS:ALTITUDEPOSITION(MSL_ST_SCAN_POINT_HI_GEOPOS:TERRAINHEIGHT).
set MSL_ST_SCAN_DISTANCE to MSL_ST_SCAN_DISTANCE:MAG.

// determine height difference
set MSL_ST_SCAN_HEIGHT_DIFF to MSL_ST_SCAN_POINT_HI - MSL_ST_SCAN_POINT_LO.

// calculate slop
set MSL_ST_SCAN_SLOPE to ARCSIN(MSL_ST_SCAN_HEIGHT_DIFF / MSL_ST_SCAN_DISTANCE).

// return values
set MSL_ST_SCAN_GEOPOS             to MSL_ST_SCAN_GEOPOS_CTR.
set MSL_ST_IS_GOOD_LANDING         to (ABS(MSL_ST_SCAN_SLOPE) < MSL_ST_LANDING_MAX_SLOPE).

