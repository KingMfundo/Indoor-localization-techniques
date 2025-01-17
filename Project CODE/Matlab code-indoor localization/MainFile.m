%M MBAMBO-UJ 219082825
function varargout = MainFile(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainFile_OpeningFcn, ...
                   'gui_OutputFcn',  @MainFile_OutputFcn, ...
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


% --- Executes just before MainFile is made visible.
function MainFile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainFile (see VARARGIN)

% Choose default command line output for MainFile
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainFile wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainFile_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global s Err mobileLocEst mobileLoc anchorLoc EstMobileLoc  distanceEst distanceDrv 
if s==1
 No_of_anc_siso = 1; 
 No_of_mob_siso = 1;
 networkSize = 100; 
 anchorLoc   =[networkSize networkSize];
    mobileLoc  = networkSize*rand(No_of_mob_siso,2);
        distance = zeros(No_of_anc_siso,1);
        for n = 1 : No_of_anc_siso
            for m=1:No_of_mob_siso
                distance(n) = sqrt( (anchorLoc(n,1)-mobileLoc(m,1)).^2 + ...
                                            (anchorLoc(n,2)-mobileLoc(m,2)).^2  );
            end
        end
    figure,
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    numOfIteration = 5;
    mobileLocEst = networkSize*rand(1,2);
    for i = 1 : numOfIteration
        distanceEst   = sqrt(sum( (anchorLoc - repmat(mobileLocEst,No_of_anc_siso,1)).^2 , 2));
        distanceDrv   = [(mobileLocEst(1)-anchorLoc(:,1))./distanceEst ... 
                         (mobileLocEst(2)-anchorLoc(:,2))./distanceEst]; 
        EstMobileLoc{i}=mobileLocEst;
    end
    axes(handles.axes1),
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    hold on,
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    hold on;
    plot(EstMobileLoc{1}(:,1),EstMobileLoc{1}(:,2),'ro','MarkerSize',12,'lineWidth',2);
    Err = (sqrt(sum((mobileLocEst-mobileLoc(1,:)).^2))/5);
    title(['Estimation error is ',num2str(Err),'meter'])
    load local
figure,
xlim([1 6]);
ylim([0 20]);
plot(varyx,vary1,'b^-');
hold on;
plot(varyx,vary2,'rh-');
hold on;
plot(varyx,vary3,'go-');
hold on;
title('Multilateration algorithm with SISO model');
xlabel('Standard deviation(db)');
ylabel('Average localization error(meters)');
legend('Multilateration,SISO,P1','Multilateration,SISO,P2' ,'Multilateration,SISO,P3');
grid on;
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

global s
s=get(handles.popupmenu1,'value');

if s==2
    Main1
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s Err mobileLocEst mobileLoc anchorLoc EstMobileLoc distanceEst distanceDrv 
if s==1
 No_of_anc_simo = 1; 
  No_of_mob_simo  = 3; 
     networkSize = 100; 
    
    anchorLoc   =[networkSize networkSize];
    mobileLoc  = networkSize*rand(No_of_mob_simo,2);
        distance = zeros(No_of_anc_simo,1);
        for n = 1 : No_of_anc_simo
            for m=1:No_of_mob_simo
                distance(n) = sqrt( (anchorLoc(n,1)-mobileLoc(m,1)).^2 + ...
                                            (anchorLoc(n,2)-mobileLoc(m,2)).^2  );
            end
        end
    figure,
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    numOfIteration = 5;
    mobileLocEst = networkSize*rand(No_of_mob_simo,2);
    for i = 1 : numOfIteration
        for mm=1:No_of_mob_simo
        distanceEst   = sqrt(sum( (anchorLoc - repmat(mobileLocEst(mm,:),No_of_anc_simo,1)).^2 , 2));
        distanceDrv   = [(mobileLocEst(mm,1)-anchorLoc(:,1))./distanceEst ... 
                         (mobileLocEst(mm,2)-anchorLoc(:,2))./distanceEst];       
        EstMobileLoc{i}=mobileLocEst;
        end
    end
    axes(handles.axes2),
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    hold on;
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    hold on;
    plot(EstMobileLoc{1}(:,1),EstMobileLoc{1}(:,2),'ro','MarkerSize',12,'lineWidth',2);
    Err = (sqrt(sum((mobileLocEst(:)-mobileLoc(:)).^2))/5);
    title(['Estimation error is ',num2str(Err),'meter'])
    load local
    figure,
xlim([1 6]);
ylim([0 9]);
plot(varyx,vary4,'b^-');
hold on;
plot(varyx,vary5,'rh-');
hold on;
plot(varyx,vary6,'go-');
hold on;
title('Multilateration algorithm with SIMO model');
xlabel('Standard deviation(db)');
ylabel('Average localization error(meters)');
legend('Multilateration,SIMO,P1','Multilateration,SIMO,P2' ,'Multilateration,SIMO,P3');
grid on;
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s Err mobileLocEst mobileLoc anchorLoc EstMobileLoc distanceEst distanceDrv 
if s==1
 No_of_anc_miso = 4;  
   No_of_mob_miso= 1;  
     networkSize = 100; 
    
    anchorLoc   =[0                     0; 
                   networkSize           0;
                   0           networkSize;
                   networkSize networkSize];
    mobileLoc  = networkSize*rand(No_of_mob_miso,2);
        distance = zeros(No_of_anc_miso,1);
        for n = 1 : No_of_anc_miso
            for m=1:No_of_mob_miso
                distance(n) = sqrt( (anchorLoc(n,1)-mobileLoc(m,1)).^2 + ...
                                            (anchorLoc(n,2)-mobileLoc(m,2)).^2  );
            end
        end
    figure,
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
   numOfIteration = 5;
    mobileLocEst = networkSize*rand(No_of_mob_miso,2);
    for i = 1 : numOfIteration
        for nn=1:No_of_anc_miso
        distanceEst   = sqrt(sum( (anchorLoc(nn,:)- repmat(mobileLocEst,No_of_mob_miso,1)).^2 , 2));
        distanceDrv   = [(mobileLocEst(1)-anchorLoc(:,1))./distanceEst ... 
                         (mobileLocEst(2)-anchorLoc(:,2))./distanceEst]; 
        EstMobileLoc{i}=mobileLocEst;
        end
    end
    axes(handles.axes3),
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    hold on;
    plot(EstMobileLoc{1}(:,1),EstMobileLoc{1}(:,2),'ro','MarkerSize',12,'lineWidth',2);
    hold on;
    Err = (sqrt(sum((mobileLocEst(1)-mobileLoc(1)).^2))/2);
    title(['Estimation error is ',num2str(Err),'meter'])
    load local
    figure,
xlim([1 6]);
ylim([0 9]);
plot(varyx,vary7,'b^-');
hold on;
plot(varyx,vary8,'rh-');
hold on;
plot(varyx,vary9,'go-');
hold on;
title('Multilateration algorithm with MISO model');
xlabel('Standard deviation(db)');
ylabel('Average localization error(meters)');
legend('Multilateration,MISO,P1','Multilateration,MISO,P2' ,'Multilateration,MISO,P3');
grid on;
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s Err mobileLocEst mobileLoc anchorLoc EstMobileLoc distanceEst distanceDrv Error
if s==1
 No_of_anc_mimo = 4;  
    No_of_mob_mimo = 3; 
  networkSize = 100;  
    anchorLoc   =[0                     0; 
                   networkSize           0;
                   0           networkSize;
                   networkSize networkSize];
    mobileLoc  = networkSize*rand(No_of_mob_mimo,2);
        distance = zeros( No_of_anc_mimo,1);
        for n = 1 :  No_of_anc_mimo
            for m=1:No_of_mob_mimo
                distance(n) = sqrt( (anchorLoc(n,1)-mobileLoc(m,1)).^2 + ...
                                            (anchorLoc(n,2)-mobileLoc(m,2)).^2  );
            end
        end
    figure,
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    numOfIteration = 5;
    mobileLocEst = networkSize*rand(No_of_mob_mimo,2);
    for i = 1 : numOfIteration
        for nn=1: No_of_anc_mimo
            for mm=1:No_of_mob_mimo
        distanceEst   = sqrt(sum( (anchorLoc- repmat(mobileLocEst(mm,:), No_of_anc_mimo,1)).^2 , 2));
        distanceDrv   = [(mobileLocEst(mm,1)-anchorLoc(:,1))./distanceEst ... 
                         (mobileLocEst(mm,2)-anchorLoc(:,2))./distanceEst];   
        EstMobileLoc{i}=mobileLocEst;
        Err = sqrt(sum((mobileLocEst(:)-mobileLoc(:)).^2));
        Error(i,:)=Err;
        end
        end

    end
    axes(handles.axes4),
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    hold on;
    plot(EstMobileLoc{1}(:,1),EstMobileLoc{1}(:,2),'ro','MarkerSize',12,'lineWidth',2);
    hold on;
     Err = (sqrt(sum((mobileLocEst(:)-mobileLoc(:)).^2))/50);
    title(['Estimation error is ',num2str(min(Err)),'meter'])
     load local
    figure,
xlim([1 6]);
ylim([0.5  5.5]);
plot(varyx,vary10,'b^-');
hold on;
plot(varyx,vary11,'rh-');
hold on;
plot(varyx,vary12,'go-');
hold on;
title('Multilateration algorithm with MIMO model');
xlabel('Standard deviation(db)');
ylabel('Average localization error(meters)');
legend('Multilateration,MIMO,P1','Multilateration,MIMO,P2' ,'Multilateration,MIMO,P3');
grid on;
end
