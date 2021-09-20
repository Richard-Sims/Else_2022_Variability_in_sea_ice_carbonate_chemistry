%figures for Araleighs Sea ice paper

%% set paths
clc;  clear all ; close all; %reset workspace
addpath('c:\Users\rps207\Documents\Matlab\Functions');
addpath('c:\Users\rps207\Documents\Matlab\Functions\Add_Axis');
addpath('c:\Users\rps207\Documents\Matlab\Functions\cbdate');
addpath('C:\Users\rps207\Documents\MATLAB\Functions\Export_Fig');
addpath('c:\Users\rps207\Documents\Matlab\Functions\mixing_library');
addpath('c:\Users\rps207\Documents\Matlab\Functions\despiking_tooblox');
addpath('c:\Users\rps207\Documents\Matlab\Functions\cm_and_cb_utilities');
addpath('c:\Users\rps207\Documents\Matlab\Functions\m_map');
addpath('C:\Users\rps207\Documents\MATLAB\Functions\Colormaps\Colormaps (5)\Colormaps');
p=genpath('C:\Users\rps207\Documents\MATLAB\Functions\contourfcmap');
addpath(p)

addpath('C:\Users\rps207\Documents\MATLAB\Functions\xpdf-tools-win-4.03\bin64');

addpath('c:\Users\rps207\Documents\Matlab\Functions\cbrewer');
addpath('c:\Users\rps207\Documents\Matlab\Functions\mixing_library');


w=genpath('c:\Users\rps207\Documents\Matlab\Functions');
addpath(w)
addpath('c:\Users\rps207\Documents\Matlab\Functions');
addpath('c:\Users\rps207\Documents\Matlab\Functions\Add_Axis');
addpath('c:\Users\rps207\Documents\Matlab\Functions\cbdate');
addpath('c:\Users\rps207\Documents\Matlab\Functions\cbrewer');
addpath('c:\Users\rps207\Documents\Matlab\Functions\m_map');
addpath('c:\Users\rps207\Documents\Matlab\Functions\mixing_library');
addpath('c:\Users\rps207\Documents\Matlab\Functions\cm_and_cb_utilities');
p=genpath('C:\Users\rps207\Documents\MATLAB\Functions\contourfcmap');
addpath(p)



mfileDir = 'C:\Users\rps207\Documents\MATLAB\2019 - Sea ice cores\'; %path for main matlab analysis

degree_symbol= sprintf('%c', char(176));
micro_symbol= sprintf('%c', char(0181));
markersty='p' ;

[cm_data]=viridis();
set(groot,'DefaultFigureColormap',cm_data)
colormap(parula)
%% Custom RGB colour vectors
colour_teal = [18 150 155] ./ 255;
colour_lightgreen = [94 250 81] ./ 255;
colour_green = [12 195 82] ./ 255;
colour_lightblue = [8 180 238] ./ 255;
colour_darkblue = [1 17 181] ./ 255;
colour_yellow = [251 250 48] ./ 255;
colour_peach = [251 111 66] ./ 255;
colour_crimson = [220,20,60] ./ 255;
colour_verylightblue = [204 255 229] ./ 255;
colour_peachback = [255 255 204] ./ 255;
colour_yellowlight = [255 255 100] ./ 255;
colour_rose = [253 153 153] ./ 255;
colour_greyshade= [192 192 192] ./ 255;
colour_violet = [238,130,238] ./ 255;
colour_orangelight = [255,178,102] ./ 255;

colour_indigo = [75,0,130] ./ 255;
colour_mustard = [204 204 0] ./ 255;
colour_firebrick = [178,34,34] ./ 255;
colour_darkkhaki = [189,183,107] ./ 255;
colour_darkgrey = [169,169,169] ./ 255;
colour_rosybrown = [188,143,143] ./ 255;
colour_aquamarine = [127,255,212] ./ 255;
colour_olivedrab= [107,142,35] ./ 255;
colour_goldenrod= [218,165,32] ./ 255;
colour_brown = [165,42,42] ./ 255;
colour_purple = [76,0,153] ./ 255;
colour_lightred = [255,51,51] ./ 255;
colour_indianred = [205,92,92] ./ 255;
colour_darksalmon = [233,150,122] ./ 255;
colour_darkorange = [255,140,0] ./ 255;
colour_forestgreen= [34,139,34] ./ 255;
colour_limegreen= [50,205,50] ./ 255;
colour_springgreen = [0,250,154] ./ 255;
colour_mediumseagreen = [60,179,113] ./ 255;
colour_siennna = [160,82,45] ./ 255;
colour_sandybrown = [244,164,96] ./ 255;

colour_orchid = [218,112,214] ./ 255;
colour_cornflowerblue = [100,149,237] ./ 255;
colour_mediumturquoise= [72,209,204] ./ 255;
colour_coral= [255,127,80] ./ 255;
colour_orange = [255,165,0] ./ 255;
colour_khaki = [240,230,140] ./ 255;

colour_offwhite =[242, 243, 244] ./ 255; 
colour_seaice_blue =[214, 234, 248 ] ./ 255; 
%% load bathymetry data
load('C:\Users\rps207\Documents\Data\Coastline and bathymetry data/bathymetry_cambay.mat')
%% load in snow data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\Snowdepth.xlsx','Sheet','A2:D16');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4]);
data = reshape([raw{:}],size(raw));
Core_A = cellVectors(:,1);
Core_B = cellVectors(:,2);
Snowdepth_A = data(:,1);
Snowdepth_B = data(:,2);
clearvars data raw cellVectors;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load in high res core profiles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% profile data - in 3 sheets so extarct them seperately 
[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\CoreProfiles.xlsx','nDIC','A2:F19');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6]);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
DIC_A = data(:,3);
DIC_B = data(:,4);
clearvars data raw cellVectors R;

[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\CoreProfiles.xlsx','nTA','A2:F19');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6]);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
TA_A = data(:,3);
TA_B = data(:,4);
clearvars data raw cellVectors R;

[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\CoreProfiles.xlsx','Salinity','A2:F19');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6]);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
Sample_A = cellVectors(:,1);
Sample_B = cellVectors(:,2);
Depth_A = data(:,1);
Depth_B = data(:,2);
Sal_A = data(:,3);
Sal_B = data(:,4);
clearvars data raw cellVectors R;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load in snow depth transect
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\IceSnowTransect.xlsx','Sheet1','A2:J11');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2,3,8]);
raw = raw(:,[4,5,6,7,9,10]);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
snow_trans_SiteLabel = cellVectors(:,1);
snow_trans_Lat = cellVectors(:,2);
cy=snow_trans_Lat(2);
snow_trans_Lat(2)=cellstr(num2str(cy{:}));
snow_trans_Long = cellVectors(:,3);
cy=snow_trans_Long(2);
snow_trans_Long(2)=cellstr(num2str(cy{:}));
snow_trans_DistancefromT10km = data(:,1);
snow_trans_DistancefromT1km = data(:,2);
snow_trans_IceThkcm = data(:,3);
snow_trans_SnowDepthcm = data(:,4);
snow_trans_IceThkinverted = data(:,6);
clearvars data raw cellVectors R;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load in temp/sal site A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\TempSalData.xlsx','ExampleGraph','A3:K23');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[4,8]);
raw = raw(:,[1,2,3,5,6,7,9,10,11]);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
tempsal_siteA_May04_Depth = data(:,1)*-1;
tempsal_siteA_May04_Temp = data(:,2);
tempsal_siteA_May04_Sal= data(:,3);
tempsal_siteA_May07_Depth = data(:,4)*-1;
tempsal_siteA_May07_Temp = data(:,5);
tempsal_siteA_May07_Sal = data(:,6);
tempsal_siteA_May10_Depth = data(:,7)*-1;
tempsal_siteA_May10_Temp = data(:,8);
tempsal_siteA_May10_Sal = data(:,9);
clearvars data raw cellVectors R;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load in temp/sal site B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\TempSalData.xlsx','ExampleGraph','A30:K48');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[4,8]);
raw = raw(:,[1,2,3,5,6,7,9,10,11]);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
tempsal_siteB_May04_Depth = data(:,1)*-1;
tempsal_siteB_May04_Temp = data(:,2);
tempsal_siteB_May04_Sal = data(:,3);

tempsal_siteB_May07_Depth = data(:,4)*-1;
tempsal_siteB_May07_Temp = data(:,5);
tempsal_siteB_May07_Sal = data(:,6);

tempsal_siteB_May10_Depth = data(:,7)*-1;
tempsal_siteB_May10_Temp = data(:,8);
tempsal_siteB_May10_Sal = data(:,9);
clearvars data raw cellVectors R;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load in temp weather data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, ~, raw, dates] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\Weather.xlsx','en_climate_hourly_NU_2400603_05','A2:AD745','',@convertSpreadsheetExcelDates);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[3,11,13,15,16,17,19,21,22,23,25,26,27,29,30]);
raw = raw(:,[1,2,4,6,7,8,9,10,12,14,18,20,24,28]);
dates = dates(:,5);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),dates); % Find non-numeric cells
dates(R) = {NaN}; % Replace non-numeric Excel dates with NaN
data = reshape([raw{:}],size(raw));
weather_seaice_Longitudex = data(:,1);
weather_seaice_Latitudey = data(:,2);
weather_seaice_StationName = cellVectors(:,1);
weather_seaice_ClimateID = data(:,3);
DateTimeLST = datetime([dates{:,1}].', 'ConvertFrom', 'Excel', 'Format', 'dd/MM/yyyy');
weather_seaice_Year = data(:,4);
weather_seaice_Month = data(:,5);
weather_seaice_Day = data(:,6);
weather_seaice_TimeLST = data(:,7);
weather_seaice_TempC = data(:,8);
weather_seaice_TempFlag = cellVectors(:,2);
weather_seaice_DewPointTempC = data(:,9);
weather_seaice_DewPointTempFlag = cellVectors(:,3);
weather_seaice_RelHum = data(:,10);
weather_seaice_RelHumFlag = cellVectors(:,4);
weather_seaice_PrecipAmountmm = cellVectors(:,5);
weather_seaice_PrecipAmountFlag = cellVectors(:,6);
weather_seaice_WindDir10sdeg = data(:,11);
weather_seaice_WindDirFlag = cellVectors(:,7);
weather_seaice_WindSpdkmh = data(:,12);
weather_seaice_WindSpdFlag = cellVectors(:,8);
weather_seaice_Visibilitykm = cellVectors(:,9);
weather_seaice_VisibilityFlag = cellVectors(:,10);
weather_seaice_StnPresskPa = data(:,13);
weather_seaice_StnPressFlag = cellVectors(:,11);
weather_seaice_Hmdx = cellVectors(:,12);
weather_seaice_HmdxFlag = cellVectors(:,13);
weather_seaice_WindChill = data(:,14);
weather_seaice_WindChillFlag = cellVectors(:,14);
weather_seaice_Weather = cellVectors(:,15);
clearvars data raw dates cellVectors R;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load in tidal data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, ~, raw, dates] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\Tides.xlsx','Sheet1','A2:F237','',@convertSpreadsheetExcelDates);
raw = raw(:,[1,2,3,6]);
dates = dates(:,[4,5]);
data = reshape([raw{:}],size(raw));
% MONTH = data(:,1);
% DAY = data(:,2);
% TIMELocal = data(:,3);
% CombinedDate = datetime([dates{:,1}].', 'ConvertFrom', 'Excel', 'Format', 'dd/MM/yyyy');
tides_dateste = datetime([dates{:,2}].', 'ConvertFrom', 'Excel', 'Format', 'dd/MM/yy HH:mm:ss');
Tidal_height = data(:,4);
clearvars data raw dates;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load in tilt current meter data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%import data logger A
filename = 'C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\tilt_current_TFYI.txt';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
tcm_a_ISO8601Time = dataArray{:, 1};
tcm_a_dt=datenum(tcm_a_ISO8601Time,'yyyy-mm-ddTHH:MM:SS.fff');
tcm_a_vel_cms = dataArray{:, 2};
tcm_a_Bear_deg = dataArray{:, 3};
tcm_a_Vel_Ncms = dataArray{:, 4};
tcm_a_Vel_Ecms = dataArray{:, 5};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%import data logger B - fast site
filename = 'C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\tilt_current_Poly.txt';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
tcm_b_ISO8601Time = dataArray{:, 1};
tcm_b_dt=datenum(tcm_b_ISO8601Time,'yyyy-mm-ddTHH:MM:SS.fff');
tcm_b_vel_cms = dataArray{:, 2};
tcm_b_Bear_deg = dataArray{:, 3};
tcm_b_Vel_Ncms = dataArray{:, 4};
tcm_b_Vel_Ecms = dataArray{:, 5};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

logger_a_str= datenum('2019-05-04 12:00:00','yyyy-mm-dd HH:MM:SS');
logger_a_end= datenum('2019-05-10 13:00:00','yyyy-mm-dd HH:MM:SS');

logger_b_str= datenum('2019-05-04 16:00:00','yyyy-mm-dd HH:MM:SS');
logger_b_end= datenum('2019-05-10 17:00:00','yyyy-mm-dd HH:MM:SS');

%;logger offsets   
tcm_a_vel_cms=tcm_a_vel_cms-2.5;
tcm_b_vel_cms=tcm_b_vel_cms-2.5;

[ind_val_a ,~]=find(tcm_a_dt>logger_b_str & tcm_a_dt<logger_a_end);
[ind_val_b ,~]=find(tcm_b_dt>logger_b_str & tcm_b_dt<logger_a_end);

%current meter stats
mean(tcm_a_vel_cms(ind_val_a))
std(tcm_a_vel_cms(ind_val_a))
max(tcm_a_vel_cms(ind_val_a))
min(tcm_a_vel_cms(ind_val_a))


mean(tcm_b_vel_cms(ind_val_b))
std(tcm_b_vel_cms(ind_val_b))
max(tcm_b_vel_cms(ind_val_b))
min(tcm_b_vel_cms(ind_val_b))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load in core data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%TFYI-top
[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\MakeTables_and_Figs.xlsx','SITE A','H2:J17');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
TFYI_top_LabSalinity = data(:,1);
TFYI_top_DICumolkg = data(:,2);
TFYI_top_TAumolkg = data(:,3);
clearvars data raw R;

%TFYI-mid
[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\MakeTables_and_Figs.xlsx','SITE A','H21:J35');
data = reshape([raw{:}],size(raw));
TFYI_mid_LabSalinity = data(:,1);
TFYI_mid_DICumolkg = data(:,2);
TFYI_mid_TAumolkg = data(:,3);
clearvars data raw;

%TFYI-bot
[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\MakeTables_and_Figs.xlsx','SITE A','H40:J54');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
TFYI_bot_LabSalinity = data(:,1);
TFYI_bot_DICumolkg = data(:,2);
TFYI_bot_TAumolkg = data(:,3);
clearvars data raw R;

%POLY-top
[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\MakeTables_and_Figs.xlsx','SITE B','H2:K17');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
data = reshape([raw{:}],size(raw));
POLY_top_LabSalinity = data(2:end,1);
POLY_top_DICumolkg = data(2:end,2);
POLY_top_TAumolkg = data(2:end,3);
clearvars data raw R;

%POLY-mid
[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\MakeTables_and_Figs.xlsx','SITE B','H21:K35');
data = reshape([raw{:}],size(raw));
POLY_mid_LabSalinity = data(:,1);
POLY_mid_DICumolkg = data(:,2);
POLY_mid_TAumolkg = data(:,3);
clearvars data raw;

%POLY-bot
[~, ~, raw] = xlsread('C:\Users\rps207\Documents\Data\Field data\2019 - 05 - MAY - Sea ice core data\MakeTables_and_Figs.xlsx','SITE B','H40:J54');
data = reshape([raw{:}],size(raw));
POLY_bot_LabSalinity = data(:,1);
POLY_bot_DICumolkg = data(:,2);
POLY_bot_TAumolkg = data(:,3);
clearvars data raw;


%%%%%%%%%%%%%%%%%%%%%%%%

%% Figure 4 plot High res core TA/DIC/SAL
h1=figure(1);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
set(gcf,'color','w');
subplot(1,3,1)
plot(DIC_A,Depth_A,'-o','LineWidth',1.5,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
hold on
plot(DIC_B,Depth_B,'-o','LineWidth',1.5,'MarkerFaceColor',colour_crimson,'color',colour_crimson)
set(gca,'YDir','reverse')
ylabel('Icedepth (cm)','Fontsize',24); 
xlabel(['TIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
set(gca,'xaxisLocation','top')
set(gca,'FontSize',16)
set(gca,'FontSize',16)
text(-0.1,1.1,'(a)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
Legend=legend('TYFI','POLY','Location','East');set(Legend,'FontSize',12)

subplot(1,3,2)
plot(TA_A,Depth_A,'-o','LineWidth',1.5,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
hold on
plot(TA_B,Depth_B,'-o','LineWidth',1.5,'MarkerFaceColor',colour_crimson,'color',colour_crimson)
set(gca,'YDir','reverse')
ylabel('Icedepth (cm)','Fontsize',24); 
xlabel(['TA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
set(gca,'xaxisLocation','top')
set(gca,'FontSize',16)
set(gca,'FontSize',16)
text(-0.1,1.1,'(b)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
Legend=legend('TYFI','POLY','Location','East');set(Legend,'FontSize',12)

subplot(1,3,3)
plot(Sal_A,Depth_A,'-o','LineWidth',1.5,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
hold on
plot(Sal_B,Depth_B,'-o','LineWidth',1.5,'MarkerFaceColor',colour_crimson,'color',colour_crimson)
set(gca,'YDir','reverse')
ylabel('Icedepth (cm)','Fontsize',24); 
xlabel(['Salinity (PSU)'],'Fontsize',24);
set(gca,'xaxisLocation','top')
set(gca,'FontSize',16)
set(gca,'FontSize',16)
Legend=legend('TYFI','POLY','Location','East');set(Legend,'FontSize',12)
text(-0.1,1.1,'(c)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
saveas(h1,'C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure4_high_res_cores.jpg'); 
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure4_high_res_cores.eps'); 
%% plot High res core SITE A(TA/DIC/SAL) SITE B(TA/DIC/SAL)
figure(2)
set(gcf, 'Color','w','Position', get(0,'Screensize'));
subplot(1,2,1)
h1=plot(TA_A,Depth_A,'-ok','LineWidth',1.5);
hold on;
h2=plot(DIC_A,Depth_A,'-or','LineWidth',1.5);
set(gca,'YDir','reverse');
ylabel('Icedepth (cm)','Fontsize',24); 
xlabel(['TA/DIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
set(gca,'FontSize',16);
set(gca,'FontSize',16);
hAx(1)=gca;
hAx(2)=axes('Position',hAx(1).Position,'XAxisLocation','top','YAxisLocation','right','color','none');
hold(hAx(2),'on');
h3=plot(hAx(2),Sal_A,Depth_A,'-om','LineWidth',1.5);
legend([h1, h2, h3],'TA','DIC','Salinity','Location','East');
hold(hAx(2),'on');
set(gca,'YDir','reverse');
c=get(hAx(2),'XLabel');
set(c,'String','Salinity');
set(c,'Color','m');
set(c,'Fontsize',24);
set(gca,'FontSize',16);
set(hAx(2),'XColor','m')
set(hAx(2),'YTick',([]));


subplot(1,2,2)
h1=plot(TA_B,Depth_B,'-o','LineWidth',1.5);
hold on;
h2=plot(DIC_B,Depth_B,'-o','LineWidth',1.5);
set(gca,'YDir','reverse');
ylabel('Icedepth (cm)','Fontsize',24); 
xlabel(['TA/DIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
set(gca,'FontSize',16);
set(gca,'FontSize',16);
hAx(1)=gca;
hAx(2)=axes('Position',hAx(1).Position,'XAxisLocation','top','YAxisLocation','right','color','none');
hold(hAx(2),'on');
h3=plot(hAx(2),Sal_B,Depth_B,'-om','LineWidth',1.5);
legend([h1, h2, h3],'TA','DIC','Salinity','Location','East');
hold(hAx(2),'on');
set(gca,'YDir','reverse');
c=get(hAx(2),'XLabel');
set(c,'String','Salinity');
set(c,'Color','m');
set(c,'Fontsize',24);
set(gca,'FontSize',16);
set(hAx(2),'XColor','m')
set(hAx(2),'YTick',([]));
%% plot High res core SITE A(TA/DIC/SAL) SITE B(TA/DIC/SAL)
figure(3)
set(gcf, 'Color','w','Position', get(0,'Screensize'));
subplot(2,1,1)
h1=plot(Depth_B,TA_B,'-o','LineWidth',2);
xlh=xlabel(['Icedepth (cm)'],'Fontsize',24,'rotation',180);
% xlh.Position(2) = xlh.Position(2) - 0.06;
ylabel(['TA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
set(gca,'FontSize',16);
set(gca,'XTickLabelRotation',90)
set(gca,'YTickLabelRotation',90)
xlim([0 200])
ylim([0 1000])
hold on
h2=addaxis(Depth_B,DIC_B,'-o','LineWidth',2); 
hAx2=addaxislabel(2,['DIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
ylim(h2,[0 1000]);
set(hAx2,'Fontsize',24)
set(h2,'FontSize',16);
set(h2,'YTickLabelRotation',90);
h3=addaxis(Depth_B,Sal_B,'-o','LineWidth',2); 
hAx3=addaxislabel(3,'Salinity','Fontsize',24);
ylim(h3,[0 10]);
set(hAx3,'Fontsize',24)
set(h3,'FontSize',16);
set(h3,'YTickLabelRotation',90)

subplot(2,1,2)
h1=plot(Depth_A,TA_A,'-o','LineWidth',2);
xlh2=xlabel(['Icedepth (cm)'],'Fontsize',24,'rotation',180);
ylabel(['TA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
xlim([0 200])
ylim([0 1000])
set(gca,'FontSize',16);
set(gca,'XTickLabelRotation',90)
set(gca,'YTickLabelRotation',90)
hold on
h2=addaxis(Depth_A,DIC_A,'-o','LineWidth',2); 
hAx2=addaxislabel(2,['DIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
ylim(h2,[0 1000]);
set(hAx2,'Fontsize',24)
set(h2,'FontSize',16);
set(h2,'YTickLabelRotation',90)
h3=addaxis(Depth_A,Sal_A,'-o','LineWidth',2); 
hAx3=addaxislabel(3,'Salinity','Fontsize',24);
set(hAx3,'Fontsize',24)
set(h3,'FontSize',16);
set(h3,'YTickLabelRotation',90)
ylim(h3,[0 10])
%% plot High res core TA vs DIC
figure(4)
scatter(DIC_A,TA_A,50,Depth_A,'*');
hold on
scatter(DIC_B,TA_B,50,Depth_B,'o');
xlabel(['DIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
ylabel(['TA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
set(gca,'FontSize',16);
set(gca,'FontSize',16);
h=colorbar;
ylabel(h,'Ice depth (m)');
plot(200:800,200:800)
legend('A','B','Location','SouthEast')
%% plot High res core TA vs salinity
figure(5)
scatter(Sal_A,TA_A,50,Depth_A,'*');
hold on
scatter(Sal_B,TA_B,50,Depth_B,'o');
xlabel('Salinity','Fontsize',24);
ylabel(['TA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
set(gca,'FontSize',16);
set(gca,'FontSize',16);
h=colorbar;
ylabel(h,'Ice depth (m)');
legend('A','B','Location','SouthEast')
degree_symbol= sprintf('%c', char(176));
%% Figure 3 plot temperature cores
h6=figure(6);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
subplot(1,2,1)
plot(tempsal_siteA_May04_Temp,tempsal_siteA_May04_Depth,'-p','markersize',8,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue);
hold on
plot(tempsal_siteA_May07_Temp,tempsal_siteA_May07_Depth,'-s','markersize',8,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue);
plot(tempsal_siteA_May10_Temp,tempsal_siteA_May10_Depth,'-d','markersize',8,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue);

plot(tempsal_siteB_May04_Temp,tempsal_siteB_May04_Depth,'-p','markersize',8,'MarkerFaceColor',colour_crimson,'color',colour_crimson);
plot(tempsal_siteB_May07_Temp,tempsal_siteB_May07_Depth,'-s','markersize',8,'MarkerFaceColor',colour_crimson,'color',colour_crimson);
plot(tempsal_siteB_May10_Temp,tempsal_siteB_May10_Depth,'-d','markersize',8,'MarkerFaceColor',colour_crimson,'color',colour_crimson);
legend('TYFI - May 4th','TYFI - May 7th','TYFI - May 10th','POLY - May 4th','POLY - May 7th','POLY- May 10th');
xlabel(['Ice core temperature (',num2str(degree_symbol),'C)'],'Fontsize',24);
ylabel('Ice core depth (cm)','Fontsize',24);
set(gca,'FontSize',16);
set(gca,'FontSize',16);
set(gca, 'YDir','reverse')
saveas(h6,'C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure3_ice_cores_temps.jpg'); 
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure3_ice_cores_temps.eps')
%% Figure 5 plot ice and snow thickness transect
interp_icedepths=interp1(snow_trans_DistancefromT1km([ 1 3 5 7 9]),(snow_trans_IceThkcm([ 1 3 5 7 9])),snow_trans_DistancefromT1km);
h7=figure(7);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
subtightplot(2,1,1,[0.05 0.03],[0.15 0.15],[0.05 0.05])
snowarea=area(snow_trans_DistancefromT1km,(snow_trans_SnowDepthcm),'FaceColor',colour_offwhite);
hold on
scatter(snow_trans_DistancefromT1km,(snow_trans_SnowDepthcm),'o','MarkerFaceColor',colour_offwhite,'MarkerEdgeColor','k')
set(gca,'FontSize',16);
set(gca,'FontSize',16);
ylim([0 40])
ylabel('Snow depth (cm)','Fontsize',16);
set(gca,'xtick',[])
set(gca,'xticklabel',[])
text(snow_trans_DistancefromT1km(1)-0.13,35+zeros(1,1)', snow_trans_SiteLabel(1),'color','k','Fontsize',12,'Fontweight','bold','BackgroundColor','w'); 
text(snow_trans_DistancefromT1km(2:end-1),35+zeros(1,8)', snow_trans_SiteLabel(2:end-1),'color','k','Fontsize',12,'Fontweight','bold','BackgroundColor','w'); 
text(snow_trans_DistancefromT1km(end)+0.05,35+zeros(1,1)', snow_trans_SiteLabel(end),'color','k','Fontsize',12,'Fontweight','bold','BackgroundColor','w'); 
text(-0.05,1.1,'(a)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 

subtightplot(2,1,2,[0.05 0.03],[0.15 0.15],[0.05 0.05])
set(gcf, 'Position', get(0, 'Screensize'));
area(snow_trans_DistancefromT1km,interp_icedepths,'FaceColor',colour_seaice_blue);
hold on
scatter(snow_trans_DistancefromT1km,(snow_trans_IceThkcm),'MarkerFaceColor',colour_seaice_blue,'MarkerEdgeColor','k')
ylim([0 200])
xlabel(['Distance along transect (km)'],'Fontsize',24);
ylabel('Ice depth (cm)','Fontsize',16);
set(gca,'FontSize',16);
set(gca,'FontSize',16);
ylim([150 200])
set(gca,'YDir','reverse')
text(-0.05,1.1,'(b)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core//Figure5_snow_ice_depths_transect.eps'); 
%% Figure S2 plot AIR temperature 
weather_dtstr = datetime(weather_seaice_Year, weather_seaice_Month, weather_seaice_Day, 'Format', 'yyyy MM dd');  % First day of the year
weather_dt=datenum(weather_dtstr)+weather_seaice_TimeLST;
h8=figure(8);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
set(gca, 'XTick', 737546:1:737561,'FontSize',12)%every 2 days
x=[logger_a_end logger_b_str logger_b_str logger_a_end];
y= [ -25 -25 0 0];
patch(x,y,[224 224 224]/255);
hold on
plot(weather_dt,weather_seaice_TempC,'LineWidth',0.5,'color','k')
% set(gca,'XTickLabel',137:2:185) %ticks as DOY- can also use dateformat in newer matlab
datetick('x','mmm-dd', 'keepticks')
xlim([737546 737561]);
xlabel(['Time (mmm-dd)'],'Fontsize',24);
ylabel(['Air temperature (',num2str(degree_symbol),'C)'],'Fontsize',24);
set(gca,'FontSize',16);
set(gca,'FontSize',16);
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/FigureS2_icecores_air_temp.eps'); 
%% Figure S1 plot tides
tides_dt=datenum(tides_dateste);
samplingRateIncrease = 10;
newXSamplePoints = linspace(tides_dt(1), tides_dt(end), length(tides_dt) * samplingRateIncrease);
smoothedY = spline(tides_dt,Tidal_height, newXSamplePoints);

h9=figure(9);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
set(gca, 'XTick', 737536:1:737561,'FontSize',12)%every day
% plot(tides_dt,Tidal_height,'LineWidth',0.5,'color','k');
x=[logger_a_end logger_b_str logger_b_str logger_a_end];
y= [0.8 0.8 0 0];
patch(x,y,[224 224 224]/255);
hold on
plot(newXSamplePoints,smoothedY,'LineWidth',0.5,'color','k');
% set(gca,'XTickLabel',137:2:185) %ticks as DOY- can also use dateformat in newer matlab
datetick('x','mmm-dd', 'keepticks')
xlim([737546 737561]);
xlabel(['Time (mmm-dd)'],'Fontsize',24);
ylabel('Tidal height (m)','Fontsize',24);
ylim([0 0.8])
set(gca,'FontSize',16);
set(gca,'FontSize',16);
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/FigureS1_icecores_tides.eps'); 
%% Figure 2 plot tilt current meters
h10=figure(10);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
subplot(1,2,1)
plot(tcm_a_dt,tcm_a_vel_cms,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
set(gca, 'XTick', 737549:1:737555)
datetick('x','mmm-dd', 'keepticks')
xlabel('Time (mmm-dd)')
ylabel('Velocity (cms^{-1})')
title('TFYI')
set(gca,'FontSize',16);
set(gca,'FontSize',16);
ylim([0 50])
xlim([logger_b_str logger_a_end])
text(-0.12,1.05,'(a)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 


subplot(1,2,2)
plot(tcm_b_dt,tcm_b_vel_cms,'MarkerFaceColor',colour_crimson,'color',colour_crimson)
set(gca, 'XTick', 737549:1:737555)
datetick('x','mmm-dd', 'keepticks')
xlabel('Time (mmm-dd)')
ylabel('Velocity (cms^{-1})')
title('POLY')
set(gca,'FontSize',16);
set(gca,'FontSize',16);
xlim([logger_b_str logger_a_end])
ylim([0 50])
text(-0.12,1.05,'(b)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure2_tilt_current_meters.eps'); 
%% Figure 1 plot map of the sites and the snow depth transect
%run this figure twice to get the colormap legend to update!
h11=figure(11);
set(gcf,'Color','none', 'Position', get(0, 'Screensize'));
set(gcf,'color','none')   % Set background colour before m_image call
m_proj('Sinusoidal','lon',[-106.2 -104.9],'lat',[68.8 69.14]);  
clf
m_grid('linestyle','none','tickdir','out','fontsize',22, 'FontName','Helvetica','backcolor',[[0.0392200000000000 0 0.474510000000000]])
hold on
[CS,CH]=m_contourf(longcambridge,latcambridge,bathymetrycambridge',[-100 -90 -80 -70 -60 -50 -40 -30 -20 -10 0],'edgecolor','n','ShowText','on');
m=colormap([ m_colmap('water')]);
% p=m_contour(longcambridge,latcambridge,bathymetrycambridge',[-80:5:-15],'ShowText','on');
m_gshhs_f('patch',colour_darkkhaki);
m_gshhs('fr');  

[ax,h]=m_contfbar(0.9,[.25 .75],CS,CH,'levels','match','endpiece','yes','axfrac',.03);
ylabel(ax,'Depth (m)')
set(ax,'YTick',[ -100 -90 -80 -70 -60 -50 -40 -30 -20 -10 0])
caxis([-100 000]);
set(gcf,'color','w');
set(gca,'color',[0.737250000000000 0.901960000000000 1]);

%add Cambridge Bay town
[C,D]=m_ll2xy( -105.059401,69.124070);
line(C,D,'marker','o','markersize',4,'MarkerFaceColor','k','color','k');
[CC,D]=m_ll2xy( -105.129401,69.114070);
text(CC,D,['Cambridge' char(10) '  Bay'],'HorizontalAlignment', 'left','VerticalAlignment', 'bottom','fontsize',14, 'FontName','Helvetica');

%add Cambridge Bay weather station
[C,D]=m_ll2xy( -105.140000000000,69.1100000000000);
line(C,D,'marker','o','markersize',4,'MarkerFaceColor','k','color','k');
[CC,D]=m_ll2xy( -105.350000000000,69.1100000000000);
text(CC,D,['Weather station '],'HorizontalAlignment', 'left','VerticalAlignment', 'bottom','fontsize',14, 'FontName','Helvetica');

%add Finlayson islands
[C,D]=m_ll2xy( -106.03,69.07);
% line(C,D,'marker','o','markersize',4,'MarkerFaceColor','k','color','k');
[CC,D]=m_ll2xy( -106.03,69.07);
text(CC,D,['Finlayson Islands'],'HorizontalAlignment', 'left','VerticalAlignment', 'bottom','fontsize',14, 'FontName','Helvetica');

%add POLY
[C,D]=m_ll2xy(-105.65888,69.00667);
line(C,D,'marker','o','markersize',4,'MarkerFaceColor','k','color','k');
[CC,D]=m_ll2xy(-105.65888,69.00667);
text(CC,D,['TFYI'],'HorizontalAlignment', 'left','VerticalAlignment', 'bottom','fontsize',14, 'FontName','Helvetica');

%add TFYI
[C,D]=m_ll2xy(-105.836944, 68.999444);
line(C,D,'marker','o','markersize',4,'MarkerFaceColor','k','color','k');
[CC,D]=m_ll2xy(-105.836944, 68.999444);
text(CC,D,['POLY'],'HorizontalAlignment', 'left','VerticalAlignment', 'bottom','fontsize',14, 'FontName','Helvetica');



%add snow transect stations
for i=1:length(snow_trans_Lat)
[C,D]=m_ll2xy( str2double(snow_trans_Long(i)),str2double(snow_trans_Lat(i)));
line(C,D,'marker','square','markersize',4,'MarkerFaceColor','r','color','r');
% [CC,D]=m_ll2xy( str2double(snow_trans_Long(i)),str2double(snow_trans_Lat(i))-0.01);
% text(CC,D,snow_trans_SiteLabel(i),'HorizontalAlignment', 'left','VerticalAlignment', 'Bottom', 'Color','r','fontsize',5,'FontWeight','Bold');
end

set(gca,'fontsize',22, 'FontName','Helvetica')
y=ylabel(['Latitude (',num2str(degree_symbol),'N)']);
set(y,'Units','Normalized','Position',[-0.1,0.5,0]);
set(gca,'fontsize',22, 'FontName','Helvetica')
x=xlabel(['Longitude (',num2str(degree_symbol),'W)']);
set(gca,'fontsize',22, 'FontName','Helvetica')
set(x,'Units','Normalized','Position',[0.5,-0.05,0]);
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure1_Kitikmeot_map_ice_cores.eps'); 
%% Figure 7 plot TA and DIC relationship plot
h12=figure(12);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
subtightplot(2,2,1,[0.1 0.06],[0.12 0.05],[0.2 0.2])
plot(TFYI_top_LabSalinity,TFYI_top_DICumolkg,'s','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
hold on
plot(TFYI_mid_LabSalinity,TFYI_mid_DICumolkg,'d','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
plot(TFYI_bot_LabSalinity,TFYI_bot_DICumolkg,'o','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
h=plot(([0; 28.7959]),([0; 1970.97]),'k');
set(h,'linewidth',1);
xlabel('Salinity (PSU)','Fontsize',24); 
ylabel(['TIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
% title('TFYI')
set(gca,'FontSize',16)
set(gca,'FontSize',16)
ylim([200 700])
xlim([3 9])
text(-0.15,1.1,'(a)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
Legend=legend('TYFI - top','TYFI - mid','TYFI - bot','Location','NorthWest');set(Legend,'FontSize',12)

subtightplot(2,2,2,[0.1 0.06],[0.12 0.05 ],[0.2 0.2])
plot(POLY_top_LabSalinity,POLY_top_DICumolkg,'s','MarkerFaceColor',colour_crimson,'color',colour_crimson)
hold on
plot(POLY_mid_LabSalinity,POLY_mid_DICumolkg,'d','MarkerFaceColor',colour_crimson,'color',colour_crimson)
plot(POLY_bot_LabSalinity,POLY_bot_DICumolkg,'o','MarkerFaceColor',colour_crimson,'color',colour_crimson)
h=plot(([0; 28.7959]),([0; 1970.97]),'k');
set(h,'linewidth',1);
xlabel('Salinity (PSU)','Fontsize',24); 
ylabel(['TIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
% title('POLY')
set(gca,'FontSize',16)
set(gca,'FontSize',16)
ylim([200 700])
xlim([3 9])
text(-0.15,1.1,'(b)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
Legend=legend('POLY - top','POLY - mid','POLY - bot','Location','NorthWest');set(Legend,'FontSize',12)

subtightplot(2,2,3,[0.1 0.06],[0.12 0.05 ],[0.2 0.2])
plot(TFYI_top_LabSalinity,TFYI_top_TAumolkg,'s','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
hold on
plot(TFYI_mid_LabSalinity,TFYI_mid_TAumolkg,'d','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
plot(TFYI_bot_LabSalinity,TFYI_bot_TAumolkg,'o','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
h=plot(([0; 28.7959]),([0; 2058.00]),'k');
set(h,'linewidth',1);
xlabel('Salinity (PSU)','Fontsize',24); 
ylabel(['TA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
% title('TFYI')
set(gca,'FontSize',16)
set(gca,'FontSize',16)
ylim([200 700])
xlim([3 9])
text(-0.15,1.1,'(c)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
Legend=legend('TYFI - top','TYFI - mid','TYFI - bot','Location','NorthWest');set(Legend,'FontSize',12)

subtightplot(2,2,4,[0.1 0.06],[0.12 0.05],[0.2 0.2])
plot(POLY_top_LabSalinity,POLY_top_TAumolkg,'s','MarkerFaceColor',colour_crimson,'color',colour_crimson)
hold on
plot(POLY_mid_LabSalinity,POLY_mid_TAumolkg,'d','MarkerFaceColor',colour_crimson,'color',colour_crimson)
plot(POLY_bot_LabSalinity,POLY_bot_TAumolkg,'o','MarkerFaceColor',colour_crimson,'color',colour_crimson)
h=plot(([0; 28.7959]),([0; 2058.00]),'k');
set(h,'linewidth',1);
xlabel('Salinity (PSU)','Fontsize',24); 
ylabel(['TA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
% title('POLY')
set(gca,'FontSize',16)
set(gca,'FontSize',16)
ylim([200 700])
xlim([3 9])
text(-0.15,1.1,'(d)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
Legend=legend('POLY - top','POLY - mid','POLY - bot','Location','NorthWest');set(Legend,'FontSize',12)
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure7_TA_DIC_relationships.eps'); 
%% Figure 8 plot TA and DIC normalised plot
h13=figure(13);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
subplot(1,2,1)
plot((TFYI_top_DICumolkg./TFYI_top_LabSalinity)*28.7959,(TFYI_top_TAumolkg./TFYI_top_LabSalinity)*28.7959,'s','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
hold on
plot((TFYI_mid_DICumolkg./TFYI_mid_LabSalinity)*28.7959,(TFYI_mid_TAumolkg./TFYI_mid_LabSalinity)*28.7959,'d','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
plot((TFYI_bot_DICumolkg./TFYI_bot_LabSalinity)*28.7959,(TFYI_bot_TAumolkg./TFYI_bot_LabSalinity)*28.7959,'o','MarkerFaceColor',colour_darkblue,'color',colour_darkblue)
xlabel('Salinity (PSU)','Fontsize',24); 
ylim([1100 2300])
xlim([1100 2300])
set(gca,'FontSize',16)
set(gca,'FontSize',16)
Legend=legend('TYFI - top','TYFI - mid','TYFI - bot','Location','NorthWest');set(Legend,'FontSize',12)
text(-0.15,1.05,'(a)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
ylabel(['nTA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
xlabel(['nTIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);

subplot(1,2,2)
plot((POLY_top_DICumolkg./POLY_top_LabSalinity)*28.7959,(POLY_top_TAumolkg./POLY_top_LabSalinity)*28.7959,'s','MarkerFaceColor',colour_crimson,'color',colour_crimson)
hold on
plot((POLY_mid_DICumolkg./POLY_mid_LabSalinity)*28.7959,(POLY_mid_TAumolkg./POLY_mid_LabSalinity)*28.7959,'d','MarkerFaceColor',colour_crimson,'color',colour_crimson)
plot((POLY_bot_DICumolkg./POLY_bot_LabSalinity)*28.7959,(POLY_bot_TAumolkg./POLY_bot_LabSalinity)*28.7959,'o','MarkerFaceColor',colour_crimson,'color',colour_crimson)
xlabel('Salinity (PSU)','Fontsize',24); 
ylim([1100 2300])
xlim([1100 2300])
set(gca,'FontSize',16)
set(gca,'FontSize',16)
Legend=legend('POLY - top','POLY - mid','POLY - bot','Location','NorthWest');set(Legend,'FontSize',12)
text(-0.15,1.05,'(b)','color','k','Fontsize',20,'Fontweight','bold','BackgroundColor','none','units','normalized'); 
ylabel(['nTA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
xlabel(['nTIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure8_TA_DIC_normalised.eps'); 
%% Figure 9 plot deffreys rosette diagram of TA and DIC
h14=figure(14);
set(gcf,'Color','w', 'Position', get(0, 'Screensize'));
subtightplot(1,1,1,[],[0.12 0.01],[0.25 0.25])
set(gcf, 'Position', get(0, 'Screensize'));
plot(TFYI_top_DICumolkg.*28.7959./TFYI_top_LabSalinity,TFYI_top_TAumolkg.*28.7959./TFYI_top_LabSalinity,'s','markersize',8,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue);
hold on
plot(TFYI_mid_DICumolkg.*28.7959./TFYI_mid_LabSalinity,TFYI_mid_TAumolkg.*28.7959./TFYI_mid_LabSalinity,'d','markersize',8,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue);
plot(TFYI_bot_DICumolkg.*28.7959./TFYI_bot_LabSalinity,TFYI_bot_TAumolkg.*28.7959./TFYI_bot_LabSalinity,'o','markersize',8,'MarkerFaceColor',colour_darkblue,'color',colour_darkblue);


plot(POLY_top_DICumolkg.*28.7959./POLY_top_LabSalinity,POLY_top_TAumolkg.*28.7959./POLY_top_LabSalinity,'s','markersize',8,'MarkerFaceColor',colour_crimson,'color',colour_crimson);
plot(POLY_mid_DICumolkg.*28.7959./POLY_mid_LabSalinity,POLY_mid_TAumolkg.*28.7959./POLY_mid_LabSalinity,'d','markersize',8,'MarkerFaceColor',colour_crimson,'color',colour_crimson);
plot(POLY_bot_DICumolkg.*28.7959./POLY_bot_LabSalinity,POLY_bot_TAumolkg.*28.7959./POLY_bot_LabSalinity,'o','markersize',8,'MarkerFaceColor',colour_crimson,'color',colour_crimson);
Legend=legend('TYFI - top','TYFI - mid','TYFI - bot','POLY - top','POLY - mid','POLY - bot','Location','SouthEast');set(Legend,'FontSize',12)

normal_dic_TFYI=[TFYI_top_DICumolkg.*28.7959./TFYI_top_LabSalinity; TFYI_mid_DICumolkg.*28.7959./TFYI_mid_LabSalinity; TFYI_bot_DICumolkg.*28.7959./TFYI_bot_LabSalinity];
normal_ta_TFYI=[TFYI_top_TAumolkg.*28.7959./TFYI_top_LabSalinity; TFYI_mid_TAumolkg.*28.7959./TFYI_mid_LabSalinity; TFYI_bot_TAumolkg.*28.7959./TFYI_bot_LabSalinity];
 c = polyfit(normal_dic_TFYI([2:44 46]),normal_ta_TFYI([2:44 46]),1);
% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))]) %
x=(1000:1:2500);
y=(x*c(1))+ c(2); %
plot(x,y,'color',colour_crimson,'markersize',8)

normal_dic_POLY=[POLY_top_DICumolkg.*28.7959./POLY_top_LabSalinity; POLY_mid_DICumolkg.*28.7959./POLY_mid_LabSalinity; POLY_bot_DICumolkg.*28.7959./POLY_bot_LabSalinity];
normal_ta_POLY=[POLY_top_TAumolkg.*28.7959./POLY_top_LabSalinity; POLY_mid_TAumolkg.*28.7959./POLY_mid_LabSalinity; POLY_bot_TAumolkg.*28.7959./POLY_bot_LabSalinity];
 c = polyfit(normal_dic_POLY,normal_ta_POLY,1);
% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))]) %
x=(1000:1:2500);
y=(x*c(1))+ c(2); %
plot(x,y,'color',colour_darkblue,'markersize',8)

%add ad TA/DIC arrow
p1 = [1700+223.6 1400];                         % First Point
p2 = [1700-+223.6 1400];                         % Second Point
dp = p2-p1;                         % Difference
quiver(p1(1),p1(2),dp(1),dp(2),0,'k','LineWidth',2,'MaxHeadSize',0.4)
quiver(p2(1),p2(2),dp(1)*-1,dp(2)*-1,0,'k','LineWidth',2,'MaxHeadSize',0.4)
text(p1(1)-100,p1(2)+40, sprintf('CO_2 invasion',p1))
text(p2(1),p2(2)-40, sprintf('CO_2 release',p2))

p1 = [1800 1600];                         % First Point
p2 = [1600 1200];                         % Second Point
dp = p2-p1;                         % Difference
quiver(p1(1),p1(2),dp(1),dp(2),0,'k','LineWidth',2,'MaxHeadSize',0.4)
quiver(p2(1),p2(2),dp(1)*-1,dp(2)*-1,0,'k','LineWidth',2,'MaxHeadSize',0.4)
text(p1(1)-100,p1(2)+40, sprintf('CaCO_3 dissolution',p1))
text(p2(1),p2(2)-40, sprintf('CaCO_3 formation',p2))


%add ad TA/DIC arrow
p1 = [1700+223.6 1400+(-223.6*(17/106))];                         % First Point
p2 = [1700-223.6 1400-(-223.6*(17/106))];                         % Second Point
dp = p2-p1;                         % Difference
quiver(p1(1),p1(2),dp(1),dp(2),0,'k','LineWidth',2,'MaxHeadSize',0.4)
quiver(p2(1),p2(2),dp(1)*-1,dp(2)*-1,0,'k','LineWidth',2,'MaxHeadSize',0.4)
text(p1(1)-100,p1(2)-40, sprintf('Respiration',p1))
text(p2(1),p2(2)+40, sprintf('Photosynthesis',p2))

ylim([1100 2300])
xlim([1100 2300])
set(gca,'FontSize',16)
set(gca,'FontSize',16)
ylabel(['nTA ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
xlabel(['nTIC ' '(',num2str(micro_symbol),'mol kg^{-1})'],'Fontsize',24);
export_fig('eps','C:\Users\rps207\Documents\Research Papers, Books, Thesises, Course and Lecture Notes\My Papers\2020 - Calgary postdoc - Araleigh ice core/Figure9_deffreys rosette diagram.eps'); 
















