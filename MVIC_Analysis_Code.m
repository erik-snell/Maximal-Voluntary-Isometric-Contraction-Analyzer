%load in data
filepath = '/Users/eriksnell/Desktop/Spring of 2026/Thesis Neuro & Force Files/Compiled Trials'

channel = importdata('S_017_MVIC_Trials.xlsx');

%pull out the pre versus post MVIC
pre_MVIC_force_profile = channel.data (:,1:2:5);
post_MVIC_force_profile = channel.data (:,2:2:6)




%create a bound within the MVIC 6-second contraction that the epoch of the peak value has to be within 
epoch_lower = 2000;
epoch_upper = 10000;

%create a bound within the MVIC that the peak value has to be within
max_lower = 4000;
max_upper = 8000;


[m,pre_MVIC_trial] = size(channel.data(:,1:2:5)); %identify the # of subjects


for m=1:pre_MVIC_trial;
    raw_pre_MVIC=pre_MVIC_force_profile(max_lower:max_upper,m);%pull out the raw signal (4,000 points)

    pre_MVIC_epoch_range = pre_MVIC_force_profile(epoch_lower:epoch_upper,m)

    [peak_force_pre_MVIC, x] = max (raw_pre_MVIC);%identify the max value within the pre-determined MVIC range (4000-8000)

    pre_MVIC_epoch(m) = mean (pre_MVIC_epoch_range(x+1000:x+3000)); 

end

[n,post_MVIC_trial] = size(channel.data(:,2:2:6));%identify the # of subjects

for n=1:post_MVIC_trial;
    raw_post_MVIC=post_MVIC_force_profile(max_lower:max_upper,n);%pull out the raw signal (4,000 points)

    post_MVIC_epoch_range = post_MVIC_force_profile(epoch_lower:epoch_upper,n)

    [peak_force_post_MVIC, x] = max (raw_post_MVIC);%identify the max value within the pre-determined MVIC range (4000-8000)

    post_MVIC_epoch(n) = mean (post_MVIC_epoch_range(x+1000:x+3000)); 

end

compiled_MVIC = [pre_MVIC_epoch(:),post_MVIC_epoch(:)]

   