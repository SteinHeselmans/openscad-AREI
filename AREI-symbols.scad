/**
 * AREI Symbols
 *
 * This is a library for the AREI symbols coded in the openscad language. Modules for the most
 * common set of symbols in AREI are provided.
 *
 * Free to use/copy/distribute.
 *
 * implementer: Stein Heselmans
 */

t_switch = [-6,0]; //extra translation for switches to start in the same location as sockets

/** Header for the electricity schematics
 *
 * @param Name of the owners
 * @address1 Address line 1 of the house
 * @address2 Address line 2 of the house
 * @param position Position in the schema: [x,y] coordinates [optional]
 */
module header(name, address1, address2, position=[0,0]) {
    translate(v=position) union() {
        text(name);
        translate(v=[0,-20]) text(address1);
        translate(v=[0,-40]) text(address2);
    }
}

/** Basic element for a circle
 *
 * @param r Radius of the circle
 */
module arei_circle(r) {
    difference() {
        circle(r=r);
        circle(r=r-1);
    }
}

/** Basic element for a square
 *
 * @param r size of the square
 */
module arei_square(r) {
    difference() {
        square(size=r);
        translate(v=[1,1]) square(size=r-2);
    }
}

/** Simple switch symbol
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param indicator Boolean flag for indicator light on the switch [optional]
 */
module switch_simple(name, position=[0,0], indicator=false) {
    translate(v=position+t_switch) union() {
        arei_circle(5);
        translate(v=[3,3]) rotate(45) square(size=[10,1]);
        translate(v=[-14,6]) text(name);
        if (indicator == true) {
            translate(v=[-3,-3]) rotate(45) square(size=[9,1]);
            translate(v=[-3.5,3]) rotate(-45) square(size=[9,1]);
        }
    }
}

/** Single pole switch symbol
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param indicator Boolean flag for indicator light on the switch [optional]
 */
module switch_singlepole(name, position=[0,0], indicator=false) {
    translate(v=position+t_switch) union() {
        switch_simple(name, -t_switch, indicator);
        translate(v=[9,10]) rotate(-45) square(size=[5,1]);
    }
}

/** Push button symbol
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 */
module pushbutton(name, position=[0,0]) {
    translate(v=position+[-4,0]) union() {
        arei_circle(5);
        arei_circle(1);
        translate(v=[-14,6]) text(name);
    }
}

/** Double pole switch symbol
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param indicator Boolean flag for indicator light on the switch [optional]
 */
module switch_doublepole(name, position=[0,0], indicator=false) {
    translate(v=position+t_switch) union() {
        switch_singlepole(name, -t_switch, indicator);
        translate(v=[7,8]) rotate(-45) square(size=[5,1]);
    }
}

/** Three way switch symbol (dutch: wisselschakelaar)
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param indicator Boolean flag for indicator light on the switch [optional]
 */
module switch_three_way(name, position=[0,0], indicator) {
    translate(v=position+t_switch) union() {
        switch_singlepole(name, -t_switch, indicator);
        translate(v=[-10,-10]) rotate(45) square(size=[10,1]);
        translate(v=[-14,-7]) rotate(-45) square(size=[5,1]);
    }
}

/** Four way switch symbol (dutch: kruisschakelaar)
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param indicator Boolean flag for indicator light on the switch [optional]
 */
module switch_four_way(name, position=[0,0], indicator) {
    translate(v=position+t_switch) union() {
        switch_three_way(name, -t_switch, indicator);
        translate(v=[-3,3]) rotate(135) square(size=[10,1]);
        translate(v=[-10,10]) rotate(-135) square(size=[5,1]);
        translate(v=[3,-3]) rotate(-45) square(size=[10,1]);
        translate(v=[10,-10]) rotate(45) square(size=[5,1]);
    }
}

/** Basic element for half a circle
 *
 * @note Can be used to draw the symbol for a socket
 * @param radius Radius of the circle
 */
module circle_half(radius) {
    difference()  {
       circle(r=radius);
       translate(v=[0,-radius]) square(size=[radius,2*radius]);
    }
}

/** Boiler symbol
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 */
module boiler(name, position=[0,0]) {
    translate(v=position) union() {
        arei_circle(10);
        translate(v=[-6,-8]) square(size=[1,16]);
        translate(v=[-0.5,-10]) square(size=[1,20]);
        translate(v=[5,-8]) square(size=[1,16]);
        translate(v=[10,0]) text(name);
    }
}

/** Socket symbol
 *
 * @param name Name of the element in the netlist
 * @param amount Amount of sockets in this place [optional]
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param rotation Rotation of the element 0, 90, 180 or 270 degrees [optional]
 */
module socket(name, amount=1, position=[0,0], rotation=0) {
    translate(v=position) union() {
        rotate([0,0,rotation]) union() {
            difference() {
                circle_half(9);
                circle_half(8);
            }
            //child security
            translate(v=[0,8]) square(size=[1,3]);
            translate(v=[0,-11]) square(size=[1,3]);
            //grounding
            translate(v=[-9,-9]) square(size=[1,18]);
            //connection
            translate(v=[-12,0]) square(size=[3,1]);
            if (amount !=1) {
                translate(v=[-5,-12]) rotate(60) square(size=[8,1]);
                translate(v=[-11,-16]) rotate([0,0,-rotation]) text(str(amount), size=6, valign="center", halign="center");
            }
        }
        if ((rotation == 0) || (rotation == undef)) {
            translate(v=[1,-4]) text(name);
        }
        else if (rotation == 90) {
            translate(v=[-12,2]) text(name);
        }
        else if (rotation == 180) {
            translate(v=[-17,-4]) text(name);
        }
        else if (rotation == -90) {
            translate(v=[-8,-12]) text(name);
        }
    }
}

/** Television connection symbol
 *
 * @param position Position in the schema: [x,y] coordinates [optional]
 */
module television(position=[0,0]) {
    translate(v=position) text("TV");
}

/** Internet connection symbol
 *
 * @param position Position in the schema: [x,y] coordinates [optional]
 */
module internet(position=[0,0]) {
    translate(v=position) text("INT");
}

/** Light symbol
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param wallmount If wall mounten, the angle at which it is mounted to the wall: 0, 90, 180 or 270 degrees [optional]
 */
module light(name, position=[0,0], wallmount=false) {
    translate(v=position) translate(v=[0,1]) union() {
        translate(v=[-8,-9]) rotate(45) square(size=[24,1]);
        translate(v=[-9,8]) rotate(-45) square(size=[24,1]);
        translate(v=[-15,-16]) text(name);
        if(wallmount != false) {
            rotate(wallmount) translate(v=[10,-11]) square(size=[1,22]);
        }
    }
}

/** Light tube symbol
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param rotation Rotation of the element 0 or 90 degrees [optional]
 */
module lighttube(name, position=[0,0], rotation=0) {
    translate(v=position+[29,0]) union() {
        rotate([0,0,rotation]) union() {
            translate(v=[-30,0]) square(size=[60,1]);
            translate(v=[-30,-4]) square(size=[1,8]);
            translate(v=[30,-4]) square(size=[1,8]);
        }
        translate(v=[2,2]) text(name);
    }
}

/** Bell/horn symbol
 *
 * @param name Name of the element in the netlist
 * @param position Position in the schema: [x,y] coordinates [optional]
 */
module bell(name, position=[0,0]) {
    translate(v=position+[0,-6]) union() {
        arei_square(12);
        translate(v=[12,8]) polygon(points=[[0,0],[20,5], [16,-5], [0, -2]]);
        translate(v=[3,14]) text(name);
    }
}

/** Connection wire
 *
 * @param length Length of the wire
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param rotation Rotation of the element in 90 degrees, default horizontal [optional]
 */
module wire(length, position=[0,0], rotation=0) {
    translate(v=position) rotate([0,0,rotation]) square(size=[length,1]);
}

/** Transformator symbol
 *
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param rotation Rotation of the element in degrees [optional]
 */
module trafo(position=[0,0], rotation=0) {
    translate(v=position) rotate([0,0,rotation]) union() {
        translate(v=[-5,0]) arei_circle(5);
        translate(v=[1,0]) arei_circle(5);
    }
}

/** Fuse symbol
 *
 * @param current Current at which the fuse breaks the circuit
 * @param position Position in the schema: [x,y] coordinates [optional]
 * @param residualcurrent The residual current at which the fuse breaks the circuit [optional]
 */
module fuse(current, position=[0,0], residualcurrent=false) {
    translate(v=position) union() {
        wire(4,[0,-3],90);
        rotate(30) union() {
            square(size=[1,10]);
            translate(v=[-3,10]) square(size=[4,6]);
        }
        translate(v=[-3,3]) rotate(30) square(size=[3,1]);
        translate(v=[-4,5]) rotate(30) square(size=[3,1]);
        wire(4,[0,15],90);
        translate(v=[4,3]) text(current);
        if (residualcurrent != false) {
            translate(v=[4,16]) text(residualcurrent);
        }
    }
}

/** Basic element for drawing a power line on a board
 *
 * This draws a fuse, with a cable and some wires to connect elements to
 * @param name Name of the power line (usually a letter)
 * @param current Current at which the fuse of the power line breaks
 * @param cable Cable type used for this power line
 * @param connection Number of connections on this power line
 */
module line_board(name, current, cable, connections) {
    union() {
        wire(30, [0,0], 90);
        translate(v=[3,7]) text(name);
        fuse(current, [0, 33]);
        wire(81+connections*30, [0,50], 90);
        translate(v=[-4,60]) rotate(90) text(cable, size=8);
        for (i=[1:connections]) {
            wire(20, [0,130+30*i]);
            translate(v=[4,135+30*i]) text(str(i), size=8);
        }
    }
}

/** Basic element for earth connection on a board
 *
 * @note For convenience, the symbol is drawn downwords from the given position, so the given
 * position should be the bottom of your power board.
 * @param position Position in the schema: [x,y] coordinates [optional]
 */
module earthconnection(position=[0,0]) {
    translate(v=position) rotate(180) union() {
        wire(20, [0,0], 90);

        wire(10, [-5,20]);
        wire(10, [-5,25]);

        wire(20, [0,25], 90);

        wire(10, [-5,45]);
        wire(10, [-5,50]);

        wire(20, [0,50], 90);

        wire(20, [-10,70]);
        wire(12, [-6,75]);
        wire( 4, [-2,80]);
    }
}

/** Basic element for a board
 *
 * @param length The length of the board
 * @param position Position in the schema: [x,y] coordinates [optional]
 */
module board(length, position=[0,0]) {
    h = 15;
    l = length + 2 * h;
    translate(v=position) translate(v=[-h,-h]) union() {
        difference() {
            square(size=[l, h]);
            translate(v=[1,1]) square(size=[l-2, h-2]);
        }
        earthconnection([3*h,0]);
        fuse("40A", [length/2, -70], "300mA");
        wire(60, [length/2,-60], 90);
        wire(30, [length/2,-100], 90);
    }
}

