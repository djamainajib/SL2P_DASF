function I = robustgeotiffinfo(fname)
%--- BELOW is to make it more robust if no mapping toolbox ---
%if license('test','map_toolbox')
%    I=geotiffinfo(fname);
%else
I=imfinfo(fname);
%     %TODO: generate home-made refmatrix(?)....
%     if isfield(tags, 'ModelTransformationTag') && numel(tags.ModelTransformationTag) >= 8
%         geoimread does not work for rotated systems
%         
%     else %use ModelPixelScaleTag instead
%         dx =  I.ModelPixelScaleTag(1); dy = -I.ModelPixelScaleTag(2);
%         x0 = I.ModelTiepointTag(4) - dx * I.ModelTiepointTag(1);
%         y0 = I.ModelTiepointTag(5) - dy * I.ModelTiepointTag(2);
%         J = [dx 0; 0 dy];
%     end
%     I.RefMatrix=[flipud(J); x0-J(1,1)-J(1,2)];
end