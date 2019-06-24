// Segments TrkB and Rab5 organelles, establish the limits of the confined domain and then measure their co-localisation within those boundaries by using Confined Displacement Algorithm.


// MAKING THE COMPARTMENT MASK

//setTool("rectangle");
waitForUser("Select the region you want to analyse and then press ok")
run("Duplicate...", "duplicate");
run("Split Channels");
waitForUser("Select the EGFP channel")
run("In [+]");
run("In [+]");
run("8-bit");
run("Threshold...");
waitForUser("Adjust the threshold")
run("Out [-]");
run("Out [-]");
run("Convert to Mask", "method=Default background=Dark black");
run("Median...", "radius=1 stack");
run("Save", "save=/Users/ojerez/Desktop/compartment.tif");
run("Duplicate...", "duplicate");
run("Divide...", "value=255 stack");
run("Save", "save=/Users/ojerez/Desktop/mask.tif");
selectWindow("Threshold");
run("Close");

// SEGMENTING THE CARGO CHANNEL

waitForUser("Select the TrkB channel")
run("8-bit");
run("Save", "save=/Users/ojerez/Desktop/TrkB.tif")
imageCalculator("Multiply create stack", "TrkB.tif","mask.tif");
run("Save", "save=/Users/ojerez/Desktop/TrkB.tif")
run("Duplicate...", "duplicate");
run("In [+]");
run("In [+]");
run("Threshold...");
waitForUser("Adjust the threshold")
run("Out [-]");
run("Out [-]");
run("Convert to Mask", "method=Default background=Dark black");
run("Save", "save=/Users/ojerez/Desktop/TrkB-mask.tif");
selectWindow("Threshold");
run("Close");

// SEGMENTING THE COMPARTMENT CHANNEL

waitForUser("Select the Rab5 channel")
run("8-bit");
run("Save", "save=/Users/ojerez/Desktop/Rab5.tif")
imageCalculator("Multiply create stack", "Rab5.tif","mask.tif");
run("Save", "save=/Users/ojerez/Desktop/Rab5.tif")
run("Duplicate...", "duplicate");
run("In [+]");
run("In [+]");
run("Threshold...");
waitForUser("Adjust the threshold")
run("Out [-]");
run("Out [-]");
run("Convert to Mask", "method=Default background=Dark black");
run("Save", "save=/Users/ojerez/Desktop/Rab5-mask.tif");
selectWindow("Threshold");
run("Close");

// RUNNING CDA

run("CDA (macro)", "channel_1=TrkB.tif channel_2=Rab5.tif roi_for_channel_1=[Use as mask] roi_for_channel_1_image=TrkB-mask.tif roi_for_channel_2=[Use as mask] roi_for_channel_2_image=Rab5-mask.tif confined_compartment=[Use as mask] confined_compartment_image=compartment.tif include_rois maximum=12 random=7 compute_sub-random_samples bins=16 set_results_options show_merged_channel show_merged_roi show_m1_statistics show_m2_statistics results_directory=/var/folders/w7/rkt13bdx0bx_12ghmlqq6tkdhz2b84/T/ p-value=0.05 permutations=200");waitForUser("Take note of the results")

// END

selectWindow("CDA Merged channel");
run("Close");
selectWindow("CDA Merged ROI");
run("Close");
selectWindow("CDA M1  PDF");
run("Close");
selectWindow("CDA M2  PDF");
run("Close");
selectWindow("CDA Plugin Results");
run("Close");
selectWindow("TrkB.tif");
run("Close");
selectWindow("Rab5.tif");
run("Close");
selectWindow("TrkB-mask.tif");
run("Close");
selectWindow("Rab5-mask.tif");
run("Close");
selectWindow("mask.tif");
run("Close");
selectWindow("compartment.tif");
run("Close");
selectWindow("TrkB.tif");
run("Close");
selectWindow("Rab5.tif");
run("Close");

selectWindow("B&C");
run("Close");


// by omlazo 2019 — use, copy and distribute freely.