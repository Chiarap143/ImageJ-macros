//This script filters the amount of Rab10 fluorescence that is in CaMKII domains, and from that, the amount that is also in AT8 positive domains too.
//It answers the question: how much of Rab10 is in neurons and how much of that neuronal Rab10 is in neurons with hyperphosphorylated Tau.

	
	// It creates a folder on your desktop named as the file.
	// The folder will contain: a stack mask of CaMKII and one of AT8, the filtered stacks of Rab10 in each compartment, the respective Max and 3D projection in 2 colours (red Rab10/CaMK, green Rab10/AT8)
	// A table (provided as .csv) with measurements for the Z-projected total Rab10, Rab10 in CaMK, in AT8 and in both at the same time allows to calculate the ratios later on.  



// Makes the directory with the name of the file and makes sure about the default options
fullname = File.name
name= File.nameWithoutExtension
File.makeDirectory("/Users/ojerez/Desktop/"+name);  // <-- PUT THE RIGHT ROUTE TO YOUR DESKTOP HERE!
run("Set Measurements...", "area mean min integrated display redirect=None decimal=3");
run("Colors...", "foreground=white background=black selection=yellow");
run("Options...", "iterations=1 count=1 black");
run("Misc...", "divide=NaN");

run("Duplicate...", "title=working duplicate");
run("Split Channels");
selectWindow("C1-working");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10.tif");  // <-- UPDATE
run("8-bit");
run("Duplicate...", "title=Rab10mask duplicate");
selectWindow("Rab10.tif");
setMinAndMax(10, 75);   // <-- CHECK the parameters that fit your image best or remove this line.
run("Apply LUT", "stack");
run("Median...", "radius=0.5 stack");
run("Subtract Background...", "rolling=50 stack");

// Create a mask of the Rab10-stained areas of the tissue (in case the tissue has different area because of holes or different shape, etc) and segment the Rab10 withing the mask
selectWindow("Rab10mask");
setMinAndMax(2, 15);   // <-- CHECK the parameters that fit your image best.
run("Apply LUT", "stack");
run("Median...", "radius=5 stack");
setThreshold(1, 255);
run("Convert to Mask", "method=Default background=Dark black");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10mask.tif");
run("Divide...", "value=255 stack");
imageCalculator("Divide create 32-bit stack", "Rab10.tif","Rab10mask.tif");
selectWindow("Result of Rab10.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10filtered.tif");

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
imageCalculator("Divide create 32-bit stack", "Rab10filtered.tif", "AT8-mask.tif");
selectWindow("Result of Rab10filtered.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10inAT8.tif");  // <-- UPDATE

// Creates CaMKIIalpha mask and segments the Rab10 signal that comes from CaMKIIalpha domains
selectWindow("C3-working");
run("8-bit");
run("Threshold...");
setAutoThreshold("Yen dark");
waitForUser("Adjust the threshold")
run("Convert to Mask", "method=Yen background=Dark black");
run("Median...", "radius=2 stack");  // <-- You may want to try different filters or radii
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/CaMK-mask.tif");  // <-- UPDATE
run("Divide...", "value=255 stack");
imageCalculator("Divide create 32-bit stack", "Rab10filtered.tif", "CaMK-mask.tif");
selectWindow("Result of Rab10filtered.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10inCaMK.tif");  // <-- UPDATE

// Amount of Rab10 in CaMKII domains that is also in AT8 positive domains
imageCalculator("Divide create 32-bit stack", "Rab10filtered.tif", "AT8-mask.tif");  // <-- UPDATE
selectWindow("Result of Rab10filtered.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/Rab10inCaMKandAT8.tif");  // <-- UPDATE

// 3D projection of the two components of the Rab10 signal (Red with CaMKIIalpha, Green with AT8)
run("Merge Channels...", "c1=Rab10inCaMK.tif c2=Rab10inAT8.tif create keep ignore");
run("3D Project...", "projection=[Brightest Point] axis=Y-Axis slice=0.5 initial=0 total=360 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/3Dprojection-Rab10s.tif");  // <-- UPDATE

// Measure the Rab10 signal: total, in CaMK domains and in CaMK/AT8 domains, selecting or not the CaMK domains.
selectWindow("Rab10filtered.tif");
run("Z Project...", "projection=[Average Intensity]");
selectWindow("AVG_Rab10filtered.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/AVG-Rab10.tif");  // <-- UPDATE
run("Measure");
selectWindow("Rab10inCaMK.tif");
run("Z Project...", "projection=[Average Intensity]");
selectWindow("AVG_Rab10inCaMK.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/AVG-Rab10inCaMK.tif");  // <-- UPDATE
run("Measure");
selectWindow("Rab10inAT8.tif");
run("Z Project...", "projection=[Average Intensity]");
selectWindow("AVG_Rab10inAT8.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/AVG-Rab10inAT8.tif");  // <-- UPDATE
run("Measure");
selectWindow("Rab10inCaMKandAT8.tif");
run("Z Project...", "projection=[Average Intensity]");
selectWindow("AVG_Rab10inCaMKandAT8.tif");
run("8-bit");
saveAs("Tiff", "/Users/ojerez/Desktop/"+name+"/AVG-Rab10inCaMKandAT8.tif");  // <-- UPDATE
run("Measure");


// Save Results table and close everything
saveAs("Results", "/Users/ojerez/Desktop/"+name+"/"+name+".csv")  // <-- UPDATE
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  }

// I thought that this way of making a selection would be useful, but I came across a better solution. I will leave it here just in case I need it again later.
//makeRectangle(2, 2, 1023, 1023);
//setBackgroundColor(0, 0, 0);
//run("Clear Outside");
//run("Select None");
//run("Create Selection");
//run("Make Inverse");




// omlazo 2019 — use, copy and distribute freely.