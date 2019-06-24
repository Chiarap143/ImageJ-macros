// 		Answers the question: What proportion of total retro-TrkB is in Rab10 positive compartments?
//		This macro takes a 3-channel z-stack,
//		selects a neurite and first determine the TrkB signal that is in HcT positive fields (retro_TrkB),
//		then select the retro_TrkB that is in Rab10-positive fields and measure total and Rab10-correlated.

// If the axon is not visible, go to _preliminars.ijm
// You select the ROI, it makes the lin an area and clears outside, makes masks of HcT and TrkB.

setTool("polyline");
waitForUser("Trace the axon and adjust the thickness of the line to cover it completely")
run("Line to Area");
run("Clear Outside", "stack");
run("Split Channels");
waitForUser("Select the HcT channel")
run("8-bit");
run("Threshold...");
waitForUser("Adjust the threshold")
run("Convert to Mask", "method=Default background=Dark black");
run("Save", "save=/Users/ojerez/Desktop/HcT.tif");
selectWindow("Threshold");
run("Close");
waitForUser("Select the TrkB channel")
run("8-bit");
run("Threshold...");
waitForUser("Adjust the threshold")
run("Convert to Mask", "method=Default background=Dark black");
run("Save", "save=/Users/ojerez/Desktop/TrkB.tif");
selectWindow("Threshold");
run("Close");

// It uses multiplication of images to select the pixels that are simultaneously positive for TrkB and HcT

selectWindow("HcT.tif");
run("Divide...", "value=255 stack");
selectWindow("TrkB.tif");
run("Divide...", "value=255 stack");
imageCalculator("Multiply create stack", "TrkB.tif","HcT.tif");
selectWindow("Result of TrkB.tif");
run("Multiply...", "value=255 stack");
run("Save", "save=/Users/ojerez/Desktop/retro_TrkB.tif");
selectWindow("HcT.tif");
close();
selectWindow("TrkB.tif");
close();

// It creates a mask for Rab10 signal and makes a composite of Rab10 (green) and retro-TrkB (red) masks. 

waitForUser("Select the Rab10 channel")
run("8-bit");
run("Threshold...");
waitForUser("Adjust the threshold")
run("Convert to Mask", "method=Default background=Dark black");
run("Save", "save=/Users/ojerez/Desktop/Rab10.tif");
selectWindow("Threshold");
run("Close");
run("Merge Channels...", "c1=retro_TrkB.tif c2=Rab10.tif create keep ignore");
run("Save", "save=/Users/ojerez/Desktop/retroTrkBinRab10.tif");

// It uses multiplication of image to select the pixels in retro-TrkB that are in Rab10 positive locations

selectWindow("retro_TrkB.tif");
run("Divide...", "value=255 stack");
selectWindow("Rab10.tif");
run("Divide...", "value=255 stack");
imageCalculator("Multiply create stack", "retro_TrkB.tif","Rab10.tif");  // The window 'Result of retro_TrkB.tif' was created.
selectWindow("Rab10.tif");
close();

// It quantifies retro_TrkB and its proportion in Rab10 fields (a.k.a Result of retro_TrkB) 
// and closes everything but the composite of retro_TrkB and Rab10 and the active table of measurements.

selectWindow("retro_TrkB.tif");
    run("Multiply...", "value=255 stack");
    run("Z Project...", "projection=[Max Intensity]");
    run("Measure");
    selectWindow("MAX_retro_TrkB.tif");
    close();
    selectWindow("retro_TrkB.tif");
    close();
selectWindow("Result of retro_TrkB.tif");
    run("Multiply...", "value=255 stack");
    run("Z Project...", "projection=[Max Intensity]");
    run("Measure");
    selectWindow("MAX_Result of retro_TrkB.tif");
    close();
    selectWindow("Result of retro_TrkB.tif");
    close();
saveAs("Results", "/Users/ojerez/Desktop/retro-TrkB total vs Rab10.xls");

waitForUser("Take a look to the composite. Is it ok?")
run("Close");









// by omlazo 2018 — use, copy and distribute freely.
