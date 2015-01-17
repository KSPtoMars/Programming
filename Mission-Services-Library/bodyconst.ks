//NAME: bodyconst.ks

//Usage: Call the script with the name of the body you want the constants for.
//Example arguments: BODY:NAME, "Duna"

//TODO:
//Make sure that these values actually are the ones we should have
//These values are straight from wikipedia and differ slightly from the ones
//that are in the RSS body tooltip in game in some areas

DECLARE PARAMETER body.

//Universal constants
SET bodyconst_gravConst TO 6.673*10^-11.

//Body-specific constants
IF BODY = "Kerbin" {
	PRINT "Setting physical constants for Earth.".
	SET bodyconst_radius TO 6371000.
	SET bodyconst_mass TO 5.97219*10^24.
	SET bodyconst_SurfaceGrav TO 9.81.
}
IF BODY = "Mun" {
	PRINT "Setting physical constants for the Moon.".
	SET bodyconst_radius TO 1737.10.
	SET bodyconst_mass TO 7.3477*10^22.
	SET bodyconst_SurfaceGrav TO 1.622.
}
ELSE IF BODY = "Duna" {
	PRINT "Setting physical constants for Mars.".
	SET bodyconst_radius TO 3396200.
	SET bodyconst_mass TO 6.4185*10^23.
	SET bodyconst_SurfaceGrav TO 3.69.
}
ELSE IF BODY = "Bop" {
	PRINT "Setting physical constants for Phobos.".
	SET bodyconst_radius TO 11.3.
	SET bodyconst_mass TO 1.0659*10^16.
	SET bodyconst_SurfaceGrav TO 0.0057.
}
ELSE IF BODY = "Gilly" {
	PRINT "Setting physical constants for Deimos.".
	SET bodyconst_radius TO 6.2.
	SET bodyconst_mass TO 1.4762*10^15.
	SET bodyconst_SurfaceGrav TO 0.003.
}
ELSE IF BODY = "Sun" {
	PRINT "Setting physical constants for Sol.".
	SET bodyconst_radius TO 696342000.
	SET bodyconst_mass TO 1.9886*10^30.
	SET bodyconst_SurfaceGrav TO 274.
}

ELSE {
	PRINT "Error: invalid body!".
}.

SET bodyconst_stdGravParam to bodyconst_gravConst*bodyconst_mass.
