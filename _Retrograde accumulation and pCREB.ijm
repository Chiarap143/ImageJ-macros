

fullname = File.name
name= File.nameWithoutExtension


run("Set Measurements...", "area mean min display redirect=None decimal=3");
run("Z Project...", "projection=[Max Intensity]");
run("Split Channels");
selectWindow("C1-MAX_"+fullname);
run("Duplicate...", "title=Red");
selectWindow("C2-MAX_"+fullname);
run("Duplicate...", "title=Green");
selectWindow("C3-MAX_"+fullname);
run("Duplicate...", "title=Blue");
selectWindow("C4-MAX_"+fullname);
run("Duplicate...", "title=Cyan");
run("Merge Channels...", "c1=Red c2=Green c3=Blue c4=Cyan create ignore");
setTool("freehand");

state = getBoolean("Ready to trace a neuron?");
while (state==1) {
selectWindow("Composite");
waitForUser("Trace the soma");
selectWindow("C3-MAX_"+fullname);
run("Duplicate...", "title=Rab10");
run("8-bit");
run("Restore Selection");
run("Measure");
selectWindow("C4-MAX_"+fullname);
run("Restore Selection");
waitForUser("Trace the nucleus");
selectWindow("C2-MAX_"+fullname);
run("Duplicate...", "title=pCREB");
run("8-bit");
run("Restore Selection");
run("Measure");
close("Rab10");
close("pCREB");
selectWindow("Composite");
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


// omlazo 2019 — use, copy and distribute freely.