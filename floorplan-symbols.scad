/**
 * Floorplan Symbols
 *
 * This is a library for drawing a floorplan. This library is accompanied by a libraray of
 * AREI symbols. In combination they can be used to draw electricity schemes for houses.
 *
 * Free to use/copy/distribute.
 *
 * implementer: Stein Heselmans
 */

/** Basic element for a wall
 *
 * @param length Length of the wall
 * @param position Position in the plan: [x,y] coordinates [optional]
 * @param rotation Rotation of the element in degrees [optional]
 */
module wall(length, position, rotation) {
    translate(v=position) rotate(rotation) square(size=[length,1]);
}


/** Basic element for a door
 *
 * @param width Width of the door
 * @param position Position in the plan: [x,y] coordinates [optional]
 * @param rotation Rotation of the element in degrees [optional]
 */
module door(width, position, rotation) {
    thickness = 6;
    translate(v=position) rotate(rotation) translate(v=[0,-thickness/2]) square(size=[width,thickness]);
}

/** Basic element for a staircase
 *
 * @param width Width of the staircase
 * @param length Length of the staircase
 * @param position Position in the plan: [x,y] coordinates [optional]
 * @param rotation Rotation of the element in degrees [optional]
 */
module staircase(width, length, position, rotation) {
    translate(v=position) rotate(rotation-90) union() {
        wall(width);
        wall(width, [0, length]);
        wall(length, [0,0], 90);
        wall(length, [width,0], 90);
        for (i=[1:length/20])
            wall(width, [0, 20*i]);
        wall(length-20, [width/2, 10], 90);
        translate(v=[width/2, length-10]) polygon(points=[[-8,0],[0,8],[8,0]]);
    }
}

/** Basic element for a bath tub
 *
 * @param width Width of the bath tub
 * @param length Length of the bath tub
 * @param position Position in the plan: [x,y] coordinates [optional]
 * @param rotation Rotation of the element in degrees [optional]
 */
module bath(width, length, position, rotation) {
	dimensions = [width, length];
    translate(v=position) rotate(rotation) union() {
        difference() {
            square(size=dimensions);
            translate(v=[1,1]) square(size=dimensions - [2,2]);
		}
		translate(v=dimensions/2) scale([1,length/width]) difference() {
			circle(d=width-5);
			circle(d=width-6);
        }
    }
}

/** Basic element for the name of a room
 *
 * @param name The name of the room
 * @param position Position in the plan: [x,y] coordinates [optional]
 */
module roomname(name, position) {
    translate(v=position) text(name, size=14);
}

