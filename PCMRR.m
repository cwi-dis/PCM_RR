function [d, feats] = PCMRR(referencePC, distortedPC, k, ang_sim_ref, ang_sim_dis)
%PCMRR computes the reduced reference objective quality metric between a
%reference and distorted point cloud contents
%   Usage: d = PCMRR(referencePC, distortedPC, k, ang_sim_ref, ang_sim_dis)
% 
% 
%   Input parameters
%       referencePC   = path to reference content
%       distortedPC   = path to distorted content
%       k             = number of neighbors to be used in normal computation
%                       (default = 9)
%       ang_sim_ref   = optional; pre-computed angular similarity matrix 
%                       for reference content 
%       ang_sim_dis   = optional; pre-computed angular similarity matrix 
%                       for distorted content 
%
%
%   Output parameters
%       d             = objective quality value
%       feats         = absolute difference between single features
%
%   The function computes the reduced-reference objective quality metric
%   PCM_RR, given paths to a reference and distorted contents. If normals
%   are not given with the contents, they will be estimated using MATLAB
%   point cloud utilities. To speed up computation, it is possible to provide
%   the angular similarity matrices as additional parameter.

% Copyright (c) Irene Viola, Pablo Cesar.
% Centrum Wiskunde & Informatica (CWI).
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% If you use this software please kindly cite
%     I. Viola, and P. Cesar.
%     "A reduced reference metric for visual quality evaluation of point
%     cloud contents". In IEEE Signal Processing Letters, 2020.

if nargin < 3
    k = 9;
end
if nargin <4
    ang_sim_ref = [];
end
if nargin < 5
    ang_sim_dis = [];
end

refPC = pcread(referencePC);
disPC = pcread(distortedPC);

refF = getFeatures(refPC, ang_sim_ref, k);
disF = getFeatures(disPC, ang_sim_dis, k);

feats = double(abs(refF - disF));

load('./weights.mat', 'alpha');

d = feats'*alpha;

end