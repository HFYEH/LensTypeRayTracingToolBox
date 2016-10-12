function [d] = rotation(azimuthal, declination, d0)
% Find director unit vector in world coordinate by giving
% 1. Director azimuthal angle
% 2. Director declination angle
% ����Ʀ���إΪk
% �Ĥ@��:��J��쨤�M�ɨ�,�i�H�o�X�q[1 0 0]�_�l�V�q����᪺�V�q,��k�O����y�b��,�A��z�b
% �ĤG��:�Y�h��J�_�l�V�q,�hdeclination������0,���M�|���,�o�ؼҦ��u��z�b�@����
if nargin < 3
    d0 = [1 0 0]';
    declination = -declination; % ��-y���
else
    d0 = d0';
    if declination ~= 0
        error('Declination angle must be zero for this mode!');
    end
end
T = [cosd(declination)*cosd(azimuthal) -sind(azimuthal) sind(declination)*cosd(azimuthal); ...
        cosd(declination)*sind(azimuthal) cosd(azimuthal) sind(azimuthal)*sind(declination); ...
        -sind(declination) 0 cosd(declination)];
d =T*d0;
d = d';