	// Script to quantify retrograde accumulation of TrkB and compare to other labelling, in this particular case, retrograde transport of CTB.
	// As a result it creates a .csv file with the same name of the image file, containing the area size and mean intensity in both channels.

fullname = File.name
name= File.nameWithoutExtension


run("Set Measurements...", "area mean min display redirect=None decimal=3");
run("Z Project...", "projection=[Max Intensity]");
run("Split Channels");
selectWindow("C2-MAX_"+fullname);
run("8-bit");
setTool("freehand");

state = getBoolean("Are you going to trace a neuron?");
while (state==1) {
selectWindow("C2-MAX_"+fullname);
run("In [+]");
run("In [+]");
waitForUser("Trace the soma");
selectWindow("C1-MAX_"+fullname);
run("Duplicate...", "title=TrkB");
run("8-bit");
run("Restore Selection");
run("Measure");
selectWindow("C3-MAX_"+fullname);
run("Duplicate...", "title=Rab10");
run("8-bit");
run("Restore Selection");
run("Measure");
close("TrkB");
close("Rab10");
selectWindow("C2-MAX_"+fullname);
run("Out [-]");
run("Out [-]");
state = getBoolean("Are you going to trace a neuron?");
	}
if (state==0) {
saveAs("Results", "/Users/ojerez/Desktop/"+name+".csv");
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  }} 


// omlazo 2019 — use, copy and distribute freely.