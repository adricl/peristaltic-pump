use <library/Utils.scad>
include <library/macd/stepper.scad>

$fn =100;
//Bearing Dimensions

bearingHeight = 10;
bearingInner = 3;
bearingOusideDiameter = 7;

//Pipe Details
pipeWidth = 10;
//pipeWallThickness = .5;
crushDepth = 8; //Amount of depth to crush pipe

//pipeHolder Diameter
diameter = 100;

//Sheet Width 
width = 3;

//////////////////// Do not touch ////

//triangleSideSize = diameter - 2 * (pipeWidth - crushDepth) - bearingInner;
bearingCenterToHolder = bearingOusideDiameter/2 + (pipeWidth - crushDepth);
outerToTrianglePoint = diameter/2 - bearingCenterToHolder;
triangleSideSize = outerToTrianglePoint* sqrt(3);
triangleHeight = (sqrt(3)/2) * triangleSideSize;
centerX = (triangleSideSize + triangleSideSize/2)/3;
centerY = triangleHeight/3;

bearingWidthShaftHolder = (bearingOusideDiameter - 
                (bearingOusideDiameter-bearingInner)/4 )/2;

echo("bearingCenterToHolder", outerToTrianglePoint);
echo("Tri size", triangleSideSize);


//projection(cut = true) 
difference() {
    union() {
        center();
        outsideMount();
    }
    move(x=-centerX, y=centerY, z=-10, rx=180)  motor(Nema17, NemaMedium, dualAxis=true);
    //move(x=100, y=NemaMedium*100, z= 0)  motor(Nema14, NemaMedium, dualAxis=true);
}
module center(){
    union(){
        difference(){
            equiTriangle(triangleSideSize, width);
            cylinder(r=bearingWidthShaftHolder, h=width+1, center=true);

            move(x=-triangleSideSize)
                cylinder(r=bearingWidthShaftHolder ,h=width+1, 
                    center=true);

            move(x=-triangleSideSize/2, y=triangleHeight)
            cylinder(r=bearingWidthShaftHolder ,h=width+1, 
                center=true);

        }
        bearingMount();
        move(x=-triangleSideSize) bearingMount();
        move(x=-triangleSideSize/2, y=triangleHeight) bearingMount();
    }
    
}

module bearingMount(){
    difference() {
        cylinder(r=bearingWidthShaftHolder , h=width, center=true);
        cylinder(r=bearingInner/2, h=width+2, center=true);
    }
}

module outsideMount(){
    move(x=-centerX ,y=centerY)
    difference() {
        cylinder(r=diameter/2 + 4, h=width, center=true);
        cylinder(r=diameter/2, h=width+1, center=true);
        move(x=diameter/4,y=-diameter/4,z=-width/2-1)
            cube([diameter/2,diameter/2, width+2]);
    }
    
}
