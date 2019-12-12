Directory containts two Matlab .mat files:
'Results_s2_sl2p_uniform_sobol_prosailD.mat' with Matlab structure 'Results' from SL2PD calibration code to retrieval variables
'ResultsIncertitudes_s2_sl2p_uniform_sobol_prosailD.mat' with Matlab structure 'ResultsIncertitudes' from SL2PD calibration code to retrieval uncertainty of variables

The structures are organized as follows:

Results
  .Input_Convex_Hull - required to apply qualifty flags for SL2PD
  .Input_Definition_Domain - required to apply quality flags using Weiss's approach (very slow)
  .Single - SL2P networks calibrated like SL2P but using UNIFORM pdfs - 
      .D - network to retrieve DASF
   .Plist - vector indicating partitioning levels used to SL2PD (these corresponds to DASF intervals)
   .D - SL2PD networks calibrated for like SL2P but using UNIFORM pdfs for each interval of DASF
      .LAI: [1×1 struct]  - SL2PD networks to retrieve LAI
      .FAPAR: [1×1 struct] - SL2PD networks to retrieve FAPAR
      .FCOVER: [1×1 struct] - SL2PD networks to retrieve FCOVER
      .LAI_Cab: [1×1 struct] - SL2PD networks to retrieve LAI_Cab
      .LAI_Cw: [1×1 struct] - SL2PD networks to retrieve LAI_Cw
      .Albedo: [1×1 struct] - SL2PD networks to retrieve Albedo
      .D: [1×1 struct] - SL2PD networks to retrieve D (a bit unnecessary since we dont actually need D maps as of yet!)
      
ResultsIncertitudes
  .s2_sl2p_uniform_sobol_prosailD - networks to predicts incertitudes based on residuals of the Results networks
     .LAI: [1×1 struct]  - single network calibrated as SL2P does to estimate residuals in LAI 
     .FAPAR: [1×1 struct] - single network calibrated as SL2P does to estimate residuals in FAPAR
     .FCOVER: [1×1 struct] - single network calibrated as SL2P does to estimate residuals in FCOVER 
     .LAI_Cab: [1×1 struct] - single network calibrated as SL2P does to estimate residuals in LAI_Cab 
     .LAI_Cw: [1×1 struct] - single network calibrated as SL2P does to estimate residuals in LAI _Cw
     .Albedo: [1×1 struct] - single network calibrated as SL2P does to estimate residuals in Albedo 
     .D: [1×1 struct] - single network calibrated as SL2P does to estimate residuals in D

I am not sure if Najibs code to apply these networks reformats ResultsIncertitudes to remove the .s2_sl2p_uniform_sobol_prosailD level and just preserve the sub-structures under it.  



 Richard F
     
    
