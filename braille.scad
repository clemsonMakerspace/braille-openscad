include <braillechars.scad>; // see braillechars.scad for list of supported characters

string = [
	[CAP,h,e,l,l,o,COMMA,_,w,o,r,l,d,BANG],
	[CAP,h,e,l,l,o,BANG],
	[CAP,w,o,r,l,d,BANG]
	[h,e,l,l,o,_,w,o,r,l,d],
];

// CHIP READ THIS
// is3D determines whether or not this will be 3D or 2D.
// Set it to true to make the braille STLs
// Set it to false to make the braille SVGs

// File > Export > Export as SVG
// check the sizing of a dot base in Illustrator - I think it will be ~3 times too small

is3D = false;

dotheight = 3.0;//.48;
dotdiameter = 1.44;
dotspacing = 2.34;
cellspacing = 6.2;
margin = 3.5;
linetoline = 10;

module braillechar(letter = w, $fs = .2, $fa = .2) {
	for(i = [0:5]) {
        if((floor(letter / pow(2, i)) % 2)) {
            translate([floor(i / 3) * dotspacing, (i % 3) * -dotspacing, 0])
                scale([1, 1, 2 * dotheight/dotdiameter])
                    if(is3D) {
                        sphere(d = dotdiameter);
                    } else {
                        circle(d = dotdiameter);
                    }
        }
    }
}

module braillestr(string) {
	for(i = [0:100]) translate([i * cellspacing, 0, 0]) braillechar(string[i]);
}


for(i = [0:len(string) - 1]) {
    translate(
        [
            margin, 
            dotspacing * 2 + margin + (len(string) - i - 1) * linetoline,
            0
        ]
    )
    braillestr(string[i]);
}

if(is3D) {
    translate([0, 0, -5]) difference() {
        cube(
                [
                    dotspacing + cellspacing * (max([for(i = [0:len(string) - 1]) len(string[i])]) - 1) + margin * 2,
                    dotspacing * 2 + margin * 2 + linetoline * (len(string) - 1), 5
                ]
        );
        
        translate([0, margin + dotspacing * 2 + linetoline * (len(string) - 1), -1])
            rotate(45)
                cube([margin * sqrt(2), margin, 7]);
    }
}
