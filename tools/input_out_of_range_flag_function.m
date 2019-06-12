function [flag]=input_out_of_range_flag_function (data,r,c)
convex_hull=importdata('aux_data\S2_SL2P_large_trunc_u_D_convex_hull.mat');
Nb_Cas=length(data);
CL=ceil((data-repmat(convex_hull.Extreme(1,:),Nb_Cas,1))./repmat(convex_hull.Extreme(2,:)-convex_hull.Extreme(1,:),Nb_Cas,1).*convex_hull.N_classes);
CL(CL>99)=99;
CL(CL<0)=99;
UCL=0;
for ii=1:size(CL,2),
    UCL=UCL+CL(:,ii)*(100^(ii-1));
end;
flag=reshape(~ismember(UCL,convex_hull.data),r,c);
end



