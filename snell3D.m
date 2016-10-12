% =========================================================================
% 3-dimensional Snell's law
% =========================================================================
% �o�ӵ{���u��B�z isotropic-isotropic, isotropic-anisotropic, anisotropic-isotropic�T�ر��p
% ���Ѥ���@�J�g�줶��G
% ����G�Y��anisotropic�hnout��1x2�}�C,�m�J[ne, no]
% �Y��isotropic�h��Ӽh��g�vn
% Perform refraction and transmission in the sitation mentioned above
% Input: 1. sdata in media 1
%        2. normal vector of the interface
%        3. thickness in media 2
%        4. refractive index of media 2 (if anisotropic, input 1x2 array)
% Output: sdata in media 2
function [sdata] = snell3D(sdata, normal, thickness, nout, d)

% �J�g���b���������q
%ki_tang = sdata.k - dot(sdata.k,normal)*normal;
ki_tang = sdata.k - sum(sdata.k.*normal)*normal;

% �P�_����G�����V�ΫD���V
if length(nout)>1 && nout(2) ~= nout(1)
    % �D���V
    nz = dot(normal,d);
    ki_tangz = dot(ki_tang,d);
    A1 = nz^2;
    A2 = norm(cross(normal,d))^2;
    B1 = 2*nz*ki_tangz;
    B2 = norm(ki_tang+normal)^2 - norm(ki_tang)^2 - 1 - B1;
    C1 = ki_tangz^2;
    C2 = norm(cross(ki_tang,d))^2;
    A = A1/nout(2)^2+A2/nout(1)^2;
    B = B1/nout(2)^2+B2/nout(1)^2;
    C = C1/nout(2)^2+C2/nout(1)^2-1;
    kout = ki_tang + (-B+sqrt(B^2-4*A*C))/2/A*normal;
else
    % ���V
    kout = ki_tang + sqrt(nout(1)^2-(norm(ki_tang))^2)*normal;
end

% ���Ϯg�o�ͮ�,�{����X�T��,�{������(���קK���Ϯg�o��)
if ~isreal(kout)
    error('Total reflection exists, rays perform total reflection are reset to zero incident!!!');
end

% �s�J����G�����i�V�q
sdata.k = kout;

% �Q�Τ���G���i�V�q�p����b����G������m�ܤ�,�ñN���b����G��������m�x�s
t = -thickness/kout(3);
kout = kout*t;
sdata.r = sdata.r + kout(1:2);