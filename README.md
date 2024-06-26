Project directory: All scripts should be run in the same base directory containing raw data. 
Dependencies: This base directory must contain:
1) a /frames/ directory, containing the raw movies output from the camera
2) a /stacks/ directory which contains .mdoc metadata files for each tilt series
3) a gain reference in .dm4 format (gain reference name is not critical but .dm4 format is)
4) a cryodirective.adoc file
5) a metadata-tomo.yaml file which specifies topaz_model and motCorr_bin options
*The base directory is allowed to contain other files, such as atlases, medium mag montages, or other individual images. No other .dm4 files besides the gain may be in this base directory (if some present, move to a new subdirectory to prevent issues)

Script Running Order:
1) motionCorr.bash
2) topazDenoise.bash
3) Restack_SerialEM.bash
4) IMOD_Auto.bash
*If the cryodirective.adoc file is already expected to be accurate for the dataset, only the allProcess.bash script needs to be run (it will call each script sequentially)
**allProcessDenoise.bash executes scripts 1-4 in order
