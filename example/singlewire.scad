include <../AREI-symbols.scad>;

rotate(90) color("black") union() {

    amps_for_sockets = "20A";
    amps_for_lights  = "16A";
    cable_for_sockets = "3G2.5mm²";
    cable_for_lights  = "3G1.5mm²";
    dx = 50; //horizontal distance unit between lines
    dy = 30; //vertical distance unit between lines
    sx = 30; //horizontal distance left of a switch
    lx = 24; //horizontal distance left of a light
    wsx = -2; //horizontal distance left of a wire going to switch
    x_init = 30; //x-position of first element on line
    y_init = 160; //y-position of first element on line
    wire_s2s = 22; //length of wire between switch and switch
    wire_s2l = 25; //length of wire between switch and light
    wire_l2l = 24; //length of wire between light and light

    header("Owner name(s)", "street number", "postal code - City", [230, -30]);

    translate(v=[0*dx,0]) union() {
        line_board("A", amps_for_sockets, cable_for_sockets, 4);
        socket("", 1, [x_init, y_init+0*dy]);
        socket("", 2, [x_init, y_init+1*dy]);
        socket("", 1, [x_init, y_init+2*dy]);
        socket("", 1, [x_init, y_init+3*dy]);
    }

    translate(v=[1*dx,0]) union() {
        line_board("B", amps_for_sockets, cable_for_sockets, 6);
        socket("", 1, [x_init, y_init+0*dy]);
        socket("", 1, [x_init, y_init+1*dy]);
        socket("", 1, [x_init, y_init+2*dy]);
        socket("", 1, [x_init, y_init+3*dy]);
        socket("", 1, [x_init, y_init+4*dy]);
        socket("", 1, [x_init, y_init+5*dy]);
    }

    translate(v=[2*dx,0]) union() {
        line_board("C", amps_for_lights, cable_for_lights, 3);
        switch_three_way("", [x_init, y_init]);
        wire(wire_s2s, [x_init+wsx, y_init]);
        switch_three_way("", [x_init+sx, y_init]);
        wire(wire_s2l+wire_l2l, [x_init+sx+wsx, y_init]);
        light("", [x_init+sx+1*lx,y_init]);
        light("", [x_init+sx+2*lx,y_init]);

        switch_doublepole("", [x_init, y_init+1*dy]);
        wire(wire_s2l, [x_init+wsx, y_init+1*dy]);
        light("", [x_init+lx,y_init+1*dy]);

        switch_three_way("", [x_init, y_init+2*dy]);
        wire(wire_s2s, [x_init+wsx, y_init+2*dy]);
        switch_four_way("", [x_init+sx, y_init+2*dy]);
        wire(wire_s2s, [x_init+sx+wsx, y_init+2*dy]);
        switch_three_way("", [x_init+2*sx, y_init+2*dy]);
        wire(wire_s2l, [x_init+2*sx+wsx, y_init+2*dy]);
        light("", [x_init+2*sx+lx,y_init+2*dy]);
    }

    //'wet' lines
    translate(v=[6*dx,100]) union() {

        translate(v=[0*dx,0]) union() {
            line_board("D", amps_for_sockets, cable_for_sockets, 4);
            socket("", 1, [x_init, y_init+0*dy]);
            socket("", 1, [x_init, y_init+1*dy]);
            socket("", 1, [x_init, y_init+2*dy]);
            
            switch_doublepole("", [x_init, y_init+3*dy]);
            wire(wire_s2l, [x_init+wsx, y_init+3*dy]);
            light("", [x_init+lx,y_init+3*dy]);
        }

        wire(60, [-30,0]);

        fuse("40A", [dx/2, -70], "30mA");
        wire(60, [dx/2,-60], 90);
        wire(30, [dx/2,-100], 90);
    }

    //the main board with fuse and grounding
    board(7*dx);
}

