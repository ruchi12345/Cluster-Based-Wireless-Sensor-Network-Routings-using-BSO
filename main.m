
clear;
clf;
clc;
close all;

global generation_size pop_size sense_node sense_range sensor_selected target_coveraged target_x target_y node_x node_y distance grid_range_x grid_range_y span

sense_range=17.675;
sense_node=400;
packet_bit=2000;
generation_size=20;
pop_size=50;
grid_range_x=200; 
grid_range_y=200;
span=0.04;% 
 
sink_x=50;
sink_y=200; % 
 sensor_selected=zeros(pop_size,sense_node,generation_size+1);

 
target_x=zeros(grid_range_y*span,grid_range_x*span);
target_y=zeros(grid_range_y*span,grid_range_x*span);
 
dist_node_target=zeros(grid_range_y*span,grid_range_x*span,sense_node);
 
m=0;
n=0;
for k=1:400
    node_x(k)=m;
    node_y(k)=n;
    if m>=95
        m=0;
        n=n+5;
    else
        m=m+5;
    end
end
 tic
clf;
for i=1:grid_range_y*span   %  
    for j=1:grid_range_x*span
        target_x(i,j)=6.25+(j-1)*12.5;
        target_y(i,j)=6.25+(i-1)*12.5;
    end
end

 


for i=1:grid_range_x*span %%  
        axis image;
        hold on;
        subplot(1,2,1),plot(target_x(i,:),target_y(i,:),'*');title('Nodes plot distributuionin Grid','fontsize',16) 
        hold on;        
        subplot(1,2,2),plot(target_x(i,:),target_y(i,:),'*'); title('Circles representing the clusters head','fontsize',16)
end

for k=1:sense_node
    for i=1:grid_range_y*span
        for j=1:grid_range_x*span
            distance(i,j,k)=dist(node_x(k),node_y(k),target_x(i,j),target_y(i,j));
        end
    end
end
 
target_coveraged=zeros(length(target_x(:,1)),length(target_x(1,:)),pop_size,generation_size+1); % coverage array
[best_fit,best_idx]=algorithm();
init_node_x=[]; %  
init_node_y=[];
for i=1:sense_node
    init_node_x(length(init_node_x)+1)=node_x(i);
    init_node_y(length(init_node_y)+1)=node_y(i);
    subplot(1,2,1),text(node_x(i),node_y(i),int2str(i));
end
axis image;
hold on;          
subplot(1,2,1),circle(sense_range,init_node_x,init_node_y,'b');

       
 init_targe_coveraged=zeros(length(target_x(:,1)),length(target_x(1,:)));   %  
 for k=1:sense_node
           for i=1:length(target_x(:,1))
               for j=1:length(target_x(1,:))
                        if distance(i,j,k)<=sense_range
                               init_target_coveraged(i,j)=1;
                        end
               end
           end
 end


init_coveraged_target_count=0;      %  
init_target_covered_x=[];
init_target_covered_y=[];
for i=1:length(target_x(:,1))
      for j=1:length(target_x(1,:))
          if(init_target_coveraged(i,j)==1)
                init_coveraged_target_count=init_coveraged_target_count+1;
                init_target_covered_x(length(init_target_covered_x)+1)=target_x(i,j);
                init_target_covered_y(length(init_target_covered_y)+1)=target_y(i,j);
          end
      end
end
axis image;   %  
hold on;
subplot(1,2,1),plot(init_target_covered_x,init_target_covered_y,'y.');  
fprintf('\n initial coveraged target ratio=%d/%d active_node_num=%d',init_coveraged_target_count,length(target_x(1,:))*length(target_y(:,1)),sense_node); % list the original data
best_node_x=[]; % 
best_node_y=[];
for i=1:sense_node
      if(sensor_selected(best_idx,i,generation_size+1)==1)
            best_node_x(length(best_node_x)+1)=node_x(i);
            best_node_y(length(best_node_y)+1)=node_y(i);
            subplot(1,2,2),text(node_x(i),node_y(i),int2str(i));
      end
end
axis image;
hold on;          
subplot(1,2,2),circle(sense_range,best_node_x,best_node_y,'b');
best_target_covered_x=[]; %  
best_target_covered_y=[];
for i=1:length(target_y(:,1))
   for j=1:length(target_x(1,:))
        if(target_coveraged(i,j,best_idx,generation_size+1)==1) %  
                best_target_covered_x(length(best_target_covered_x)+1)=target_x(i,j);
                best_target_covered_y(length(best_target_covered_y)+1)=target_y(i,j);
        end
   end
end
axis image;
hold on;
subplot(1,2,2),plot(best_target_covered_x,best_target_covered_y,'y.');
fprintf('\n');

%  

[coverage_rec,avg_packets_to_bs,avg_packets_to_ch,dead,S,last_round,CLUSTERHS,avg_ch]=LEACH(sense_node,9000,0.2,...
sensor_selected(best_idx,:,generation_size+1),node_x,node_y,sink_x,sink_y,packet_bit,1);
avg_ch
avg_packets_to_bs
avg_packets_to_ch
toc
 

