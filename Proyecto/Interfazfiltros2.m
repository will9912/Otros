function varargout = Interfazfiltros2(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interfazfiltros2_OpeningFcn, ...
                   'gui_OutputFcn',  @Interfazfiltros2_OutputFcn, ...
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


% --- Executes just before Interfazfiltros2 is made visible.
function Interfazfiltros2_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interfazfiltros2 (see VARARGIN)

% Choose default command line output for Interfazfiltros2
handles.output = hObject;
handles.myImage = []; 
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interfazfiltros2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interfazfiltros2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cargarimagen.
function cargarimagen_Callback(hObject, eventdata, handles)
% hObject    handle to cargarimagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.myImage = imread('otra.jpg');
    image(handles.myImage, 'Parent', handles.axes1);

    guidata(hObject, handles);


% --- Executes on selection change in menu1.
function menu1_Callback(hObject, eventdata, handles)
% hObject    handle to menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu1
guidata(hObject, handles);
v=get(handles.menu1,'value');
switch v
    case 1
        imshow(handles.myImage, 'Parent', handles.axes2);
    case 2
        image4=handles.myImage;
        image41(:,:,1)=image4(:,:,1);
        image41(:,:,2)=0;
        image41(:,:,3)=0;
        image(image41, 'Parent', handles.axes2);
    case 3
        image5=handles.myImage;
        image51(:,:,2)=image5(:,:,2);
        image51(:,:,1)=0;       
        image51(:,:,3)=0;
        image(image51, 'Parent', handles.axes2); 
    case 4
        image6=handles.myImage;
        image61(:,:,3)=image6(:,:,3);
        image61(:,:,1)=0;
        image61(:,:,2)=0;        
        image(image61, 'Parent', handles.axes2);

    case 5   
        imagebw=im2bw(handles.myImage,0.5);
        imshow(imagebw, 'Parent', handles.axes2);
        
    case 6        
        im_gray=rgb2gray(handles.myImage);
        imshow(im_gray, 'Parent', handles.axes2);
    case 7
        im_gray2=rgb2gray(handles.myImage);
        im_edge=edge(im_gray2,'sobel');
        imshow(im_edge, 'Parent', handles.axes2);
    case 8
        im_gray3=imnoise(handles.myImage, 'salt & pepper');
        imshow(im_gray3, 'Parent', handles.axes2);
    otherwise
        im_gray4=rgb2gray(handles.myImage);
        im_gray5=imnoise(im_gray4, 'salt & pepper');
        imshow(im_gray5, 'Parent', handles.axes2);  
end

% --- Executes during object creation, after setting all properties.
function menu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in menu2.
function menu2_Callback(hObject, eventdata, handles)
% hObject    handle to menu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu2
guidata(hObject, handles);
v=get(handles.menu2,'value');
        im_gray7=rgb2gray(handles.myImage);
        im_gray8=imnoise(im_gray7, 'salt & pepper');
        
switch v
    case 1
        im_filt=medfilt2(im_gray8);
        imshow(im_filt, 'Parent', handles.axes4);
    case 2
        filtro=1/9*[1 1 1;1 1 1;1 1 1];
        filtro_suavizado=filter2(filtro,double(im_gray8));
        image(filtro_suavizado, 'Parent', handles.axes4);
    case 3  
        imshow(im_gray8, 'Parent', handles.axes4);   
    otherwise
        im_filt2=medfilt2(im_gray8);
        filtro3=1/9*[1 1 1;1 1 1;1 1 1];
        filtro_suavizado2=filter2(filtro3,double(im_filt2));
        image(filtro_suavizado2, 'Parent', handles.axes4);
        
end


% --- Executes during object creation, after setting all properties.
function menu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
close(Interfazfiltros2);
gui01
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
