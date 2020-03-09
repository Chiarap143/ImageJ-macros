
fullname = File.name
name= File.nameWithoutExtension
setOption("DebugMode", true);
setOption("BlackBackground", true);
Stack.setDisplayMode("composite");
run("Set Measurements...", "area mean min integrated display redirect=None decimal=4");
run("Colors...", "foreground=white background=black selection=yellow");
run("Options...", "iterations=1 count=1 black");
run("Misc...", "divide=NaN");

run("Z Project...", "projection=[Max Intensity]");
run("Duplicate...", "title=reference");
run("RGB Color");
selectWindow("MAX_"+fullname);
run("Split Channels");

setTool("freehand");

state = getBoolean("Ready to trace a neuron?");
while (state==1) {
selectWindow("C3-MAX_"+fullname);
waitForUser("Trace the nucleus");
selectWindow("C2-MAX_"+fullname);
run("Duplicate...", "title=pCREB");
run("8-bit");
run("Restore Selection");
run("Measure");
selectWindow("C1-MAX_"+fullname);
run("Restore Selection");
run("Clear", "slice");
selectWindow("reference");
run("Restore Selection");
waitForUser("Trace the soma");
selectWindow("C1-MAX_"+fullname);
run("Duplicate...", "title=Rab10");
run("8-bit");
run("Restore Selection");
run("Measure");
close("Rab10");
close("pCREB");
selectWindow("reference");
state = getBoolean("Are you going to trace another neuron?");
	}
if (state==0) {
saveAs("Results", "~/Desktop/"+name+".csv");
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  }} 


// omlazo 2020 — use, copy and distribute freely.
