//NAME: impactLocation.ks
//Script that returns the location of impact with the ground if engines are turned off at this instant.
//This is based on simple kinematics equations.

//TODO:
//Add air drag/resistance calculations

/// *** DEPENDENCIES ***
//bodyconst.ks - (called).
//distanceToLatLon.ks - (available).

/// *** INPUTS ***
//surfaceVelocity - The velocity of the craft relative to the surface. THIS IS NOT ORBITAL VELOCITY.
//geoPosition - The latitude, longitude of the spacecraft (or whatever).
//altitude - How high above the ground the spacecraft is.
//objMass - The mass of the spacecraft.
//error - The maximum error in impact location approximation. (Relative percentage to the distance).

/// *** OUTPUTS *** (Variables you will need later on)
//impactLocation_location - the latitude and longitude of the landing site, or impact location.
//impactLocation_sDistance - scalar distance in meters until impact (meters)
//impactLocation_distance - vector distance until impact in the x,y,z direction (meters)
//impactLocation_time - time until impact (seconds)

DECLARE PARAMETER surfaceVelocity, geoPosition, altitude, objMass, error.

SET impactLocation_g TO bodyconst_stdGravParam * objMass/(bodyconst_radius^2).

//Acceleration in the x, y, z components
//TODO: ADD FRICTION
SET impactLocation_ax TO 0.
SET impactLocation_ay TO 0 - impactLocation_g.
SET impactLocation_az TO 0.

//This variable converges on the impact location.
SET impactLocation_location TO geoPosition.
// Just to ensure at least one loop run.
SET impactLocation_error TO error * 2.
SET impactLocation_sDistance TO 0.

//Calculates until the relative error on convergence is less than the error allowed.
UNTIL impactLocation_error < error {

	//This variable converges on the impact location.
	SET impactLocation_lastDistance TO impactLocation_sDistance.

	//Terrain Height
	SET impactLocation_terrainHeight TO impactLocation_location:TERRAINHEIGHT.
	SET impactLocation_dy TO altitude - impactLocation_terrainHeight. 

	//Time to impact
	if (-1 * surfaceVelocity:Y + SQRT(surfaceVelocity:Y^2 - 2 * impactLocation_ay * impactLocation_dy))/impactLocation_ay >= 0 {
	SET impactLocation_time TO (-1 * surfaceVelocity:Y + SQRT(surfaceVelocity:Y^2 - 2 * impactLocation_ay * impactLocation_dy))/impactLocation_ay.
	}
	ELSE {
		SET impactLocation_time TO (-1 * surfaceVelocity:Y - SQRT(surfaceVelocity:Y^2 - 2 * impactLocation_ay * impactLocation_dy))/impactLocation_ay.	
	}.
	
	//Distance to impact
	SET impactLocation_xDistance TO 0.5 * impactLocation_ax * impactLocation_time^2 + surfaceVelocity:X * impactLocation_time.
	SET impactLocation_yDistance TO impactLocation_location:TERRAINHEIGHT.
	SET impactLocation_zDistance TO 0.5 * impactLocation_az * impactLocation_time^2 + surfaceVelocity:Z * impactLocation_time.
	SET impactLocation_sDistance TO sqrt(impactLocation_xDistance^2 + impactLocation_yDistance^2 + impactLocation_zDistance^2).
	SET impactLocation_distance TO V(impactLocation_xDistance,impactLocation_yDistance,impactLocation_zDistance).

	//Location of Impact
	run distanceToLatLon(geoPosition,impactLocation_distance,bodyconst_radius).
	SET impactLocation_location TO distanceToLatLon_latlon.
	

	//ERROR Calculation
	SET impactLocation_error TO ABS(1 - impactLocation_lastDistance/impactLocation_sDistance).
}	