function  res=interpFunc(res, Cols, Rows, N_templates, interpStep,ext)

Cols = double(Cols);
Rows = double(Rows);
mean_template=cell(Rows,Cols);

for i=1:N_templates
    mean_template{ceil(i/Cols),mod(i-1,Cols)+1}=res(i,:);    
end


res=cell((Rows-ext)*interpStep+ext,(Cols-ext)*interpStep+ext);


%Interpolate each initial row through all columns
disp(['Interpolating Columns'])
for r=1:(Rows)
    count = 1;
    disp(['Row: ' int2str(r)])
    for c=1:(Cols)
        if c<Cols
            step=(mean_template{r,c+1}-mean_template{r,c})/(interpStep);
        end
        for i=1:interpStep
            res{(r-1)*10+1,count}=step*mod(count-1,interpStep)+mean_template{r,ceil(count/10)};
            count = count+1;
        end
    end
end

% interpolate all rows
disp(['Interpolating Rows'])
for c=1:size(res,2)
    count = 1;
    disp(['Column: ' int2str(c)])
    for r=1:(size(mean_template,1)-ext)
        if r<Rows
            step=(res{r*10+1,c}-res{(r-1)*10+1,c})/(interpStep);
        end
        for i=1:interpStep
            res{count,c}=step*mod(count-1,interpStep)+res{(ceil(count/10)-1)*10+1,c};
            count = count+1;
        end
    end
end




