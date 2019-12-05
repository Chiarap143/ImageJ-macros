fullname = File.name;
name= File.nameWithoutExtension;
File.makeDirectory("/Users/ojerez/Desktop/"+name);
timepoints= getNumber("How many timepoints do you have?", 5);
run("Set Measurements...", "area mean min display redirect=None decimal=3");

run("Estimate Drift", "time=1 max=10 reference=[previous frame (better for live)] choose=[/Users/ojerez/Desktop/"+name+".njt]");
run("Correct Drift", "load=[/Users/ojerez/Desktop/"+name+"DriftTable.njt]");
run("8-bit");
run("royal ");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/"+name+"-corrected.tif");
run("Duplicate...", "duplicate");
run("Z Project...", "projection=[Max Intensity]");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/"+name+"-projection.tif");
setTool("polyline");


state = getBoolean("Are you going to trace a neuron?");
while (state==1) {
run("Measure");
cyclenumber= nResults;
selectWindow(name+"-projection.tif");

waitForUser("Draw a line along the main axis of the neuron, from the basal side to the beginning of the apical dendrite");

selectWindow(name+"-corrected.tif");
run("Restore Selection");
run("Multi Kymograph", "linewidth=1");
run("8-bit");
run("royal ");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
setTool("rectangle");
makeRectangle(4, 0, 50, timepoints);

waitForUser("Identify nuclear region");

run("Duplicate...", "title=nucleus");
run("Size...", "width=1 height="+timepoints+" depth=1 average interpolation=Bilinear");
run("royal ");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
saveAs("Jpeg", "/Users/ojerez/Desktop/"+name+"/"+name+"-nucleus"+cyclenumber+".jpg");
saveAs("Text Image", "/Users/ojerez/Desktop/"+name+"/"+name+"-nucleus"+cyclenumber+".txt");
selectWindow("Kymograph");
makeRectangle(75, 0, 50, timepoints);

waitForUser("Identify cytoplasmic region");

run("Duplicate...", "title=cytoplasm");
run("Size...", "width=1 height="+timepoints+" depth=1 average interpolation=Bilinear");
run("royal ");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
saveAs("Jpeg", "/Users/ojerez/Desktop/"+name+"/"+name+"-cytoplasm"+cyclenumber+".jpg");
saveAs("Text Image", "/Users/ojerez/Desktop/"+name+"/"+name+"-cytoplasm"+cyclenumber+".txt");
setTool("polyline");
selectWindow(name+"-corrected.tif");
close("nucleus");
close("cytoplasm");
close("Kymograph");
state = getBoolean("Are you going to trace another neuron?");
	}
if (state==0) {

close("Results");
close("*");
File.delete("/Users/ojerez/Desktop/"+name+"DriftTable.njt");
close("Log"); 
}