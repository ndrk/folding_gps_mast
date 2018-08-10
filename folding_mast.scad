smoothness = 80;
partGap = 0.2;

baseDiskDiameter = 18;
baseHeight = 4;

flangeLength = 14;
flangeWidth = 8;
flangeHoleDiameter = 3;

basePivotDiameter = 12;
basePivotHeight=20;
basePivotSlotWidth = basePivotDiameter + 1;
basePivotSlotHeight = basePivotHeight;
basePivotSlotLength = 4;
pivotPointDiameter = 5;

mastDiameter = 3;
mastWidth = pivotPointDiameter; //3;
mastLength = 100;
mastRoundingDiameter = mastWidth * 1.2;

platformDiameter = 35;
platformHeight = 6;

pivotSlotDiameter = pivotPointDiameter+partGap*2;
pivotSlotWidth = mastWidth+partGap;

cageThickness = 2;
cageLength = pivotSlotWidth+cageThickness+4;
cageWidth = pivotSlotWidth+cageThickness*2;
cageHeight = 10;

clipHeight = 6;
clipThickness = 2.5;
clipWidth = cageWidth + partGap;

cageSlotHeight = clipHeight + partGap*2;
cageSlotWidth = clipThickness + partGap*2;
cageSlotVertOffset = 2;

//Build the assembly
gpsMast();

module gpsMast() {
	union() {
		base();
		mast();
    lockingClip();
	}
}

module lockingClip() {
  rotate(45,0,0)
    translate([cageSlotWidth-partGap,-clipWidth/2,baseHeight*2+cageSlotVertOffset+partGap])
      difference() {
        union() {
          // Body of clip
          cube([clipThickness, clipWidth, clipHeight]);
          // End Stop of clip
          translate([-clipThickness/2,clipWidth,-clipThickness/2])
            cube([clipThickness*2, clipThickness, clipHeight+clipThickness]);
          // Latch of clip
          rotate([0,270,0])
            translate([-clipHeight/4+clipHeight/2,-clipHeight/2,-clipHeight/1.7])
              prism(clipHeight/2, clipHeight/2, clipHeight/2);
        }
        // Remove material to make the clip movable
        translate([0,-1, clipHeight/4])
          cube([clipThickness/2, clipWidth+1, clipHeight/2]);
        translate([0,-1, clipHeight/2+clipHeight/4])
          cube([clipThickness, clipWidth+1, partGap]);
          translate([0,-1, clipHeight/2-clipHeight/4-partGap])
            cube([clipThickness, clipWidth+1, partGap]);
      }
}

module mast() {
	//translate([-mastPivotHeight/2,-mastPivotWidth/2,baseHeight+mastVerticalOffset+partGap])
	rotate([0,0,45])
    union() {
      // The mast itself
      intersection(){
          translate([-mastWidth/2,-mastWidth/2,mastWidth/2])
  		      cube([mastWidth, mastWidth, mastLength-mastWidth/2]);
          translate([0,0,mastLength/2])
            cylinder(d=mastRoundingDiameter, h=mastLength, center=true, $fn=smoothness);
      }
      // The pivot point
      rotate([90,0,0])
        translate([0,mastWidth/2,-baseDiskDiameter/2])
          cylinder(d=mastWidth, h=baseDiskDiameter, $fn=smoothness);
      // The platform for the GPS unit
      difference() {
        union() {
          translate([0,0,mastLength])
            cylinder(d2=platformDiameter, d1=mastWidth, h=platformHeight/2, $fn=smoothness);
          translate([0,0,mastLength+platformHeight/2])
            cylinder(d=platformDiameter, h=platformHeight/2, $fn=smoothness);
          translate([0,0,mastLength-mastWidth*2+1])
            cylinder(d2=mastWidth*2, d1=0, h=mastWidth*2);
        }
        translate([platformDiameter/3,0, mastLength])
          cylinder(d=platformDiameter/5, h=platformHeight, $fn=smoothness);
        translate([-platformDiameter/3,0, mastLength])
          cylinder(d=platformDiameter/5, h=platformHeight, $fn=smoothness);
        translate([0, platformDiameter/3, mastLength])
          cylinder(d=platformDiameter/5, h=platformHeight, $fn=smoothness);
        translate([0, -platformDiameter/3, mastLength])
          cylinder(d=platformDiameter/5, h=platformHeight, $fn=smoothness);
      }
    }
}

module base() {
  difference() {
  	union() {
  		// Base Disc
  		cylinder(d=baseDiskDiameter, h=baseHeight*2, $fn=smoothness);

      // Mounting Flanges
  		baseMountFlanges();

      // Locking cage
      rotate([0,0,135])
        union() {
          //  Back
          translate([-cageWidth/2,pivotSlotWidth/2,baseHeight*2])
            cube([cageWidth, cageThickness, cageHeight]);
          //  Side
          rotate([0,0,90])
            translate([-cageLength/2-cageThickness/2,pivotSlotWidth/2,baseHeight*2])
              difference() {
                cube([cageLength, cageThickness, cageHeight]);
                rotate([0,0,90])
                  translate([0,-cageWidth+mastWidth+partGap,cageSlotVertOffset])
                    cube([cageThickness+.2, cageSlotWidth, cageSlotHeight]);
              }
          //  Side
          rotate([0,0,90])
            translate([-cageLength/2-cageThickness/2,-cageWidth/2,baseHeight*2])
              difference() {
                cube([cageLength, cageThickness, cageHeight]);
                rotate([0,0,90])
                  translate([0,-cageWidth+mastWidth+partGap,cageSlotVertOffset])
                    cube([cageThickness+.2, cageSlotWidth, cageSlotHeight]);
              }
        }
  	}

    //Slot for mast
    rotate([0,0,45])
      translate([-pivotSlotWidth/2, -pivotSlotWidth/2, 0])
        cube([baseDiskDiameter, pivotSlotWidth, baseHeight*2]);

    // Slot for pivot
    rotate([0,0,45])
      translate([0,baseDiskDiameter/2,(pivotSlotDiameter)/2])
        rotate([90,0,0])
          cylinder(d=pivotSlotDiameter, h=baseDiskDiameter, $fn=smoothness);
      rotate([0,0,45])
        translate([-(pivotSlotDiameter)/2,baseDiskDiameter/2,-(pivotSlotDiameter)/2])
          rotate([90,0,0])
            cube([pivotSlotDiameter, pivotSlotDiameter, baseDiskDiameter]);
  }
}

module baseMountFlanges() {
	rotate([0,0,0])
		baseMountFlange();
	rotate([0,0,90])
		baseMountFlange();
	rotate([0,0,180])
		baseMountFlange();
	rotate([0,0,270])
		baseMountFlange();
}

module baseMountFlange() {
		translate([baseDiskDiameter/2-flangeWidth/2, -flangeWidth/2, 0])
			difference() {
				union() {
					cube([flangeLength, flangeWidth, baseHeight]);
					translate([flangeLength,flangeWidth/2,0])
						cylinder(d=flangeWidth, h=baseHeight, $fn=smoothness);
				}
				translate([flangeLength,flangeWidth/2,0])
					cylinder(d=flangeHoleDiameter, h=baseHeight, $fn=smoothness);
			}
}

module prism(l, w, h){
      polyhedron(
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
}
