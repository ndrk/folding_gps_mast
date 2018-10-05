/*
All configuration variables that you should need to worry about are contained in
the following section.
*/
// Flags to turn parts on/off when generating stl files
bShowBase = true;
bShowLockingClip = true;
bShowMast = true;
bShowPlatform = true;

smoothness = 80;
partGap = 0.2;

baseDiskDiameter = 18;
baseHeight = 4;

numMountingFlanges = 2;

flangeHoleCenterOffset = 34/2;  //Spacing of mounting holes on erel copter base is 34 mm.

flangeWidth = 8;
flangeHoleDiameter = 3;

cageThickness = 2;
cageHeight = 10;
cageSlotVertOffset = 2;

clipHeight = 6;
clipThickness = 2.5;

pivotPointDiameter = 5;

mastLength = 105;

platformDiameter = 35;
platformHeight = 6;

numLighteningHoles = 5;
mastPocketThickness = 2;

/*
End of configuration variables.
*/

include <../mast_lib.scad>;