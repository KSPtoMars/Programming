DECLARE parameter msg.
IF missiontime >= 0 {
	print "[T+" + round(missiontime) + "s]: " + msg.
}
ELSE {
	print "[T-" + round(missiontime) + "s]: " + msg.
}.
//Writes the msg to the console, appending The mission time in seconds before it.