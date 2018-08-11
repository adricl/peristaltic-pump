use <library/Utils.scad>

$fn =100;
//Bearing Dimensions

bearingHeight = 10;
bearingInner = 3;
bearingOusideDiameter = 7;

//Pipe Details
pipeWidth = 10;
//pipeWallThickness = .5;

//center
crushDepth = 8;

//pipeHolder Diameter
diameter = 60;

//Sheet Width 
width = 3;

//////////////////// Do not touch ////
triangleSideSize = diameter - 2 * (pipeWidth - crushDepth) - bearingInner;
triangleHeight = (sqrt(3)/2) * triangleSideSize;
centerX = (triangleSideSize + triangleSideSize/2)/3;
centerY = triangleHeight/3;

bearingWidthShaftHolder = (bearingOusideDiameter - 
                (bearingOusideDiameter-bearingInner)/4 )/2;


echo("Tri size", triangleSideSize);
center();
outsideMount();

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
        cylinder(r=diameter/2 + 3, h=width, center=true);
        cylinder(r=diameter/2, h=width+1, center=true);
    }
    
}
