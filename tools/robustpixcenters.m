function [x,y]=robustpixcenters(I)
%if license('test','map_toolbox')
%    [x,y]=pixcenters(I);
%else
    %I have not read documentation... but this only works for rectilinear systems.
assert(I.ModelPixelScaleTag(3)==0,'unexpected ModelPixelScaleTag format.');
assert(all(I.ModelTiepointTag(1:3)==0),'unexpected ModelTiepointTag format.');
x=((0:I.Width-1)-I.ModelTiepointTag(1))*I.ModelPixelScaleTag(1)+I.ModelTiepointTag(4);
y=((0:I.Height-1)-I.ModelTiepointTag(2))*-I.ModelPixelScaleTag(2)+I.ModelTiepointTag(5);
end