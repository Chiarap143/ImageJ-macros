// Segments TrkB and Rab5 organelles, establish the limits of the confined domain and then measure their co-localisation within those boundaries by using Confined Displacement Algorithm.

// Before using this Macro, Find and Replace.. "/Users/oscarmarcelo/Desktop/" by the appropriate path to your desktop or preferred folder.
// GDSC plugins package is needed for this macro to work. Can be downloaded here: http://www.sussex.ac.uk/gdsc/intranet/microscopy/UserSupport/AnalysisProtocol/imagej/gdsc_plugins/

setOption("DebugMode", true);
setOption("BlackBackground", true);
Stack.setDisplayMode("composite");
run("Set Measurements...", "area mean min integrated display redirect=None decimal=4");
run("Colors...", "foreground=white background=black selection=yellow");
run("Options...", "iterations=1 count=1 black");
run("Misc...", "divide=NaN");

// MAKING THE COMPARTMENT MASK

setTool("rectangle");
waitForUser("Select the region you want to analyse and then press ok");
run("Duplicate...", "title=ROI duplicate");
run("Split Channels");
selectWindow("C2-ROI");
//waitForUser("Select the EGFP channel");
run("In [+]");
run("In [+]");
run("8-bit");
run("Threshold...");
waitForUser("Adjust the threshold");
run("Convert to Mask", "method=Default background=Default black");
run("Median...", "radius=1 stack");
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/compartment");
run("Duplicate...", "title=mask duplicate");
run("Divide...", "value=255 stack");
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/mask");


// SEGMENTING THE CARGO CHANNEL

//waitForUser("Select the TrkB channel");
selectWindow("C3-ROI");
run("8-bit");
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/TrkB");
imageCalculator("Multiply create stack", "TrkB.tif","mask.tif");
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/TrkB");
selectWindow("TrkB.tif");
run("Close");
selectWindow("TrkB.tif");
run("Close");
open("C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/TrkB.tif");
run("Duplicate...", "title=TrkB-mask duplicate");
run("In [+]");
run("In [+]");
run("Threshold...");
waitForUser("Adjust the threshold")
run("Convert to Mask", "method=Default background=Default black");
run("Out [-]");
run("Out [-]");
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/TrkB-mask.tif");
selectWindow("Threshold");
run("Close");

// SEGMENTING THE COMPARTMENT CHANNEL

//waitForUser("Select the Rab5 channel");
selectWindow("C1-ROI");
run("8-bit");
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/Rab5.tif");
imageCalculator("Multiply create stack", "Rab5.tif","mask.tif");
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/Rab5.tif")
selectWindow("Rab5.tif");
run("Close");
selectWindow("Rab5.tif");
run("Close");
open("C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/Rab5.tif");
run("Duplicate...", "title=Rab5-mask duplicate");
run("In [+]");
run("In [+]");
run("Threshold...");
waitForUser("Adjust the threshold");
run("Convert to Mask", "method=Default background=Default black");
run("Out [-]");
run("Out [-]");
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Analysed image_Fiji-segmentation and CDA/Rab5-mask.tif");
selectWindow("Threshold");
run("Close");

// RUNNING CDA


run("CDA (macro)", "channel_1=TrkB.tif channel_2=Rab5.tif roi_for_channel_1=[Use as mask] roi_for_channel_1_image=TrkB-mask.tif roi_for_channel_2=[Use as mask] roi_for_channel_2_image=Rab5-mask.tif confined_compartment=[Use as mask] confined_compartment_image=compartment.tif include_rois maximum=12 random=7 compute_sub-random_samples bins=16 set_results_options show_merged_channel show_merged_roi show_m1_statistics show_m2_statistics results_directory=[C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Oscar/Results CDA] p-value=0.05 permutations=200");
waitForUser("Take note of the results");


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

// by omlazo 2019 — use, copy and distribute freely.
