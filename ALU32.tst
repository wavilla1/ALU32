load ALU32.hdl;
output-file ALU32.out;
output-list 
x2%B16.16.1 x1%B16.16.1 
y2%B16.16.1 y1%B16.16.1 
zx%B1.1.1 nx%B1.1.1 zy%B1.1.1 ny%B1.1.1 f%B1.1.1 no%B1.1.1 
out2%B16.16.1 out1%B16.16.1 
zr%B1.1.1 ng%B1.1.1 overflow%B1.1.1;


// Caso 1: 1 + 1
set x2 %B0000000000000000;
set x1 %B0000000000000001;
set y2 %B0000000000000000;
set y1 %B0000000000000001;

set zx 0; set nx 0; set zy 0; set ny 0; set f 1; set no 0;
eval;
output;


// Caso 2: 1 + (-1)
set x2 %B0000000000000000;
set x1 %B0000000000000001;
set y2 %B0000000000000000;
set y1 %B0000000000000001;

set zx 0; set nx 0; set zy 0; set ny 1; set f 1; set no 0;
eval;
output;


// Caso 3: AND
set x2 %B1111000011110000;
set x1 %B1111000011110000;
set y2 %B1010101010101010;
set y1 %B1010101010101010;

set zx 0; set nx 0; set zy 0; set ny 0; set f 0; set no 0;
eval;
output;


// Caso 4: salida cero
set x2 %B1010101010101010;
set x1 %B1010101010101010;
set y2 %B0101010101010101;
set y1 %B0101010101010101;

set zx 1; set nx 0; set zy 1; set ny 0; set f 1; set no 0;
eval;
output;


// Caso 5: negación final
set x2 %B0000000000000000;
set x1 %B0000000000000001;
set y2 %B0000000000000000;
set y1 %B0000000000000001;

set zx 0; set nx 0; set zy 0; set ny 0; set f 1; set no 1;
eval;
output;


