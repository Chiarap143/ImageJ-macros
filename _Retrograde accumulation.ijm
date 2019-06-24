	// Script to quantify retrograde accumulation of TrkB and compare to other labelling, in this particular case, retrograde transport of CTB.
	// As a result it creates a .csv file with the same name of the image file, containing the area size and mean intensity in both channels.

fullname = File.name
name= File.nameWithoutExtension

run("Set Measurements...", "area mean min display redirect=None decimal=3");
run("Z Project...", "projection=[Max Intensity]");
run("Split Channels");
selectWindow("C2-MAX_"+fullname);
run("In [+]");
run("In [+]");
run("8-bit");
setTool("freehand");
waitForUser("Trace the soma")
selectWindow("C1-MAX_"+fullname);
run("Duplicate...", "title=TrkB");
close("C1-MAX_"+fullname)
run("8-bit");
run("Restore Selection");
run("Measure")
selectWindow("C3-MAX_"+fullname);
run("Duplicate...", "title=CTB");
close("C3-MAX_"+fullname)
run("8-bit");
run("Restore Selection");
run("Measure")
saveAs("Results", "/Users/ojerez/Desktop/"+name+".csv");
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  } 


// omlazo 2019 — use, copy and distribute freely.