// 	— This macro creates a table .txt 
// 	  with the topological distribution of the signal 
// 	  along the ortogonal axis to an axon.

// Do a Z maxima projection of your axonal segment,
// and separate the channels to get the one you want.

run("Duplicate...", "");
run("Split Channels");
waitForUser("Close the channels you don't need, select the one you are going to measure and then press OK")
run("8-bit");
run("Grays");
run("Save", "save=/Users/ojerez/Desktop/working_image.tif");

// Trace the main axis of the axon or recover previous tracing,
// restore the selection in the maxima projection image and straighten it

setTool("polyline");
waitForUser("Trace the axis of the axon if you haven't done yet and press OK")
selectWindow("working_image.tif");
run("Restore Selection");
run("Straighten...", "line=20");

// Crop the upper and lower relevant limits if needed, 
// rescale the image height to a binning of 10
// and finally store the map as a TXT table of intensities and close everything.

setTool("rectangle");
makeRectangle(0, 0, 50, 5);
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


// by omlazo 2018 — use, copy and distribute freely.
