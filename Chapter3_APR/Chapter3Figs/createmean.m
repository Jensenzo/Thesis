choice=1;

    sigma_a=0.1; mu_a=1;



    %filter data
    b=fir1(1000,0.02,'high');
    x_train(1:x_train_sz(choice),choice)=filter(b,1,x_train(1:x_train_sz(choice),choice));



x=x_train(1:x_train_sz(choice),choice);

plot(x)
[zoom,~]=ginput(1);
zoom = round(zoom);

plot(x(max(1,zoom-8000):min(length(x_train(:,choice)),zoom+8000)))
[start_template,~]=ginput(1);
start_template=round(start_template+zoom-8000);

% Select initial template
template=x(start_template:start_template+1000);

% Scale initial template
template=template./sum(template.*template); 

%Filtering operation
detect=filter(template(end:-1:1),1,x);


       detect_list_post=[];   % Tap position
       detect_mag_post=[];    % Tap magnitude
       detect_list_pre=[];   % Tap position
       detect_mag_pre=[];    % Tap magnitude
       detect_list=[];   % Tap position
       detect_mag=[];    % Tap magnitude
       mean_template2=zeros(3001,1); %New
       
for r=1:1000:length(detect)
    % Finds maximum peak (and index of this max) in each 1000 sample section
    [max_detect,detect_ind]=max(detect(max(1,r):min(r+1000,length(detect))));

    if max_detect>0.3 % Threshold for peak detection
        detect_list_pre=[detect_list_pre max(1,r)+detect_ind-1]; %Added minus 1 to allign correctly
        detect_mag_pre=[detect_mag_pre max_detect];
    end    
end
%Extra detection loop
%If a beginning of a tap appears at the beginnning or the end of a
%1000 sample section this might correct the problem.
for o=1:size(detect_list_pre,2)
% Finds maximum peak (and index of this max) in each 1000 sample section
    [max_detect,detect_ind]=max(detect(max(1,detect_list_pre(o)-500):min(size(detect,1),detect_list_pre(o)+500)));

    detect_list_post=[detect_list_post max(1,detect_list_pre(o)-500)+detect_ind-1]; %Added minus 1 to allign correctly
    detect_mag_post=[detect_mag_post max_detect];
end

%Remove duplicate entries
[~, uniq_list_m]=unique(detect_list_post);
detect_list=detect_list_post(sort(uniq_list_m));
       
[~, uniq_mag_m]=unique(detect_mag_post);
detect_mag=detect_mag_post(sort(uniq_mag_m));

num_sums=0;
aligned_train=zeros(3001,length(detect_list)); %initalise 

%Allign taps and construct mean
for r=1:length(detect_list)
    plot(x(max(1,detect_list(r)-2000):min(size(detect,1),detect_list(r)+1000)))
    hold on
    
    if (num_sums<1000)
        mean_template2=mean_template2+resize(x(max(1,detect_list(r)-2000):min(size(x_train(:,choice),1),detect_list(r)+1000)),size(mean_template2,1),1);     
        num_sums=num_sums+1;
        aligned_train(:,num_sums)=resize(x(max(1,detect_list(r)-2000):min(size(detect,1),detect_list(r)+1000)),size(aligned_train,1),1);
    end
end

mean_template2=mean_template2./num_sums; %Divide by number of taps


hold on
plot(mean_template2,'r')
xlabel('Samples')
ylabel('Amplitude')
title('Aligned taps and mean template')
legend('Data','Mean template')

