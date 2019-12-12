Contains Matlab structure output from SL2PD calibration code.
The structure is organized as follows:

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
      
Richard F.
    
