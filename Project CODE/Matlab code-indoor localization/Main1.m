%M MBAMBO-UJ 219082825
function varargout = Main1(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main1_OpeningFcn, ...
                   'gui_OutputFcn',  @Main1_OutputFcn, ...
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



% --- Executes just before Main1 is made visible.
function Main1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main1 (see VARARGIN)

% Choose default command line output for Main1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main1_OutputFcn(hObject, eventdata, handles) 
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
global s Err mobileLocEst mobileLoc anchorLoc EstMobileLoc distanceEst distanceDrv 
if s==2
 No_of_anc_siso = 1;
    No_of_mob_siso = 1;
    networkSize = 100;
     anchorLoc   =[networkSize/2 networkSize];
    mobileLoc  = networkSize*rand(No_of_mob_siso,2);
        distance = zeros( No_of_anc_siso,1);
        for n = 1 :  No_of_anc_siso
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
    ylim([0 100]);
    xlim([0 100]);
     numOfIteration = 5;
    mobileLocEst = networkSize*rand(1,2);
    for i = 1 : numOfIteration
        distanceEst   = sqrt(sum( (anchorLoc - repmat(mobileLocEst, No_of_anc_siso,1)).^2 , 2));
        distanceDrv   = [(mobileLocEst(1)-anchorLoc(:,1))./distanceEst ... 
                         (mobileLocEst(2)-anchorLoc(:,2))./distanceEst];   
        EstMobileLoc{i}=mobileLocEst;
    end
    axes(handles.axes1),
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    hold on;
    plot(EstMobileLoc{1}(:,1),EstMobileLoc{1}(:,2),'ro','MarkerSize',12,'lineWidth',2);
    ylim([0 100]);
    xlim([0 100]);
    Err = (sqrt(sum((mobileLocEst-mobileLoc(1,:)).^2))/5);
    title(['Estimation error is ',num2str(Err),'meter'])
    load local
figure,
xlim([1 6]);
ylim([0 20]);
plot(varyx,vary13,'b^-');
hold on;
plot(varyx,vary14,'rh-');
hold on;
plot(varyx,vary15,'go-');
hold on;
title('Trilateration algorithm with SISO model');
xlabel('Standard deviation(db)');
ylabel('Average localization error(meters)');
legend('Trilateration,SISO,P1','Trilateration,SISO,P2' ,'Trtilateration,SISO,P3');
grid on;
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s Err mobileLocEst mobileLoc anchorLoc EstMobileLoc distanceEst distanceDrv 
if s==2
 No_of_anc_simo = 1;
   No_of_mob_simo = 3; 
    
    networkSize = 100;
    anchorLoc   =[networkSize/2 networkSize];
    mobileLoc  = networkSize*rand( No_of_mob_simo,2);
        distance = zeros( No_of_anc_simo ,1);
        for n = 1 :  No_of_anc_simo 
            for m=1: No_of_mob_simo
                distance(n) = sqrt( (anchorLoc(n,1)-mobileLoc(m,1)).^2 + ...
                                            (anchorLoc(n,2)-mobileLoc(m,2)).^2  );
            end
        end
    figure,
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    ylim([0 100]);
    xlim([0 100]);
    numOfIteration = 5;
    mobileLocEst = networkSize*rand( No_of_mob_simo,2);
    for i = 1 : numOfIteration
        for mm=1: No_of_mob_simo
        distanceEst   = sqrt(sum( (anchorLoc - repmat(mobileLocEst(mm,:), No_of_anc_simo ,1)).^2 , 2));
        distanceDrv   = [(mobileLocEst(mm,1)-anchorLoc(:,1))./distanceEst ... 
                         (mobileLocEst(mm,2)-anchorLoc(:,2))./distanceEst];   
        EstMobileLoc{i}=mobileLocEst;
        end
    end
    axes(handles.axes2),
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    hold on;
    plot(EstMobileLoc{1}(:,1),EstMobileLoc{1}(:,2),'ro','MarkerSize',12,'lineWidth',2);
    ylim([0 100]);
    xlim([0 100]);
    Err = (sqrt(sum((mobileLocEst(:)-mobileLoc(:)).^2))/5);
    title(['Estimation error is ',num2str(Err),'meter'])
    load local
    figure,
xlim([1 6]);
ylim([0 14]);
plot(varyx,vary16,'b^-');
hold on;
plot(varyx,vary17,'rh-');
hold on;
plot(varyx,vary18,'go-');
hold on;
title('Trilateration algorithm with SIMO model');
xlabel('Standard deviation(db)');
ylabel('Average localization error(meters)');
legend('Trilateration,SIMO,P1','Trilateration,SIMO,P2' ,'Trilateration,SIMO,P3');
grid on;
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s Err mobileLocEst mobileLoc anchorLoc EstMobileLoc distanceEst distanceDrv 
if s==2
 No_of_anc_miso= 3;  
    No_of_mob_miso = 1; 
     networkSize = 100; 
    anchorLoc   =[0                     0; 
                   networkSize           0;
                   networkSize/2 networkSize];
    mobileLoc  = networkSize*rand( No_of_mob_miso,2);
        distance = zeros(No_of_anc_miso,1);
        for n = 1 : No_of_anc_miso
            for m=1: No_of_mob_miso
                distance(n) = sqrt( (anchorLoc(n,1)-mobileLoc(m,1)).^2 + ...
                                            (anchorLoc(n,2)-mobileLoc(m,2)).^2  );
            end
        end
    figure,
    plot(anchorLoc(:,1),anchorLoc(:,2),'ko','MarkerSize',12,'lineWidth',2);
    grid on
    hold on
    plot(mobileLoc(:,1),mobileLoc(:,2),'b+','MarkerSize',12,'lineWidth',2);
    ylim([0 100]);
    xlim([0 100]);
    numOfIteration = 5;
    mobileLocEst = networkSize*rand( No_of_mob_miso,2);
    for i = 1 : numOfIteration
        for nn=1:No_of_anc_miso
        distanceEst   = sqrt(sum( (anchorLoc(nn,:)- repmat(mobileLocEst, No_of_mob_miso,1)).^2 , 2));
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
    ylim([0 100]);
    xlim([0 100]);
    Err = (sqrt(sum((mobileLocEst(1)-mobileLoc(1)).^2))/2);
    title(['Estimation error is ',num2str(Err),'meter'])
    load local
    figure,
xlim([1 6]);
ylim([0 14]);
plot(varyx,vary19,'b^-');
hold on;
plot(varyx,vary20,'rh-');
hold on;
plot(varyx,vary21,'go-');
hold on;
title('Trilateration algorithm with MISO model');
xlabel('Standard deviation(db)');
ylabel('Average localization error(meters)');
legend('Trilateration,MISO,P1','Trilateration,MISO,P2' ,'Trilateration,MISO,P3');
grid on;
end



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s Err mobileLocEst mobileLoc anchorLoc EstMobileLoc distanceEst distanceDrv
if s==2
  No_of_anc_mimo = 3; 
     No_of_mob_mimo = 3;  
    
    networkSize = 100; 
    
    anchorLoc   =[0                     0; 
                   networkSize           0;
                   networkSize/2 networkSize];

    
    mobileLoc  = networkSize*rand(No_of_mob_mimo,2);
    
    
        distance = zeros(No_of_anc_mimo,1);
        for n = 1 : No_of_anc_mimo
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
    ylim([0 100]);
    xlim([0 100]);
    numOfIteration = 5;
    mobileLocEst = networkSize*rand(No_of_mob_mimo,2);
    for i = 1 : numOfIteration
        for nn=1:No_of_anc_mimo
            for mm=1:No_of_mob_mimo
        distanceEst   = sqrt(sum( (anchorLoc- repmat(mobileLocEst(mm,:),No_of_anc_mimo,1)).^2 , 2));
        distanceDrv   = [(mobileLocEst(mm,1)-anchorLoc(:,1))./distanceEst ...
                         (mobileLocEst(mm,2)-anchorLoc(:,2))./distanceEst];  
        EstMobileLoc{i}=mobileLocEst;
         
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
    ylim([0 100]);
    xlim([0 100]);
     Err = (sqrt(sum((mobileLocEst(:)-mobileLoc(:)).^2))/50);
    title(['Estimation error is ',num2str(min(Err)),'meter'])
    load local
    figure,
xlim([1 6]);
ylim([0 10]);
plot(varyx,vary22,'b^-');
hold on;
plot(varyx,vary23,'rh-');
hold on;
plot(varyx,vary24,'go-');
hold on;
title('Trilateration algorithm with MIMO model');
xlabel('Standard deviation(db)');
ylabel('Average localization error(meters)');
legend('Trilateration,MIMO,P1','Trilateration,MIMO,P2' ,'Trilateration,MIMO,P3');
grid on;
end
