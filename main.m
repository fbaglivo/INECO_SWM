%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SWM Pardigm V0 (Debug)
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

hd.blank    = 5000/1000;
hd.word     = 3000/1000;

iti.xmin=200;   % Random ITI limits
iti.xmax=500;

point=1;    % word pointer

leftKey = KbName('left');
rightKey = KbName('right');

Intro = imread('Images/Bienvenida.jpg');
[~,~, raw]=xlsread('Words\Est�mulos_SWM.xls');

arrow_left=sprintf('%s','<--- NO');
arrow_right=sprintf('%s','SI --->');
question=sprintf('%s','�Estas son las mismas palabras que vio en la pantalla anterior?') ;


%% Start Psychtoolbox - FINISHED

PsychDefaultSetup(2);
hidecursor();
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

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
 


%% Present Test to patient

% Open an on screen window using PsychImaging and color it grey.
[window, scrnsize] = PsychImaging('OpenWindow', screenNumber, black);

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

KbStrokeWait;

%% Begin PRACTICE loop

for practice=1:6

    
    screen('FillRect',hd.window,black)            
    DrawFormattedText(hd.window, '+', 'center',...
                'center', white);          
    Screen('Flip',hd.window,0,1); %%  
    
    iti.time=iti.xmin+rand(1)*(iti.xmax-iti.xmin);
    waitSecs(iti.time/1000);
    
    word_number=cell2mat(raw(point,2));
    
    switch word_number
    
        case 3
        
            for i=1:3
            
                point=point+1;
                w(i).stim= cell2mat(raw(point,1));
                w(i).test= cell2mat(raw(point,2));
            
            end
  
            %Stim
            
            screen('FillRect',hd.window,black)                     
            DrawFormattedText(hd.window, sprintf('%c',w(1).stim), 'center',...
                hd.centery * 0.8, white);
            DrawFormattedText(hd.window, sprintf('%c',w(2).stim), 'center',...
                'center', white);          
            DrawFormattedText(hd.window, sprintf('%c',w(3).stim), 'center',...
                hd.centery * 1.10, white);
            Screen('Flip',hd.window,0,1); %%
 
           
            point=point+1;
          
            waitSecs(hd.word);
            
            screen('FillRect',hd.window,black);
            Screen('Flip',hd.window,0,1); %%

            waitSecs(hd.blank);
 
            %TEST
            
            screen('FillRect',hd.window,black)                     
            
            
            DrawFormattedText(hd.window, question, 'center',...
                hd.centery * 0.2, white);
           
             DrawFormattedText(hd.window, arrow_left, hd.centerx * 0.2,...
                hd.centery * 1.7, white);
            DrawFormattedText(hd.window, arrow_right, hd.centerx * 1.6,...
                hd.centery * 1.7, white);
           
            
            DrawFormattedText(hd.window, sprintf('%c',w(1).test), 'center',...
                hd.centery * 0.8, white);
            DrawFormattedText(hd.window, sprintf('%c',w(2).test), 'center',...
                'center', white);          
            DrawFormattedText(hd.window, sprintf('%c',w(3).test), 'center',...
                hd.centery * 1.10, white);
            
            
            
            Screen('Flip',hd.window,0,1); %%
 
            tic
            
            out=false;
            
            while toc<4 && out == false
            
                [keyIsDown,secs, keyCode] = KbCheck;

                % Depending on the button press, either move ths position of the square
                % or exit the demo
                if keyCode(rightKey)
                    out = true;
                elseif keyCode(leftKey)
                    out = true;
                end
                
            end
            
        case 4
            
            for i=1:4
            
                point=point+1;
                w(i).stim= cell2mat(raw(point,1));
                w(i).test= cell2mat(raw(point,2));
            
            end
            
            screen('FillRect',hd.window,black)
            
            DrawFormattedText(hd.window, sprintf('%c',w(1).stim), 'center',...
                hd.centery * 0.70, white);
            DrawFormattedText(hd.window, sprintf('%c',w(2).stim), 'center',...
                hd.centery * 0.85, white);          
            DrawFormattedText(hd.window, sprintf('%c',w(3).stim), 'center',...
                hd.centery * 1, white);
            DrawFormattedText(hd.window, sprintf('%c',w(4).stim), 'center',...
                hd.centery * 1.15, white);
            
            Screen('Flip',hd.window,0,1); %%
 
            point=point+1;
            
            waitSecs(hd.word);
                        
            screen('FillRect',hd.window,black);
            screen('Flip',hd.window,0,1); %%
            
            waitSecs(hd.blank);
        
            %TEST
            
            screen('FillRect',hd.window,black)
            
            DrawFormattedText(hd.window, question, 'center',...
                hd.centery * 0.2, white);
           
             DrawFormattedText(hd.window, arrow_left, hd.centerx * 0.2,...
                hd.centery * 1.7, white);
            DrawFormattedText(hd.window, arrow_right, hd.centerx * 1.6,...
                hd.centery * 1.7, white);
            
            DrawFormattedText(hd.window, sprintf('%c',w(1).test), 'center',...
                hd.centery * 0.70, white);
            DrawFormattedText(hd.window, sprintf('%c',w(2).test), 'center',...
                hd.centery * 0.85, white);          
            DrawFormattedText(hd.window, sprintf('%c',w(3).test), 'center',...
                hd.centery * 1, white);
            DrawFormattedText(hd.window, sprintf('%c',w(4).test), 'center',...
                hd.centery * 1.15, white);
            Screen('Flip',hd.window,0,1); %%
 
            tic
            
            out=false;
            
            while toc<4 && out == false
            
                [keyIsDown,secs, keyCode] = KbCheck;

                % Depending on the button press, either move ths position of the square
                % or exit the demo
                if keyCode(rightKey)
                    out = true;
                elseif keyCode(leftKey)
                    out = true;
                end
                
            end
            
            
        case 5
          
            for i=1:5
            
                point=point+1;
                w(i).stim= cell2mat(raw(point,1));
                w(i).test= cell2mat(raw(point,2));
            
            end
            
            screen('FillRect',hd.window,black)
            
            DrawFormattedText(hd.window, sprintf('%c',w(1).stim), 'center',...
                hd.centery * 0.65, white);
            DrawFormattedText(hd.window, sprintf('%c',w(2).stim), 'center',...
                hd.centery * 0.80, white);          
            DrawFormattedText(hd.window, sprintf('%c',w(3).stim), 'center',...
                hd.centery * 0.95, white);
            DrawFormattedText(hd.window, sprintf('%c',w(4).stim), 'center',...
                hd.centery * 1.10, white);
            DrawFormattedText(hd.window, sprintf('%c',w(5).stim), 'center',...
                hd.centery * 1.25, white);
            
            
            Screen('Flip',hd.window,0,1); %%
 
            point=point+1;
 
            waitSecs(hd.word);
                        
            screen('FillRect',hd.window,black);
            Screen('Flip',hd.window,0,1); %%

            waitSecs(hd.blank);
    
            %TEST
            
            screen('FillRect',hd.window,black)
            
            DrawFormattedText(hd.window, question, 'center',...
                hd.centery * 0.2, white);
           
             DrawFormattedText(hd.window, arrow_left, hd.centerx * 0.2,...
                hd.centery * 1.7, white);
            DrawFormattedText(hd.window, arrow_right, hd.centerx * 1.6,...
                hd.centery * 1.7, white);
            
            DrawFormattedText(hd.window, sprintf('%c',w(1).test), 'center',...
                hd.centery * 0.65, white);
            DrawFormattedText(hd.window, sprintf('%c',w(2).test), 'center',...
                hd.centery * 0.80, white);          
            DrawFormattedText(hd.window, sprintf('%c',w(3).test), 'center',...
                hd.centery * 0.95, white);
            DrawFormattedText(hd.window, sprintf('%c',w(4).test), 'center',...
                hd.centery * 1.10, white);
            DrawFormattedText(hd.window, sprintf('%c',w(5).test), 'center',...
                hd.centery * 1.25, white);
            Screen('Flip',hd.window,0,1); %%
 
            tic
            
            out=false;
            
            while toc<4 && out == false
            
                [keyIsDown,secs, keyCode] = KbCheck;

                % Depending on the button press, either move ths position of the square
                % or exit the demo
                if keyCode(rightKey)
                    out = true;
                elseif keyCode(leftKey)
                    out = true;
                end
                
            end
    end

end

%% Close

Screen('CloseAll'); % Cierro ventana del Psychtoolbox

