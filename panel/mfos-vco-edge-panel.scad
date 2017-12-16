translate([0,0,3]) rotate([180]) EuroPanel("VCO", 12);

font = ".SF Compact Display:style=Bold";
labelFontSize = 7;

module EuroPanel(label, hp) {

  sideOffset = 6;
  panelWidth = hp*5.08;

  Support();
  
  
  difference() {
    cube([hp*5.08, 128.5, 3]);
      
    translate([2,117,2])  {
        linear_extrude(height=2, convexity=4) text(label, size=8, font=font);
    }
    translate([7.5,3]) MountingHole();
    translate([panelWidth - 7.5, 128.5 - 3]) MountingHole();
    /*
sine 5.27
ramp 16.87
sync 28.6
fm 40.21
cv 52.06
fine 70.19
coarse 90.26    
    */
    
    translate ([panelWidth-sideOffset,15, 0]) scale([-1,1,1]) union() {
        translate([0,90.26,0]) KnobHole16mm();
        translate([0,70.19,0]) KnobHole16mm();
        translate([0,52.06,0]) JackHole();
        translate([22,52.06,0]) JackHole();
        translate([0,40.21,0]) JackHole();
        translate([0,28.6,0]) JackHole();
        translate([0,16.87,0]) JackHole();
        translate([0,5.27,0]) JackHole();
    }
    
    
    translate([34,14,2]) {
        label("freq", 90.26);
        label("fine", 70.19);
    }
    translate([43,14,2]) {
        label("cv", 52.06);
        label("fm", 40.21);
        label("sync", 28.6);
    }
    
    translate([33,14.5,3]) {
      translate([0,5.27]) sineWave();  
      translate([0,16.87]) rampWave();  
    }

    translate ([panelWidth-sideOffset-26,15, 0]) scale([-1,1,1]) union() {
        translate([0,16.87,0]) JackHole();
        translate([0,5.27,0]) JackHole();
    }    

    translate([7,14.5,3]) {
      translate([0,5.27]) triangleWave();  
      translate([0,16.87]) pulseWave();  
    }
    
    translate ([panelWidth-sideOffset-30,15, 0]) scale([-1,1,1]) union() {
        translate([0,43,0]) KnobHole16mm();
        translate([6.5,60,0]) JackHole();
    }
    
    translate([9,60,3]) arrow();

  }
/*
    color("green", .3)
        translate([panelWidth - sideOffset, 14.25,2])
            cube([1,100,50]);
            */
}

module label(text, y){
      translate([0,y])   {
          linear_extrude(height=2.5, convexity=4) text(text, size=labelFontSize, font=font, halign="right");
      }
}

module arrow() {
    
    thickness = .12;
    
    PI = 3.14159265359;
    steps = 32;
    step = 360 / steps;
    
    $fn = 16;

    scale([7,7,2]) {
        hull(){
            translate([.5,2.3])
            printPoint(thickness);
            translate([.5,-2.7])
            printPoint(thickness);
        }
        hull(){
            translate([0,-2.2])
            printPoint(thickness);
            translate([.5,-2.7])
            printPoint(thickness);
        }
        hull(){
            translate([1,-2.2])
            printPoint(thickness);
            translate([.5,-2.7])
            printPoint(thickness);
        }
    }
 }

module sineWave() {
    
    thickness = .12;
    
    PI = 3.14159265359;
    steps = 32;
    step = 360 / steps;
    
    $fn = 16;

    scale([7,7,2]) {
        for (i = [0 : 1 : steps-1]) {
            hull(){
            translate([i/steps, .5*sin(i*step)])
            printPoint(thickness);
            translate([(i+1)/steps, .5*sin((i+1)*step)])
            printPoint(thickness);
            }
        }
    }
 }


module rampWave() {
    
    thickness = .12;
    
    PI = 3.14159265359;
    steps = 32;
    step = 360 / steps;
    
    $fn = 16;

    scale([7,7,2]) {
        hull(){
            translate([0,-.5])
            printPoint(thickness);
            translate([1,.5])
            printPoint(thickness);
        }
        hull(){
            translate([1,.5])
            printPoint(thickness);
            translate([1,-.5])
            printPoint(thickness);
        }
    }
 }


module triangleWave() {
    
    thickness = .12;
    
    PI = 3.14159265359;
    steps = 32;
    step = 360 / steps;
    
    $fn = 16;

    scale([7,7,2]) {
        hull(){
            translate([0,0])
            printPoint(thickness);
            translate([.25,.5])
            printPoint(thickness);
        }
        hull(){
            translate([.25,.5])
            printPoint(thickness);
            translate([.75,-.5])
            printPoint(thickness);
        }
        hull(){
            translate([.75,-.5])
            printPoint(thickness);
            translate([1,0])
            printPoint(thickness);
        }
    }
}



module pulseWave() {
    
    thickness = .12;
    
    PI = 3.14159265359;
    steps = 32;
    step = 360 / steps;
    
    $fn = 16;

    scale([7,7,2]) {
        hull(){
            translate([0,-.5])
            printPoint(thickness);
            translate([.5,-.5])
            printPoint(thickness);
        }
        hull(){
            translate([.5,-.5])
            printPoint(thickness);
            translate([.5,.5])
            printPoint(thickness);
        }
        hull(){
            translate([.5,.5])
            printPoint(thickness);
            translate([1,.5])
            printPoint(thickness);
        }
    }
}


module printPoint(r) {
    cylinder(h = 1, r1 = r, r2 = r, center = true);
}


module KnobHole16mm() { translate([12.5,0,-.5]) cylinder(h=4, d=8, $fn=12); }
module KnobHole9mm() { translate([6.4,0,-.5]) cylinder(h=4, d=8, $fn=12); }

module JackHole() { translate([6,0,-.5]) cylinder(h=4, d=6.5, $fn=12); }

module LEDHole() { translate([10,0,-.5]) cylinder(h=4, d=5.3, $fn=12); }

module MIDIHole() { translate([10.5,0,-.5]) cylinder(h=4, d=18.5, $fn=24); }

module Support() {
    translate([0,10,0])
    rotate([-90,0,0])
  linear_extrude(108.5)
    polygon([[0,0], [0,2], [1.5,5], [3,5], [3,0]]);
}


module MountingHole() {
  hull() {
    translate([-2,0,-.5]) cylinder(h=5, r=1.6, $fn=12);
    translate([2,0,-.5]) cylinder(h=5, r=1.6, $fn=12);
  }
}

echo(version=version());
