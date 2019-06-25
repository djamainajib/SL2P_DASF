SL2P_DASF
----------
----------

This is a modified SL2P processor [1] version for estimating leaf area index (LAI), fraction canopy cover (FCOVER), fraction of absorbed photosynthetically active radiation (FAPAR), canopy chlorophyll content (CCC) and canopy water content (CWC)from Sentinel-2A/B L2A images. Directional Area Scattering Function (DASF) was considered for constraining estimates. 
This code geneares also (1) uncertainties of the estimated vegetation biophysical variables and (2) flags for input (surface refelctance) /output data (vegetation biophysical variables).   
 

Content:
--------
- README.md: the actual document.
- SL2P_DASF_v_03.m : the main code.
- tools: containing aux_data and auxlilary code pieces.
- aux_data: containg (1) the trained NNET used for simulating DASF and vegetation biophysical variables from S2-MSI data,(2) the trained NNET used for estimating the incertainty of vegetation biophysical variables retrievals, (3) the convex hull used to compute input_out_of_range flag, and (4) BIO_VAR_bounding_box.mat used to compute outputs flags. 

Inputs:
-------
- surface reflectance data (S2L2A product) for bands: B3, B4, B5, B6, B7, B8A, B11 and B12.
- view_zenith_mean map
- sun_zenith map
- view_azimuth_mean map
- sun_azimuth map 
+ aux_data

Samples of input data are available in: https://drive.google.com/drive/folders/1iO0L4uTkF0vOy0VFM0ZDgd6vpfzbwv7y

Input maps should be provided in separalte .tiff files at 20m spatial resolution (please see the provided samples).

Outputs:
--------
- lai, fcover, fapar, lai_cw (CCC), lai_cab(CCC) maps. 
- lai_flags, fcover_flags, fapar_flags, lai_cw_flags, lai_cab_flags, maps.  
- lai_uncertainties, fcover_uncertainties, fapar_uncertainties, lai_cw_uncertainties, lai_cab_uncertainties maps. 

Outputs are generated in .tif and .mat files

Example:
--------
SL2P_DASF_v_03 (['.\Samples_S2L2A_data\'], 'S2A_MSIL2A_20171026T110131_N0206_R094_T30SWJ_20171026T144303')


References:
-----------
[1] Weiss, M.; Baret, F. S2ToolBox level 2 products, version 1.1. 2016. [https://step.esa.int/docs/extra/ATBD_S2ToolBox_L2B_V1.1.pdf].
 

 

