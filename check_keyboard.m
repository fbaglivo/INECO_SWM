function out = check_keyboard()

out=0;

[~, ~, keyCode, ~] = KbCheck();

if (find(keyCode) == KbName('p'))
    
    [~, ~, keyCode, ~] = KbCheck();
    
    flag = 0;
    
    while (flag == 0)
        
        [~, ~, keyCode, ~] = KbCheck();
        if (find(keyCode) == KbName('r'))
            
            flag=1;
            
        end
        
    end
end

[~, ~, keyCode, ~] = KbCheck();

if (find(keyCode) == KbName('q'))
    
    out=-1;
    
end

