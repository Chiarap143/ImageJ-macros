//This script filters the amount of Rab10 fluorescence that is in CaMKII domains, and from that, the amount that is also in AT8 positive domains too.
//It answers the question: how much of Rab10 is in neurons and how much of that neuronal Rab10 is in neurons with hyperphosphorylated Tau.

	
	// It creates a folder on your desktop named as the file.
	// The folder will contain: a stack mask of CaMKII and one of AT8, the filtered stacks of Rab10 in each compartment, the respective Sums of slices and a 3D projection in 2 colours (red Rab10/CaMK, green Rab10/AT8)
	// A table (provided as .csv) with measurements for the Z-projected total Rab10, Rab10 in CaMK, in AT8 and in both at the same time allows to calculate the ratios later on.  



// Makes the directory with the name of the file
fullname = File.name
name= File.nameWithoutExtension
File.makeDirectory("/Users/ojerez/Desktop/"+name);  // <-- PUT THE RIGHT ROUTE TO YOUR DESKTOP HERE!

run("Duplicate...", "title=working duplicate");
run("Split Channels");
selectWindow("C1-working");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10.tif");  // <-- UPDATE
run("8-bit");
setMinAndMax(10, 75);   // <-- CHECK the parameters that fit your image best or remove this line.
run("Apply LUT", "stack");

// Creates AT8 mask and segments the Rab10 signal that comes from AT8 domains
selectWindow("C2-working");
run("8-bit");
run("Threshold...");
setAutoThreshold("Yen dark");
waitForUser("Adjust the threshold")
run("Convert to Mask", "method=Yen background=Dark black");
run("Median...", "radius=2 stack");  // <-- You may want to try different filters or radii
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/AT8-mask.tif");  // <-- UPDATE
run("Divide...", "value=255 stack");
imageCalculator("Multiply create stack", "AT8-mask.tif","Rab10.tif");
selectWindow("Result of AT8-mask.tif");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10inAT8.tif");  // <-- UPDATE

// Creates CaMKIIalpha mask and segments the Rab10 signal that comes from CaMKIIalpha domains
selectWindow("C3-working");
run("8-bit");
setAutoThreshold("Yen dark");
waitForUser("Adjust the threshold")
run("Convert to Mask", "method=Yen background=Dark black");
run("Median...", "radius=2 stack");  // <-- You may want to try different filters or radii
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/CaMK-mask.tif");  // <-- UPDATE
run("Divide...", "value=255 stack");
imageCalculator("Multiply create stack", "CaMK-mask.tif","Rab10.tif");
selectWindow("Result of CaMK-mask.tif");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10inCaMK.tif");  // <-- UPDATE

// Amount of Rab10 in CaMKII domains that is also in AT8 positive domains
imageCalculator("Multiply create stack", "AT8-mask.tif","Rab10inCaMK.tif");  // <-- UPDATE
selectWindow("Result of AT8-mask.tif");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10inCaMKandAT8.tif");  // <-- UPDATE

//3D projection of the two components of the Rab10 signal (Red with CaMKIIalpha, Green with AT8)
run("Merge Channels...", "c1=Rab10inCaMK.tif c2=Rab10inAT8.tif create keep ignore");
run("3D Project...", "projection=[Brightest Point] axis=Y-Axis slice=0.5 initial=0 total=360 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/3Dprojection-Rab10s.tif");  // <-- UPDATE

//Measure the Rab10 signal: total, in CaMK domains and in CaMK/AT8 domains, selecting or not the CaMK domains.
run("Set Measurements...", "area mean min integrated display redirect=None decimal=3");

selectWindow("Rab10.tif");
run("Z Project...", "projection=[Sum Slices]");
selectWindow("SUM_Rab10.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/SUM-Rab10.tif");  // <-- UPDATE
run("Measure");
selectWindow("Rab10inCaMK.tif");
run("Z Project...", "projection=[Sum Slices]");
selectWindow("SUM_Rab10inCaMK.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/SUM-Rab10inCaMK.tif");  // <-- UPDATE
run("Measure");
selectWindow("Rab10inAT8.tif");
run("Z Project...", "projection=[Sum Slices]");
selectWindow("SUM_Rab10inAT8.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/SUM-Rab10inAT8.tif");  // <-- UPDATE
run("Measure");
selectWindow("Rab10inCaMKandAT8.tif");
run("Z Project...", "projection=[Sum Slices]");
selectWindow("SUM_Rab10inCaMKandAT8.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/SUM-Rab10inCaMKandAT8.tif");  // <-- UPDATE
run("Measure");

// I thought about using this: making a selection from the masks and measuring the signal from within
// but is not actually useful for my purposes, but it can be useful for someone else. I leave it here anyway.

// selectWindow("CaMK-mask.tif");
// run("Multiply...", "value=255.000 stack");
// run("Z Project...", "projection=[Max Intensity]");
// run("8-bit");
// run("Create Selection");
// run("Make Inverse");
// selectWindow("SUM-Rab10.tif");
// run("Restore Selection");
// run("Measure");



//Save Results table and close everything
saveAs("Results", "/Users/ojerez/Desktop/"+name+"/"+name+".csv")  // <-- UPDATE
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  }


// omlazo 2019 — use, copy and distribute freely.