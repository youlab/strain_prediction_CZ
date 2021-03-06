%{
This code is used to extract data from tecan platereader, blank the data,
save as matfile.
Each row in mat file is time sequence of 1 well / the growth curve of 1
strain.
1 strain has 6 replicates.
%}

clear;clc;

% load data with maximum range
filename = {
%     '05262018_resistome_longterm_TS30_1-1.xlsx',...
%     '05272018_resistome_longterm_TS30_1-2.xlsx',...
%     '05282018_resistome_longterm_TS30_2-1.xlsx',...
%     '05292018_resistome_longterm_TS30_2-2.xlsx',...
%     '06082018_resistome_longterm_TS30_3-1.xlsx',...
    '06192018_resistome_longterm_TS30_3-2.xlsx',...
%     '06242018_resistome_longterm_TS30_4-1.xlsx',...
%     '06262018_resistome_longterm_TS30_4-2.xlsx',...
%     '06282018_resistome_longterm_TS30_5-1.xlsx',...
%     '06282018_resistome_longterm_TS30_5-2.xlsx',...
%     '07032018_resistome_longterm_TS30_6-1.xlsx',...
%     '07172018_resistome_longterm_TS30_6-2.xlsx',...
%     '07202018_resistome_longterm_TS30_7-1.xlsx',...
%     '07202018_resistome_longterm_TS30_7-2.xlsx',...
%     '07312018_resistome_longterm_TS30_8-1.xlsx',...
%     '08312018_resistome_longterm_TS30_8-2.xlsx',...
%     '09032018_resistome_longterm_TS30_9-2.xlsx',...
%     '09042018_resistome_longterm_TS30_10-1.xlsx',...
%     '09052018_resistome_longterm_TS30_10-2.xlsx',...
%     '09072018_resistome_longterm_TS30_11-2.xlsx',...
%     '09192018_resistome_longterm_TS30_12-1.xlsx',...
%     '09202018_resistome_longterm_TS30_13-2.xlsx',...
%     '09242018_resistome_longterm_TS30_15-2.xlsx',...
%     '09252018_resistome_longterm_TS30_16-2.xlsx',...
%     '09262018_resistome_longterm_TS30_17-2.xlsx',...
%     '09272018_resistome_longterm_TS30_18-2.xlsx',...
%     '09282018_resistome_longterm_TS30_19-2.xlsx',...
%     '09292018_resistome_longterm_TS30_20-2.xlsx',...
%     '10022018_resistome_longterm_TS30_22-2.xlsx',...
%     '10102018_resistome_longterm_TS30_24-2.xlsx',...
%     '10112018_resistome_longterm_TS30_25-2.xlsx',...
%     '10122018_resistome_longterm_TS30_26-2.xlsx',...
%     '10132018_resistome_longterm_TS30_27-2.xlsx',...
%     '10142018_resistome_longterm_TS30_28-2.xlsx',...
%     '10152018_resistome_longterm_TS30_29-2.xlsx',...
%     '10152018_resistome_longterm_TS30_29-3-2.xlsx',...
%     '10152018_resistome_longterm_TS30_29-3.xlsx',...
%     '10172018_resistome_longterjm_TS30_30-1.xlsx',...
%     '10172018_resistome_longterm_TS30_30-2.xlsx',...
%     '10212018_resistome_longterm_TS30_33-2.xlsx',...
%     '10232018_resistome_longterm_TS30_34-2.xlsx',...
%     '10242018_resistome_longterm_TS30_35-2.xlsx',...
%     '10252018_resistome_longterm_TS30_36-2.xlsx',...
%     '10262018_resistome_longterm_TS30_37-2.xlsx',...
%     '10272018_resistome_longterm_TS30_38-1.xlsx',...
%     '10282018_resistome_longterm_TS30_38-2.xlsx',...
%     '10292018_resistome_longterm_TS30_39-2.xlsx',...
%     '10302018_resistome_longterm_TS30_40-2.xlsx',...
%     '11022018_resistome_longterm_TS30_41-2.xlsx',...
%     '11052018_resistome_longterm_TS30_42-2.xlsx',...
%     '11132018_resistome_longterm_TS30_43-2.xlsx',...
%     '11152018_resistome_longterm_TS30_44-2.xlsx',...
%     '11192018_resistome_longterm_TS30_45-2.xlsx',...
%     '11222018_resistome_longterm_TS30_46-2.xlsx',...
%     '11252018_resistome_longterm_TS30_47-2.xlsx',...
%     '11292018_resistome_longterm_TS30_48-2.xlsx',...
%     '12122018_resistome_longterm_TS30_51-2.xlsx',...
%     '12172018_resistome_longterm_TS30_52-2.xlsx',...
%     '12192018_resistome_longterm_TS30_53-2.xlsx',...
    };

filenum = length(filename);

newname = {
%     '1-1.mat'...
%     '1-2.mat'...
%     '2-1.mat'...
%     '2-2.mat'...
%     '3-1.mat'...
    '3-2.mat'...
%     '4-1.mat'...
%     '4-2.mat'...
%     '5-1.mat'...
%     '5-2.mat'...
%     '6-1.mat'...
%     '6-2.mat'...
%     '7-1.mat'...
%     '7-2.mat'...
%     '8-1.mat'...
%     '8-2.mat'...
%     '9-2.mat'...
%     '10-1.mat'...
%     '10-2.mat'...
%     '11-2.mat'...
%     '12-1.mat'...
%     '13-2.mat'...
%     '15-2.mat'...
%     '16-2.mat'...
%     '17-2.mat'...
%     '18-2.mat'...
%     '19-2.mat'...
%     '20-2.mat'...
%     '22-2.mat'...
%     '24-2.mat'...
%     '25-2.mat'...
%     '26-2.mat'...
%     '27-2.mat'...
%     '28-2.mat'...
%     '29-2.mat'...
%     '29-3-2.mat'...
%     '29-3.mat'...
%     '30-1.mat'...
%     '30-2.mat'...
%     '33-2.mat'...
%     '34-2.mat'...
%     '35-2.mat'...
%     '36-2.mat'...
%     '37-2.mat'...
%     '38-1.mat'...
%     '38-2.mat'...
%     '39-2.mat'...
%     '40-2.mat'...
%     '41-2.mat'...
%     '42-2.mat'...
%     '43-2.mat'...
%     '44-2.mat'...
%     '45-2.mat'...
%     '46-2.mat'...
%     '47-2.mat'...
%     '48-2.mat'...
%     '51-2.mat'...
%     '52-2.mat'...
%     '53-2.mat'...
};

for n = 1:filenum
    xlrange = 'A34:CV134';
    data = xlsread(filename{n},xlrange);
    N = size(data,1); %get row num

    % delete invalid data
    for k = 1:N
        if data(k,2) > 1
            data(k,:) = 0;
        end
    end
    % remove all zeros rows
    data( ~any(data,2),:) = [];
    M = size(data,1);

    %blank data
    blank = mean(data(M-5:M,:));
    data = data - blank;
    %remove blank row
    data = data(1:M-6,:);
    save(newname{n},'data');
end
