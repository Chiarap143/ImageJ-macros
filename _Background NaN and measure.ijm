/// Let's make the background is NaN and measure the intensity of any channel
fullname = File.name
run("Set Measurements...", "area mean min display redirect=None decimal=3");
run("Z Project...", "projection=[Max Intensity]");
run("Split Channels");
waitForUser("Select the channel and press OK");
run("Duplicate...", "title=Mask-"+fullname);
run("32-bit");
run("Threshold...");
waitForUser("Set the threshold and press OK");
run("NaN Background");
run("Duplicate...", "title=Mask"+fullname);
close("C1-MAX_"+fullname)
close("C2-MAX_"+fullname)
close("C3-MAX_"+fullname)
close("C4-MAX_"+fullname)
selectWindow("Mask-"+fullname);
run("Measure");
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  }