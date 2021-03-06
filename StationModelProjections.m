function [baseline_model, P, stationTempAnom, stationMovMeanAnom] = StationModelProjections(station_number)

% StationModelProjections Analyze modeled future temperature projections at individual stations
%===================================================================
%
% USAGE:  [OUTPUTS] = StationModelProjections(INPUTS) <--update here
%
% DESCRIPTION:
%   **Add your description here**
%
% INPUT:
%    staton_number: Number of the station from which to analyze historical temperature data
%    **Describe any other inputs you choose to include**
%
% OUTPUT:
%    baseline_model: [mean annual temperature over baseline period
%       (2006-2025); standard deviation of temperature over baseline period]
%    P: slope and intercept for a linear fit to annual mean temperature
%       values over the full 21st century modeled period
%   **list any other outputs you choose to include**
%
% AUTHOR: Parker Walsh and Rosa Miller
%
% REFERENCE:
%    Written for EESC 4464: Environmental Data Exploration and Analysis, Boston College
%    Data are from the a global climate model developed by the NOAA
%       Geophysical Fluid Dynamics Laboratory (GFDL) in Princeton, NJ - output
%       from the A2 scenario extracted by Sarah Purkey for the University of
%       Washington's Program on Climate Change
%==================================================================

%% Read and extract the data from your station from the csv file
filename = ['model' num2str(station_number) '.csv'];
%Extract the year and annual mean temperature data
%<--

station = readmatrix(filename);

%% Calculate the mean and standard deviation of the annual mean temperatures
%  over the baseline period over the first 20 years of the modeled 21st
%  century (2006-2025) - if you follow the template for output values I
%  provided above, you will want to combine these together into an array
%  with both values called baseline_model
 %<-- (this will take multiple lines of code - see the procedure you
 %followed in Part 1 for a reminder of how you can do this)

 baselineStart = 2006;
 baselineFin = 2025;
 
 n = 1;
 for i = 1:length(station)
        for j = baselineStart:baselineFin
        if station(i,1) == j  
        meanBase(n,1) = station(i,2);
        n = n +1;
        end
        end
 end
    
baseline_model = [mean(meanBase) std(meanBase)];

%% Calculate the 5-year moving mean smoothed annual mean temperature anomaly over the modeled period
% Note that you could choose to provide these as an output if you want to
% have these values available to plot.
 %<-- anomaly
 
 for i = 1:length(station)
  stationTempAnom(i,1) = station(i,2) - mean(meanBase);
 end
 %<-- smoothed anomaly
 stationMovMeanAnom = movmean(stationTempAnom(:),5);

 
%% Calculate the linear trend in temperature this station over the modeled 21st century period
 %<--
P = polyfit(station(:,1),station(:,2),1);

end