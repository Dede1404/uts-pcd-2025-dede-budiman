function varargout = main(varargin)
% GUI untuk konversi dan deteksi tepi citra
% Dibuat oleh: [Nama 1] dan [Nama 2]

% --- Inisialisasi GUI ---
gui_Singleton = 1;
gui_State = struct('gui_Name', mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Fungsi saat GUI dibuka ---
function main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Output utama ---
function varargout = main_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Tombol Load Image ---
function btnLoad_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp'}, 'Pilih Citra');
if isequal(filename,0)
    return;
end
handles.citra = imread(fullfile(pathname, filename));
axes(handles.axes1);
imshow(handles.citra);
title('Citra Asli');
guidata(hObject, handles);

% --- Tombol Convert to Grayscale ---
function btnGray_Callback(hObject, eventdata, handles)
gray = rgb2gray(handles.citra);
axes(handles.axes2);
imshow(gray);
title('Citra Grayscale');
handles.gray = gray;
guidata(hObject, handles);

% --- Tombol Edge Detection (Sobel) ---
function btnEdge_Callback(hObject, eventdata, handles)
if isfield(handles, 'gray')
    edgeImg = edge(handles.gray, 'sobel');
    axes(handles.axes2);
    imshow(edgeImg);
    title('Deteksi Tepi (Sobel)');
    handles.edge = edgeImg;
    guidata(hObject, handles);
else
    msgbox('Silakan ubah ke grayscale terlebih dahulu', 'Peringatan', 'warn');
end
