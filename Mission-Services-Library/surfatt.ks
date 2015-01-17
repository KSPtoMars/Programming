//FILENAME: surfatt.ks
//Since SHIP:FACING seems to be bugged I guess we need something like this
//Utility script for getting the crafts current attitude relative to the surface


//Reference frame:
//Heading 0 degrees --> NORTH
//Heading 90 degrees --> EAST
//Heading 180 degrees --> SOUTH
//Heading 270 degrees --> WEST

//Determines what heading the crafts "bottom" is facing when craft is near vertical orientation
//Very useful during launches/landings because value stays the same regardless if craft exceeds 90 degrees pitch
if VANG(UP*V(0,1,0), VXCL(BODY:POSITION, SHIP:FACING:STARVECTOR)) > 90{
	SET surfatt_facing TO 180-VANG(UP*V(0,1,0), VXCL(BODY:POSITION, SHIP:FACING:TOPVECTOR)).
}
else{
	SET surfatt_facing TO 180+VANG(UP*V(0,1,0), VXCL(BODY:POSITION, SHIP:FACING:TOPVECTOR)).
}.
 
 
//Determines heading in a normal way (same value as the heading readout you see on the in-game compass displays)
//Heading will differ by +-180 degrees on either side of 90 degrees pitch
if VANG(UP*V(0,1,0), VCRS(BODY:POSITION, SHIP:FACING:FOREVECTOR)) > 90{
	SET surfatt_heading TO 360-VANG(UP*V(0,1,0), VXCL(BODY:POSITION, SHIP:FACING:FOREVECTOR)).
}
else{
	SET surfatt_heading TO VANG(UP*V(0,1,0), VXCL(BODY:POSITION, SHIP:FACING:FOREVECTOR)).
}.
 
 
 
//Determines roll
//-90 degrees --> pointing left wing straight towards ground
//+90 degrees --> pointing right wing straight towards ground
//0 degrees --> wings level
if VANG(VCRS(-1*BODY:POSITION, SHIP:FACING:FOREVECTOR), SHIP:FACING:TOPVECTOR) > 90{
	SET surfatt_Roll TO -1*VANG(VCRS(-1*BODY:POSITION, SHIP:FACING:FOREVECTOR), SHIP:FACING:STARVECTOR).
}
else{
	SET surfatt_Roll TO VANG(VCRS(-1*BODY:POSITION, SHIP:FACING:FOREVECTOR), SHIP:FACING:STARVECTOR).
}.
 
 
 
//Determines pitch
//0 degrees --> level flight
//90 degrees --> pitched straight up
//180 degrees --> upside down level flight
//270 degrees --> pitched straight down
SET surfatt_pitch TO VANG(BODY:POSITION, ship:facing:FOREVECTOR)-90.
if abs(surfatt_Roll) > 90 {
	if surfatt_pitch > 0{
	SET surfatt_pitch TO 180-surfatt_pitch.
	}.
   
	if surfatt_pitch < 0{
	SET surfatt_pitch TO 180-surfatt_pitch.
	}.
}
else{
	if surfatt_pitch < 0{
	SET surfatt_pitch TO 360+surfatt_pitch.
	}.
}.
