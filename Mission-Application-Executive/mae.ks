// INTERPLANETARY FLIGHT SUITE
//
// name:        Mission_Application_Executive
// subsystem:   MAE
// description: Sets up necessary environment for IFS, executes Mission Applications.
// 
//

// print a Welcome screen
CLEARSCREEN.

// terminal screen width is 50 characters
PRINT "                                                  ".
PRINT "                                                  ".
PRINT "                                                  ".
PRINT "                                                  ".
PRINT "   __ _________    __         __  ___             ".
PRINT "   / //_/ __/ _ \  / /____    /  |/  /__ ________ ".
PRINT "  / ,< _\ \/ ___/ / __/ _ \  / /|_/ / _ `/ __(_-< ".
PRINT " /_/|_/___/_/     \__/\___/ /_/  /_/\_,_/_/ /___/ ".
PRINT "                                                  ".
PRINT "                                                  ".
PRINT "                   WELCOME TO THE                 ".
PRINT "           MISSION APPLICATION EXECUTIVE          ".
PRINT "           -----------------------------          ".
PRINT "                                                  ".
PRINT "                                                  ".
PRINT "                                                  ".
PRINT "            Shall we go to space today?           ".
PRINT "                                                  ".
PRINT "                                                  ".
PRINT "                                                  ".

// Intialize Globals subsystem
PRINT "Initializing GLOBALS subsystem...".
RUN globals_init_sap.


