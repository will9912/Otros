function varargout = gui03(varargin)
% GUI03 MATLAB code for gui03.fig
%      GUI03, by itself, creates a new GUI03 or raises the existing
%      singleton*.
%
%      H = GUI03 returns the handle to a new GUI03 or the handle to
%      the existing singleton*.
%
%      GUI03('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI03.M with the given input arguments.
%
%      GUI03('Property','Value',...) creates a new GUI03 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui03_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui03_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui03

% Last Modified by GUIDE v2.5 07-Dec-2019 22:24:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui03_OpeningFcn, ...
                   'gui_OutputFcn',  @gui03_OutputFcn, ...
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


% --- Executes just before gui03 is made visible.
function gui03_OpeningFcn(hObject, eventdata, handles, varargin)
a = imread('back.jpg')
axes(handles.axes4);
image(a)
axis off
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui03 (see VARARGIN)

% Choose default command line output for gui03
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui03 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui03_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btninicio.
function btninicio_Callback(hObject, eventdata, handles)
% hObject    handle to btninicio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ini
ini = 1;
video(hObject, eventdata, handles)


% --- Executes on button press in btncapturar.
function btncapturar_Callback(hObject, eventdata, handles)
% hObject    handle to btncapturar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cap
cap =1
video(hObject, eventdata, handles)


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global nivel
nivel=get(handles.slider2,'value');

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function video( hObject, eventdata, handles )
global ini
global cap
global RGB
if ini ==1
     vid = videoinput('winvideo',1,'YUY2_320x240');
     triggerconfig(vid,'manual');
     start(vid)
     ini=0;
     while 1
        axes(handles.axes1)
        snapshot=getsnapshot(vid);
        RGB=ycbcr2rgb(snapshot);
        imshow(RGB)
        if cap == 1
            break;
        end
     end
     cap=0;
     axes(handles.axes1)
     imshow(RGB)
     tam=size(RGB);
     set(handles.text1,'string',strcat(('Tamaño: '),int2str(tam(1,1)),'x',int2str(tam(1,2))));
     delete(vid)
     binarizacion(hObject, eventdata, handles)
end

function binarizacion( hObject, eventdata, handles )
slider2_Callback(hObject, eventdata, handles)
global RGB
global ini
global nivel
imagen = rgb2gray(RGB);
nivel = 0.2;
while 1
    axes(handles.axes2)
    binarizada = imbinarize(imagen,nivel);
    imshow(binarizada)
    if ini==1
        break;
    end
end
video( hObject, eventdata, handles )


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
close(gui03);
gui01
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
