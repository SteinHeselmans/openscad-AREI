include <../AREI-symbols.scad>;
include <../floorplan-symbols.scad>;

color("black") union() {
    header("Owner name(s)", "street number", "postal code - City", [20, -30]);

    //outside walls
    wall(650);
    wall(750, [0,0], 90);
    wall(750, [650,0], 90);
    wall(650, [0,750]);

    //inside walls
    wall(650, [0,450], 0);
    wall(350, [200,0], 90);
    wall(300, [200,450], 90);
    wall(100, [200,350], 0);
    wall(100, [300,350], 90);

    //outside doors
    door(80, [100,0]);

    //inside doors
    door(80, [210,350]);
    door(80, [210,450]);
    door(80, [110,450]);

    //stairs
    staircase(90, 240, [0, 90], 90);

    //bath tub
    bath(90, 200, [0,450]);

    //sockets A-kring
    socket("A1", 1, [220,  20], 90);
    socket("A2", 2, [30,  20], 90);
    socket("A3", 1, [180, 330], 180);
    socket("A4", 1, [295, 330], -90);

    //sockets B-kring
    socket("B1", 1, [220, 730]);
    socket("B2", 1, [330, 470], 90);
    socket("B3", 1, [630, 730], 180);
    socket("B4", 1, [630, 470], 180);
    socket("B5", 1, [630, 320], 180);
    socket("B6", 1, [630, 100], 180);

    //sockets D-kring
    socket("D1", 1, [180, 660], 180);
    socket("D2", 1, [180, 550], 180);
    socket("D3", 1, [180, 600], 180);

    //light bath room
    switch_singlepole("D4", [180,470]);
    light("D4", [150, 600]);

    //light gang
    switch_three_way("C1", [100,20]);
    switch_three_way("C1", [280,410]);
    light("C1", [80, 70]);
    light("C1", [150, 400]);

    //light room 2
    switch_singlepole("C2", [300,470]);
    light("C2", [430, 600]);

    //light room 1
    switch_three_way("C3", [280,380]);
    switch_four_way("C3", [635,280]);
    switch_three_way("C3", [635,130]);
    light("C3", [420, 225]);

    //television and internet connections
    television([240,10]);
    television([210,700]);
    internet([210,680]);

    roomname("ENTRANCE", [120,240]);
    roomname("BATHROOM", [30,700]);
    roomname("ROOM 1", [350,100]);
    roomname("ROOM 2", [350,650]);

}

