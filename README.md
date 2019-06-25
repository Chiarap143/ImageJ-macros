# ImageJ-macros
Humble and customised macros for things I do using ImageJ/FIJI. Most of them have been written in modules to be remixed, combined and recycled. Feel free to do exactly that.
You can put them in the folder /FIJI/plugins/macros/ to be visible from the Macros menu (the _ at the beginning of the file name is required to appear in the menu).
Advice in how to make them better is always welcome and much appreciated.

### Retrograde Accumulation 
It guides you through the process of tracing the soma of the neuron of interest based on the EGFP channel (or equivalent marker) and then quantifies the intensity of the maximum projection in other 2 channels (in my case TrkB and CTB, for example). It gives you a file, with the same name of the reference image, containing the size of the ROI and the mean intensity for each channel.

### retroTrkB in Rab10 domains
Answers the question: What proportion of total retro-TrkB is in Rab10 positive compartments?
This macro takes a 3-channel z-stack, selects a neurite and first determine the TrkB signal that is in HcT positive fields (retro_TrkB), then select the retro_TrkB that is in Rab10-positive fields and measure total and Rab10-correlated. Don't close the results table, because every time you run the macro, the table file is overwritten (if you keep the "Results" window open, this will result in the file being updated). If the axon is not visible in the EGFP channel, run "Preliminars" first (it just makes a projection and offer you to change the brightness and contrast to make the tracing possible).

### Segmentation and CDA
Segments organelles (based for example in TrkB and Rab5 signals) and establishes the borders of the confined domain (a subcellular compartment, axons, dendrites, etc.). Then it measures co-localisation within those boundaries by using Confined Displacement Algorithm. You need GDSC plugins to implement CDA (http://www.sussex.ac.uk/gdsc/intranet/microscopy/UserSupport/AnalysisProtocol/imagej/gdsc_plugins/).

### Topological distributions
The idea here is to be able to manipulate and analyse the data about topological distribution of the signal within the axon along the ortogonal axis. Is like doing a transect, but instead you will have as many transects as pixel lines your image has. The macro straightens, delimitates and then gives you a table .txt with the intensity value of every pixel.

***
