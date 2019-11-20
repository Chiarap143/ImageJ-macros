

fullname = File.name
name= File.nameWithoutExtension
run("Set Measurements...", "area mean min display redirect=None decimal=3");

run("Split Channels");
selectWindow("C1-"+fullname);
run("Z Project...", "projection=[Standard Deviation]");
run("8-bit");
run("Duplicate...", "title=MAP2");
run("Brightness/Contrast...");
waitForUser("Adjust levels to see nucleus");
run("Apply LUT");
selectWindow("C2-"+fullname);
run("Z Project...", "projection=[Max Intensity]");
run("8-bit");
run("Duplicate...", "title=Tubulin");
run("Brightness/Contrast...");
waitForUser("Adjust levels to see axons");
run("Apply LUT");

selectWindow("C3-"+fullname);
run("Z Project...", "projection=[Max Intensity]");
run("8-bit");
run("Duplicate...", "title=Erk");
run("Brightness/Contrast...");

close("C1-"+fullname);
close("C2-"+fullname);
run("Merge Channels...", "c1=MAP2 c2=Tubulin create ignore");



state = getBoolean("Ready to trace a neuron?");
while (state==1) {
selectWindow("Composite");
setTool("freehand");
waitForUser("Trace the soma");
selectWindow("Erk");
run("Restore Selection");
run("Measure");
selectWindow("Composite");
setTool("freehand");
waitForUser("Trace the nucleus");
selectWindow("Erk");
run("Restore Selection");
run("Measure");
selectWindow("Composite");
setTool("polyline");
waitForUser("Trace an axon close to that soma, length = soma");
run("Line to Area");
selectWindow("Erk");
run("Restore Selection");
run("Measure");
selectWindow("Composite");
setTool("polyline");
waitForUser("Trace another axon close to that soma, length = soma");
run("Line to Area");
selectWindow("Erk");
run("Restore Selection");
run("Measure");
state = getBoolean("Are you going to trace another neuron?");
	}
if (state==0) {
saveAs("Results", "/Users/ojerez/Desktop/"+name+".csv");
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  }} 


// omlazo and Amy Hicks 2019 — use, copy and distribute freely.