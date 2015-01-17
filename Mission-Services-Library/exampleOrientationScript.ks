//Example script that shows how use the main utility script "orientvector.ks"
//Press AG7 to enable the script
//Press AG1-5 to cycle through example vectors

// *** DEPENDENCIES ***
//orientvector.ks
//steerangles.ks

clearscreen.

SET A TO 0.

SET pitchP TO 0.
SET pitchD TO 0.

SET yawP TO 0.
SET yawD TO 0.

SET rollP TO 0.
SET rollD TO 0.

until 1=2 {

	run orientvector(SHIP:VELOCITY:ORBIT,pitchP,pitchD, yawP, yawD, rollP, rollD).

	wait 0.05.
	ON AG7 set A to 7.
	if A = 7 { BREAK. }.
}.

SET pitchP TO 0.004.
SET pitchD TO 0.004.

set yawP TO 0.004.
set yawD TO 0.004.

SET rollP TO 0.04.
SET rollD TO 0.04.

PRINT "Pointing prograde." at (0,20).
until 1=2 {

	run orientvector(SHIP:VELOCITY:ORBIT,pitchP,pitchD, yawP, yawD, rollP, rollD).

	wait 0.05.
	ON AG1 set A to 1.
	if A = 1 { BREAK. }.
}.
PRINT "Pointing towards the sun." at (0,21).
until 1=2 {

	run orientvector(SUN:POSITION,pitchP,pitchD, yawP, yawD, rollP, rollD).
	wait 0.05.

	ON AG2 set A to 2.
	if A = 2 { BREAK. }.
}.
PRINT "Pointing V(1,0,0)." at (0,22).
until 1=2 {

	run orientvector( V(1,0,0),pitchP,pitchD, yawP, yawD, rollP, rollD ).
	wait 0.05.

	ON AG3 set A to 3.
	if A = 3 { BREAK. }.
}.

PRINT "Pointing V(0,1,0)." at (0,23).
until 1=2 {

	run orientvector(V(0,1,0),pitchP,pitchD, yawP, yawD, rollP, rollD).
	wait 0.05.

	ON AG4 set A to 4.
	if A = 4 { BREAK. }.
}.

PRINT "Pointing V(0,0,1)." at (0,24).
until 1=2 {

	run orientvector(V(0,0,1),pitchP,pitchD, yawP, yawD, rollP, rollD).
	wait 0.05.

	ON AG5 set A to 3.
	if A = 5 { BREAK. }.
}.