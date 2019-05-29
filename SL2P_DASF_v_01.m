function SL2P_DASF(varargin)

%% 1. Initialization
if ~ismember(nargin,[2,3]), disp({'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!';'--usage : Matlab SL2P_MSI [input_path\] [S2 tiff data folder] [output_path\ (optional)]'});return; end;
file_name=dir([varargin{1},varargin{2},'\S2*B3.tif']);
file_name=file_name(1).name(1:end-6);
addpath(genpath('.\tools'));
%% 2. Loading data........................................................
disp({'===============',file_name,'==============='});
disp({'--Loading data--------------------------------------'});
Input_NNT=[]; 
h = waitbar(0,'Loading data...');
for bb={'B3','B4','B5','B6','B7','B8A','B11','B12','view_zenith_mean','sun_zenith','view_azimuth_mean','sun_azimuth'}
    waitbar(size(Input_NNT,2)/11)
    file_name_band=[file_name,char(bb),'.tif'];
    [band,xb,yb,Ib] = geoimread([varargin{1},varargin{2},'\',file_name_band]);
    [r,c]=size(band);
    Input_NNT= [Input_NNT,double(reshape(band,r*c,1))]; 
end;
close(h)

%% 2.1 Adding image cordinates
Input_NNT=[reshape((1:r)'*ones(1,c),r*c,1),reshape(ones(1,r)'*(1:c),r*c,1),Input_NNT];

%% 2.1 Organizing input data for NNET (NNET_IN)
Input_NNT(:,end-1)=abs(Input_NNT(:,end-1)-Input_NNT(:,end));Input_NNT(:,end)=[];
Input_NNT(:,3:end-3)=Input_NNT(:,3:end-3)/10000;
Input_NNT(:,end-2:end)=cos(deg2rad(Input_NNT(:,end-2:end))); 
NNT_IN=Input_NNT(:,3:end)';
%% 3. Loading NET
disp({'--Loading NNET--------------------------------------'});
NET=importdata('tools\aux_data\S2_SL2P_large_trunc_u_D_NET.mat');
ivars=fieldnames(NET);
%% 4. Simulating DASF
disp({'--Simulating DASF--------------------------------------'});
h = waitbar(0,'Simulating ...');
NNT_IN_P=mapminmax('apply',NNT_IN,NET.D.Norm_Input);
D=mapminmax('reverse',sim(NET.D.NET,NNT_IN_P),NET.D.Norm_Output);
%% 5. Simulating biophysical parameters.....................................
disp({'--Simulating vegetation biophysical variables ----------------------------------------'});
NNT_OUT=[];

for d = 1:length(NET.Dlist);  
    waitbar(d/length(NET.Dlist))
    dindex = find((D>(NET.Dlist(d)+NET.Dlist(max(1,d-1)))/2)&(D<=(NET.Dlist(d)+NET.Dlist(min(length(NET.Dlist),d+1)))/2));
    NNT_IN_D = NNT_IN(:,dindex);  
    for bio={'LAI','FCOVER','FAPAR','LAI_Cab','LAI_Cw'}
        if ~isfield(NNT_OUT, char(bio)),
            eval(['NNT_OUT.',char(bio),'= [Input_NNT(:,1:2),NaN+Input_NNT(:,1)];']);
        end;
        eval(['NET_D= NET.',char(bio),'.NETS(',num2str(d),').NET;']);
        eval(['ps= NET.',char(bio),'.NETS(',num2str(d),').Norm_Input;']);
        eval(['ts= NET.',char(bio),'.NETS(',num2str(d),').Norm_Output;']);

        NNT_IN_D_P=mapminmax('apply',NNT_IN_D,ps);
        eval(['NNT_OUT.',char(bio),'([',num2str(dindex),'],3)= mapminmax(''reverse'',sim(NET_D, NNT_IN_D_P),ts)'';']); 
     end
end;
close(h) 
%% . Exporting outputs.........................................................
disp({'--Exporting-----------------------------------------'}); 
if nargin==3,
    out_path=[varargin{3},strrep(varargin{2},'L2A','L2B'),'\'];
else,
    out_path=[varargin{1},strrep(varargin{2},'L2A','L2B'),'\'];
end;

if ~isfolder(out_path)
   mkdir (out_path);
end;
    
bbox=Ib.BoundingBox;
utmzone=strsplit(Ib.GeoAsciiParamsTag,' ');
utmzone=utmzone{6};utmzone=[utmzone(1:2),' ',utmzone(3)];
[bbox(:,2),bbox(:,1)] = utm2deg(bbox(:,1),bbox(:,2),[utmzone;utmzone]);
bit_depth=32;

for bb={'LAI','FCOVER','FAPAR','LAI_Cab','LAI_Cw'}
    geotiffwrite([out_path,strrep(file_name,'L2A','L2B'),'_',char(bb),'.tif'], bbox, eval(['reshape(NNT_OUT.',char(bb),'(:,end),r,c)']), bit_depth, Ib);
end;
disp({'--Done !---------------------------------------------------------'});
end


