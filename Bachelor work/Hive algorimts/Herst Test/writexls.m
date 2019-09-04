function writexls(name,lib,str1,str2)

sz=size(lib(1).matrx,1);
for i=1:length(lib)
    num=sz*(i-1)+2*i;
    range=[str1{1} num2str(num) str2{1} num2str(num+sz)];
    xlswrite(name,lib(i).matrx,range);
    xlswrite(name,lib(i).matrx,range);
end
end