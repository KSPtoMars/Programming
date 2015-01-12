// INTERPLANETARY FLIGHT SUITE
//
// name:        Test_App
// subsystem:   MAE
// description: Test application
// 
//

// ========================================================================== //
// =====================   I N I T I A L I Z A T I O N   ==================== //
// ========================================================================== //
//
// insert any code that needs to run first. declare variables, input parameters,
// output variables... etc.
//

print "Test_App".
print " ".
print " ".

// init variables
// -----------------------------------------------------------------------------
SET MyVars1 TO 5.
SET MyVars2 TO 6.
SET Count TO 1.

SET T_init TO TIME:SECONDS.


// ========================================================================== //
// =================   I N T E R R U P T   R O U T I N E S   ================ //
// ========================================================================== //
//
// set up routines here that are triggered by external events/conditions. these
// routines should be "very short" since the main code below ("Entry Point" section)
// will be temporarily halted while this stuff executes.
//

// set up a five-second timer
when (TIME:SECONDS > T_init + 5.0) then {
  PRINT "The current time is: " + TIME:SECONDS.
  
  SET Count TO (Count + 1).
  
  // reset timer
  SET T_init TO TIME:SECONDS.
  PRESERVE.
}.



// ========================================================================== //
// ========================   E N T R Y   P O I N T   ======================= //
// ========================================================================== //
//
// insert main code to execute
//

wait until Count > 5.

print "Test_App FINISHED".

