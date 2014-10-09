function out2 = visualizeLanes()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualization for the annotated lanes
%% (Hit any key to move to next image)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The directories with the images and the annotation output
kitti_raw_dir = '/net/acadia/data/3DReconstBenchmarks/KITTI_RAW';
sfm_out_dir = '/net/acadia/data/SFM_Outputs';
%img_dir = '/home/ma/vdhiman/wrk/sceneunderstanding/KITTI_RAW/city/2011_09_26/2011_09_26_drive_0001_sync/image_02/data';
%annotation_dir = '/home/ma/vdhiman/wrk/sceneunderstanding/SFM_Outputs/OtherLanes/Data/City/2011_09_26_drive_0001';
img_dir = [kitti_raw_dir, '/', '%s/2011_09_26/2011_09_26_drive_%04d_sync/image_02/data'];
annotation_dir = [sfm_out_dir, '/', 'OtherLanes/Data/%s/2011_09_26_drive_%04d'];

% Load an annotation mat-file
annotation_file = [annotation_dir, '/', 'otherlanes.mat'];

egolanes_file = [sfm_out_dir, '/', 'EgoLanes/Data/%s/2011_09_26_drive_%04d/egolanes.mat'];

for ktype={'Road', 'City', 'Residential'}
	for count=1:110
		if ~exist(sprintf(annotation_file, ktype{1}, count), 'file') 
			%disp([sprintf(annotation_file, ktype{1}, count), ' do not exists']);
		elseif ~exist(sprintf(img_dir, lower(ktype{1}), count), 'file')
			disp([sprintf(img_dir, lower(ktype{1}), count), ' do not exists']);
		else
			if exist(sprintf(egolanes_file, ktype{1}, count), 'file')
				disp(['showing egolanes ', ktype{1}, ' ', num2str(count)]);
				showFrames(sprintf(img_dir, lower(ktype{1}), count), sprintf(egolanes_file, ktype{1}, count));
			end

			disp(['showing otherlanes ', ktype{1}, ' ', num2str(count)]);
			showFrames(sprintf(img_dir, lower(ktype{1}), count), sprintf(annotation_file, ktype{1}, count));
		end
	end
end


end % End of function main


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = showFrames(img_dir, annotation_file)
load(annotation_file, 'ld');

num_frames = length(ld.frames); % Total number of annotated frame
num_lanes = length(ld.objects); % Total number of annotated lanes in the sequence

for i = 1:num_frames
    % Load the annotated image i
    img_name = [img_dir, '/', ld.frames(i).frame];
    img = imread(img_name);
    
    imshow(img);
    hold on;
    
    % Get number of annotated lanes in this image
    num_labels = length(ld.frames(i).labels);
    
    for j = 1:num_labels
	
	% Get the type, control points and id for lane j
	label_type = ld.frames(i).labels(j).type;
	control_points = ld.frames(i).labels(j).points;
	object_id = ld.frames(i).labels(j).obj;
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% Plot lanes modeled as splines
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
	if strcmp(label_type, 'spline')
	    % Evaluate spline points at specified interval
	    interval = 0.05;
	    [spline_points, tangent] = compSpline(control_points, interval);
	    
	    % Some plot options
	    spline_color = 'b';
	    control_point_color = 'r';
	    line_width = 3;
	    marker_size = 5;
	    
	    % Plot the spline points
	    figure_handle = [];
	    for k = 1:size(spline_points,1) - 1
		figure_handle = [figure_handle plot([spline_points(k,1), spline_points(k+1,1)], [spline_points(k,2), spline_points(k+1,2)], spline_color, 'LineWidth', line_width)];
	    end
	    
	    % Plot the control points
	    figure_handle = [figure_handle plot(control_points(:,1), control_points(:,2), ['*' control_point_color], 'MarkerSize', marker_size)];
	    
	    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% Plot lanes modeled as line segments
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	elseif strcmp(label_type, 'line')	    
	    % Some plot options
	    line_color = 'k';
	    control_point_color = 'm';
	    line_width = 3;
	    marker_size = 5;
	    
	    % Plot the line points
	    figure_handle = [];
	    figure_handle = [figure_handle plot(control_points(:,1), control_points(:,2), ['-' line_color], 'LineWidth', 2)];
	    
	    % Plot the control points
	    figure_handle = [figure_handle plot(control_points(:,1), control_points(:,2), ['*' control_point_color])];
	    
	end
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% Plot the lane number
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	if ~isempty(object_id)
	    figure_handle = [figure_handle text(control_points(1,1)+5, control_points(1,2), ['[' num2str(object_id) ']'], 'Color', 'g', 'FontSize', 12, 'FontWeight','bold')];
	end
	
    end
    
    hold off;
    
    % Hit any key to move to next image in sequence
    pause;
    
end
end % End of function showFrames

