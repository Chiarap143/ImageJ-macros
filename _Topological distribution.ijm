// 	— This macro creates a table .txt 
// 	  with the topological distribution of the signal 
// 	  along the ortogonal axis to an axon.



// Do a Z maxima projection of your axonal segment,
// reserve that projection and do a inverted mask of its shape,

run("Z Project...", "projection=[Max Intensity]");
run("Duplicate...", " ");
setAutoThreshold("Default dark");
run("Threshold...");
setThreshold(1, 255);
setOption("BlackBackground", true);
run("Convert to Mask");
waitForUser("Everything OK so far?")
run("Invert");

// Trace the main axis of the axon,
// restore the selection in the maxima projection image and straighten it

setTool("polyline");
waitForUser("Trace the axis, restore selection on the max projection and press OK")
run("Straighten...", "line=20");

// Crop the upper and lower relevant limits, 
// rescale the image height to a binning of 10
// and finally store the map as a TXT table of intensities and close everything.

setTool("rectangle");
makeRectangle(0, 0, 500, 10);
waitForUser("Select the relevant segment using rectangular selection and press OK")
run("Crop");
run("8-bit");
run("Rotate 90 Degrees Right");
run("Size...", "width=10 height=500 constrain average interpolation=Bilinear");
run("Rotate 90 Degrees Left");
saveAs("Text Image");
close;
close;
close;
close;


// by omlazo 2018 — use, copy and share freely.
