SL2P_DASF:
----------
----------

This is a modified SL2P processor [1] version for estimating leaf area index (LAI), fraction canopy cover (FCOVER), fraction of absorbed photosynthetically active radiation (FAPAR), canopy chlorophyll content (CCC) and canopy water content (CWC)from Sentinel-2A/B L2A images. Directional Area Scattering Function (DASF)was considered.

Content:
--------
- README.md: the actual document.
- SL2P_DASF_v_01.m : the main code.
- tools: containg the trained NNET used for simulating DASF and vegetation biophysical variables from S2 data as well as other auxilary code pieces.
- Samples_S2L2A_data : providing an example of input datasets.

Inputs:
-------
- surface reflectance data (S2L2A product) for bands: B3,B4,B5,B6,B7,B8A, B11, B12.
- view_zenith_mean map
- sun_zenith map
- view_azimuth_mean map
- sun_azimuth map 

Input maps should be provided in separalte .tiff files at 20m spatial resolution (see Samples_S2L2A_data).

Outputs:
--------
- LAI,FCOVER,FAPAR,LAI_Cw (CCC), LAI_Cab (CCC) maps.  

Example:
--------
SL2P_DASF_v_01(['.\Samples_S2L2A_data\'],'S2A_MSIL2A_20171026T110131_N0206_R094_T30SWJ_20171026T144303')


References:
-----------
[1] Weiss, M.; Baret, F. S2ToolBox level 2 products, version 1.1. 2016. [step.esa.int/docs/extra/ATBD_S2ToolBox_L2B_V1.1.pdf].
 

 

