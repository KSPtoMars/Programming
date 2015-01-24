//NAME: latlonToDistance.ks
//Given two lat/lon positions, it calculates the surface distance between the two points.
//This uses the Greater Circle Formula


/// *** DEPENDENCIES ***
//None.

/// *** INPUTS ***
//latlon1 - The first latitude/longitude point.
//latlon2 - The second latitude/longitude point.
//radius - the altitude at which these two points occur (in meters) from the center of the body.

/// *** OUTPUTS *** (Variables you will need later on)
//latlonToDistance_distance - The distance between the two points.

DECLARE PARAMETER latlon1, latlon2, radius.
	
SET latlonToDistance_dLat TO latlon2:LAT - latlon1:LAT.
SET latlonToDistance_dLon TO latlon2:LON - latlon1:LON.

SET latlonToDistance_a TO sin(latlonToDistance_dLat/2)^2 + cos(latlon1:LAT) * cos(latlon2:LAT) * sin(latlonToDistance_dLon/2).

SET latlonToDistance_distance TO radius * (2 * arctan2(sqrt(latlonToDistance_a), sqrt(1-latlonToDistance_a)).

