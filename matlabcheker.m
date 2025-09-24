

rows = 246;
cols = 300;
edge_img = uint8(ones(rows, cols));
 
fid = fopen('output2.txt','r');
result = textscan(fid, '%s');
fclose(fid);
 
for r = 1: rows
    for c = 1 : cols
        edge_img(r,c) = bin2dec(result{1,1}{(r-1)*300+c,1}) ;
    end
end
 
figure, imshow(edge_img);
