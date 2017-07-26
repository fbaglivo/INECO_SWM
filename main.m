%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SWM Pardigm V3 
%
% This script is a working memory task that uses words as stimulus
% 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all


% Patient info

name = input('Ingrese el nombre del paciente: ', 's');
date = datestr(now);

%TODO

%% Configure constant and variables (log), Load images

hd.itemsize = 100;
hd.wsize = (hd.itemsize/2)+30;
hd.textsize = 35;
hd.textfont = 'Helvetica';

iti.xmin=200;   % Random ITI limits
iti.xmax=500;

% Production 

hd.times(1).stim= 3000/1000;
hd.times(1).blank= 5000/1000;
hd.times(1).test= 4500/1000;

hd.times(2).stim=4000/1000;
hd.times(2).blank= 5000/1000;
hd.times(2).test= 5500/1000;

hd.times(3).stim= 5000/1000;
hd.times(3).blank= 5000/1000;
hd.times(3).test= 6500/1000;

%Debug
% hd.times(1).stim= 30/1000;
% hd.times(1).blank= 50/1000;
% hd.times(1).test= 10/1000;
% 
% hd.times(2).stim=40/1000;
% hd.times(2).blank= 50/1000;
% hd.times(2).test= 10/1000;
% 
% hd.times(3).stim= 50/1000;
% hd.times(3).blank= 50/1000;
% hd.times(3).test= 10/1000;


point=1;    % word pointer


Intro = imread('Images/Bienvenida.jpg');
Test_start = imread('Images/Test_start.jpg');
[~,~, raw]=xlsread('Words/Estimulos_SWM.xls');


%% Start Psychtoolbox - FINISHED

PsychDefaultSetup(2);
Hidecursor();
Priority(max(Priority));

%% Configure Screen - FINISHED

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens);

% Define black and white (white will be 1 and black 0). This is because
% in general luminace values are defined between 0 and 1 with 255 steps in
% between. All values in Psychtoolbox are defined between 0 and 1

hd.white = WhiteIndex(screenNumber);
hd.black = BlackIndex(screenNumber);
 


%% Present Test to patient

% Open an on screen window using PsychImaging and color it grey.
[window, scrnsize] = PsychImaging('OpenWindow', screenNumber, hd.black);

hd.window=window;
hd.centerx = scrnsize(3)/2;
hd.centery = scrnsize(4)/2;
hd.bottom = scrnsize(4);
hd.right = scrnsize(3);

Screen('TextSize', hd.window, hd.textsize);
Screen('TextFont', hd.window, hd.textfont);       

%% Present Test to patient

textureIndex=Screen('MakeTexture', hd.window, Intro);
Screen('DrawTexture', hd.window, textureIndex);
Screen('Flip',hd.window);

[~, keyCode,~] = KbStrokeWait;

%% Practice

numberoftrials2run=6;
[log_practice point]=trials_run(numberoftrials2run,hd,iti,raw,point,name,date);


black=hd.black;
Screen('FillRect',hd.window,black)  ;                   
textureIndex=Screen('MakeTexture', hd.window, Test_start);
Screen('DrawTexture', hd.window, textureIndex);
Screen('Flip',hd.window);


[~, keyCode,~] = KbStrokeWait;

%if keycode == r re run the practice

while(find(keyCode) == KbName('r'))

    textureIndex=Screen('MakeTexture', hd.window, Intro);
    Screen('DrawTexture', hd.window, textureIndex);
    Screen('Flip',hd.window);

    [~, keyCode,~] = KbStrokeWait;
    
    if (find(keyCode) == KbName('q'))
        
        Screen('CloseAll'); % Cierro ventana del Psychtoolbox
        error('Finalizando script...')
        
    end
    
    numberoftrials2run=6;
    [log_practice ~]=trials_run(numberoftrials2run,hd,iti,raw,point,name,date);
    
    black=hd.black;
    Screen('FillRect',hd.window,black)  ;
    textureIndex=Screen('MakeTexture', hd.window, Test_start);
    Screen('DrawTexture', hd.window, textureIndex);
    Screen('Flip',hd.window);
    [~, keyCode,~] = KbStrokeWait;

end

save(['Log/' name '_' date(1:11) '_Practice.mat'],'log_practice');

%% Test

numberoftrials2run=108;
[log_test point]=trials_run(numberoftrials2run,hd,iti,raw,point,name,date);


%% Save & Close

save(['Log/' name '_' date(1:11) '_Test.mat'],'log_test');
Screen('CloseAll'); % Cierro ventana del Psychtoolbox
