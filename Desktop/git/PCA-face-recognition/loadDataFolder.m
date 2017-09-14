function [Images, Features, Names] = loadDataFolder(folder)
%loadDataFolder Summary of this function goes here
%   Detailed explanation goes here

files = dir(strcat(folder,'*.', 'jpg'));

if isunix  %Unix is case sensitive for file extensions
    filesJPG = dir(strcat(folder,'*.', 'JPG'));
    files = vertcat(files, filesJPG);
end

if ismac
    warning('Dir function not tested for mac, files could be loaded two times');
end

%Initialize outputs
Names = cell(1, length(files));
Images = cell(1, length(files));
Features = cell(1, length(files));

for i = 1:length(files)
    IM=imread(strcat(folder,files(i).name));  %store the image
    feature_filename = strcat(regexprep(files(i).name, '\.[^\.]*$', ''),'.', 'txt') ;
    textfile = importdata(strcat(folder, feature_filename));%Get the text files
   
    if isstruct(textfile) == 0
        Features{i} = textfile;
        Images{i}=(rgb2gray(IM));
        str=regexprep(files(i).name, '\.[^\.]*$', '') ;   % get ride of the extension
        str=regexprep(str,'[0 1 2 3 4 5 6 7 8 9]','');
        Names{i}=str; %store the name
    end 
end

% get ride of empty cells
emptyCells = cellfun(@isempty,Images) | cellfun(@isempty,Features);
Images(emptyCells) = [];
Features(emptyCells) = [];
Names(emptyCells)=[];

end

