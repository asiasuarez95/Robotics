%{
 file: box.m

 	The Box class is designed to be called by the Subdivision class.
	Each box is a square defined by three independent parameters:
		x, y, w
	where (x,y) is the box center, and w the half-width.
	We have dependent properties like
		NE, SE, SW, NW
	for the four corners of the box.

	In Subdivision class, the boxes must be treated as objects
		because it has state information.
		So that we have "pointers" to boxes.
	
	For instance, a box, if it has been split, has four children.
		We do not store the children directly in the box,
		but stores indices to these children.
		The indices acts as pointers, controlled by the
		Subdivision class.   Thus, when we split a box
		in the current class, we cannot set these indices
		which 	Robotics Class, Spring 2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Robotics Class, Spring 2017
	Chee Yap (with help of TA's Rohit Muthyla and Naman Kumar)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}

classdef box < handle
    properties
    % child is either empty or an array of size 4.
    %	child(i) is the index to the i-th child.
    %	CONVENTION:
    %	   The i-th child is in the i-th quadrant relative to the box center.
        x; y; w;
        isLeaf = true;
	child = {};
    end
    properties (Dependent)
	NE; SE; SW; NW;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = box(xx, yy, ww)
	% Constructor
            obj.x = xx;
            obj.y = yy;
            obj.w = ww;
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%% IMPLEMENT THE FUNCTIONS TO
	%%%%%%%%%%  COMPUTE the NE, SE, SW, NW corners
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function ne = get.NE(box)
            xx = box.x + box.w;
            yy = box.y + box.w;
            ne = [xx yy];
        end
       
        function se = get.SE(box)
            xx = box.x + box.w;
            yy = box.y - box.w;
            se = [xx yy];
        end
        
        function sw = get.SW(box)
            xx = box.x - box.w;
            yy = box.y - box.w;
            sw = [xx yy];
        end
        
        function nw = get.NW(box)
            xx = box.x - box.w;
            yy = box.y + box.w;
            nw = [xx yy];
        end
        
        function child = split(obj)
	% SPLIT() returns an array CHILD where
	%   CHILD(i) is in quadrant i (i=1,2,3,4)
    
        obj.isLeaf = false;
        ww = obj.w/2;
        boxNE = box(obj.x + ww, obj.y + ww, ww);
        boxNW = box(obj.x - ww, obj.y + ww, ww);
        boxSW = box(obj.x - ww, obj.y - ww, ww);
        boxSE = box(obj.x + ww, obj.y - ww, ww);
        
        child = [boxNE boxNW boxSW boxSE];
		%% TO BE IMPLEMENTED
        end
	function inside = isIn(obj, x, y)
	% ISIN(x,y) returns true if (x,y) is inside the box.

        xRangeMin = obj.x - obj.w;
        xRangeMax = obj.x + obj.w;
        yRangeMin = obj.y - obj.w;
        yRangeMax = obj.y + obj.w;
        inside = false;
        
        if x >= xRangeMin && x <= xRangeMax
            if y >= yRangeMin && y <= yRangeMax
                inside = true;
            end
        end
		%% TO BE IMPLEMENTED
	end

	function quad = findQuad(obj, x, y)
	% FINDQUAD(x,y) returns index i if (x,y) is in quadrant i
	%   for some i = 1,2,3,4.
	%   ASSERT: (x,y) lies within the box.
	%   We ought to return 0 if (x,y) is not in the box.

        xRangeMax = obj.x + obj.w;
        yRangeMax = obj.y + obj.w;
        quad = 0;
        
        % Not in Box
        if obj.isIn(x, y)
            if x >= obj.x && x <= xRangeMax
                if y >= obj.y && y <= yRangeMax
                    % NorthEast
                    quad = 1;
                else
                    % SouthEast
                    quad = 4;
                end
            else
                if y >= obj.y && y <= yRangeMax
                    % NorthWest
                    quad = 2;
                else
                    % SouthWest
                    quad = 3;
                end
            end
        end
    
		%% TO BE IMPLEMENTED
        end
        function showBox(obj)	
	% SHOWBOX is displays some information about the box.

        %% LEAF
        leafWord = '';
        if obj.isLeaf
            leafWord = 'leaf';
        end
        fprintf('%s box(%3.2f, %3.2f, %3.2f)\n', leafWord, obj.x, obj.y, obj.w);

		%% TO BE IMPLEMENTED
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Static = true)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function test()
        
	% Testing some basic functions of box class.
            b = box(0,0,1);
            b.showBox();
            disp(['-->> Is root a leaf? ',num2str(b.isLeaf)]);
            children = b.split();
            disp('-->> child 1 = '); children(1).showBox();
            disp('-->> child 2 = '); children(2).showBox();
            disp('-->> child 3 = '); children(3).showBox();
            disp(['-->> Is root a leaf? ',num2str(b.isLeaf)]);
            disp(['-->> Is child(1) a leaf? ',num2str(children(1).isLeaf)]);
	    disp(['-->> Which child contains (-0.2, 0.6)  ? ', ...
	    	num2str(b.findQuad(-.2,.6))]);
	    disp(['-->> Is (0.5, -2) inside box(0,0,1)? ', ...
	    	num2str(b.isIn(0.5,-2))]);

	    corner = children(4).SW;
	    disp(['-->> SW corner of child(4) = (', ...
	    	num2str(corner(1)), ', ', num2str(corner(2)), ')']);
%}
        end
    end
end
