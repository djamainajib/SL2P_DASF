function [flag]=input_out_of_range_flag_function (data,r,c)

h = waitbar(0,'Creating input out of range flag...');
convex_hull=importdata('aux_data\S2_SL2P_large_trunc_u_D_convex_hull.mat');

%% 1.3. Classifiying TOC reflectance data used for training NNT
for ii=1:size(data,2),
   waitbar(ii/size(data,2))
   data0=data(:,ii);
   data0(find(data0<convex_hull.grid(1,ii)-(0.5*convex_hull.PP(ii))),:)=0;
   data0(find(data0>convex_hull.grid(end,ii)+(0.5*convex_hull.PP(ii))),:)=99;
   for jj=1:size(convex_hull.grid,1),
       data0(find(data0>=convex_hull.grid(jj,ii)-(0.5*convex_hull.PP(ii))& data0<=convex_hull.grid(jj,ii)+(0.5*convex_hull.PP(ii))),:)=jj;
   end; 
   data(:,ii)=data0*(100^ii);
end;
class=[sum(data')]';
flag=reshape(~ismember(class,convex_hull.data),r,c);
close (h);

end



