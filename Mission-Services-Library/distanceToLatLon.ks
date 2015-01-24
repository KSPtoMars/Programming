//NAME: distanceToLatLon.ks
//Given one lat/lon position and a vector distance, it calculates the second lat/lon position between the two points. This assumes a perfect spherical body (Earth is not perfect, but this models it well enough).


/// *** DEPENDENCIES ***
//None.

/// *** INPUTS ***
//latlon1 - The first latitude/longitude point.
//distance - The 2D vector pointing towards the second latitude/longitude as if it was on a xy plane.
//radius - the altitude at which these two points occur (in meters) from the center of the body.

/// *** OUTPUTS *** (Variables you will need later on)
//distanceToLatLon_latlon - The output latlon point.

DECLARE PARAMETER latlon1, distance, radius.

//(360)/(2*pi*r) is degrees/circumfrence
SET distanceToLatLon_distanceAngleRatio TO 360/(2*Constant():PI*radius).
SET distanceToLatLon_dLat TO distanceToLatLon_distanceAngleRatio * distance:Y.
SET distanceToLatLon_dLon TO distanceToLatLon_distanceAngleRatio * distance:X.

SET distanceToLatLon_latlon TO LATLNG(latlon1:LAT + distanceToLatLon_dLat,latlon1:LNG + distanceToLatLon_dLon).
