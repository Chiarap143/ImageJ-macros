// 		Answers the question: What proportion of total retro-TrkB organelles (as an area) are Rab10 positive?
//		This macro takes a 3-channel z-stack,
//		selects a neurite and first determine the TrkB signal that is in HcT positive fields (retro_TrkB),
//		then select the retro_TrkB that is in Rab10-positive fields and measure total and Rab10-correlated.

fullname = File.name
name= File.nameWithoutExtension

setOption("DebugMode", true);
setOption("BlackBackground", true);
Stack.setDisplayMode("composite");
run("Set Measurements...", "area mean min integrated display redirect=None decimal=3");
run("Colors...", "foreground=white background=black selection=yellow");
run("Options...", "iterations=1 count=1 black");
run("Misc...", "divide=NaN");

run("Z Project...", "projection=[Max Intensity]");
run("RGB Color");
run("Duplicate...", "title=reference");
selectWindow("MAX_"+fullname);
run("Close");
selectWindow("MAX_"+fullname+" (RGB)");
run("Close");
run("Brightness/Contrast...");
waitForUser("Maximise the brightness to visualize the axon");


// 


state = getBoolean("Do you have an axon to trace?");
while (state==1) {
selectWindow("reference");
setTool("polyline");
waitForUser("Trace an axon and adjust the thickness of the line to cover it completely");
run("Line to Area");
selectWindow(fullname);
run("Restore Selection");
run("Duplicate...", "title=subframe duplicate");
selectWindow("subframe");
run("Clear Outside", "stack");
run("Split Channels");

selectWindow("C1-subframe");				//REPLACE IF TRKB IS NOT IN THE CHANNEL 1
run("8-bit");
run("Threshold...");
run("In [+]");
run("In [+]");
waitForUser("Adjust the threshold");
selectWindow("C1-subframe");
run("Convert to Mask", "method=Default background=Dark black");
run("Duplicate...", "title=TrkB duplicate");
selectWindow("C1-subframe");
run("Close");

selectWindow("C3-subframe");			//REPLACE IF HcT IS NOT IN THE CHANNEL 3
run("8-bit");
run("Threshold...");
run("In [+]");
run("In [+]");
waitForUser("Adjust the threshold");
selectWindow("C3-subframe");
run("Convert to Mask", "method=Default background=Dark black");
run("Duplicate...", "title=HcT duplicate");
selectWindow("C3-subframe");
run("Close");

// Here we create the submask for TrkB/HcT double positive area
selectWindow("HcT");
run("Divide...", "value=255 stack");
selectWindow("TrkB");
run("Divide...", "value=255 stack");
imageCalculator("Multiply create stack", "TrkB","HcT");
selectWindow("Result of TrkB");
run("Multiply...", "value=255 stack");
run("Duplicate...", "title=retro_TrkB duplicate");
selectWindow("Result of TrkB");
run("Close");
selectWindow("HcT");
run("Close");
selectWindow("TrkB");
run("Close");

selectWindow("C2-subframe");			//REPLACE IF Rab10 IS NOT IN THE CHANNEL 2
run("8-bit");
run("Threshold...");
run("In [+]");
run("In [+]");
waitForUser("Adjust the threshold");
selectWindow("C2-subframe");
run("Convert to Mask", "method=Default background=Dark black");
run("Duplicate...", "title=Rab10 duplicate");
selectWindow("C2-subframe");
run("Close");


run("Merge Channels...", "c1=retro_TrkB c2=Rab10 create keep ignore");
saveAs("Tiff");

// Mask selecting the pixels in retro-TrkB that are in Rab10 positive locations
selectWindow("retro_TrkB");
run("Divide...", "value=255 stack");
selectWindow("Rab10");
run("Divide...", "value=255 stack");
imageCalculator("Multiply create stack", "retro_TrkB","Rab10");
selectWindow("Result of retro_TrkB");
run("Duplicate...", "title=retro_TrkBonRab10 duplicate");
run("Multiply...", "value=255 stack");
selectWindow("Result of retro_TrkB");
close();
selectWindow("Rab10");
close();
selectWindow("retro_TrkB");
run("Multiply...", "value=255 stack");

// Max projection and quantification
selectWindow("retro_TrkB");
    run("Z Project...", "projection=[Max Intensity]");
    run("Measure");
    selectWindow("MAX_retro_TrkB");
    close();
    selectWindow("retro_TrkB");
    close();
selectWindow("retro_TrkBonRab10");
    run("Z Project...", "projection=[Max Intensity]");
    run("Measure");
    selectWindow("MAX_retro_TrkBonRab10");
    close();
    selectWindow("retro_TrkBonRab10");
    close();
state = getBoolean("Do you want to trace another axon?");
	}
if (state==0) {
saveAs("Results", "/Users/ojerez/Desktop/"+name+".csv");
close("*");


// by omlazo 2020 — use, copy and distribute freely.
