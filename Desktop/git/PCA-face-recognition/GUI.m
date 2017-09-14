
function varargout = GUI(varargin)

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 21-Nov-2016 20:22:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);





% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes on button press in Train_Button.
function Train_Button_Callback(hObject, eventdata, handles)

disp('Train Button Pressed')

[PCA_Train, PCA_Test] = prepareTrainAndTest(evalin('base', 'Original_Image_Train'),evalin('base', 'Feature_Train'),evalin('base', 'Original_Image_Test'),evalin('base', 'Feature_Test'));

%Set up the Result list and is image
set(handles.Find_list,'string',evalin('base','Name_Test'));
set(hObject,'UserData',{PCA_Train PCA_Test});



% --- Executes on selection change in Find_list.
function Find_list_Callback(hObject, eventdata, handles)

%get the image index and load it
index=get(handles.Find_list,'value');
Im=evalin('base','Image_Test');
imshow(Im{index}, 'Parent', handles.Find_im);

% Store the PCA Test Image as a variable of this object
set(hObject,'UserData',index);


% --- Executes during object creation, after setting all properties.
function Find_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in Result_list.
function Result_list_Callback(hObject, eventdata, handles)

%Get the number of the image
index=get(handles.Result_list,'value');
data = findobj('Tag','Find_button');
Face_number=get(data,'UserData');
Im_index=Face_number(index);

%Display it
Im=evalin('base','Image_Train');
imshow(Im{Im_index}, 'Parent', handles.Result_im);

% --- Executes during object creation, after setting all properties.
function Result_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in Find_button.
function Find_button_Callback(hObject, eventdata, handles)

%Get the index of the picture
index=get(handles.Find_list,'value');

%Get the PCA projected Image
data=findobj('Tag','Train_Button');
PCA=get(data,'UserData');
PCA_Train=PCA{1};
PCA_Test=PCA{2};

%Do the recognition
num_eigenvalues = evalin('base','num_eigenvalues');
Face = recogniseFace(index, evalin('base','Name_Test'), PCA_Test, evalin('base','Name_Train'),PCA_Train, num_eigenvalues);

Name=evalin('base','Name_Train');

%Prepare the output list
clear Text;
for i=1:length(Face)
    percentage{i}=num2str(round(Face(i,3))); 
    Text(i)=strcat(Name(Face(i,2)),'   => ',percentage(i),'%');
end

%Set the list
set(handles.Result_list,'string',Text);


%Update image in result_list
Im_index=Face(1,2);
%Display it in result window
Im=evalin('base','Image_Train');
imshow(Im{Im_index}, 'Parent', handles.Result_im);
%Update selected item in result_list
set(handles.Result_list,'Value',1)

%Store the Result
set(hObject,'UserData',Face(:,2))
