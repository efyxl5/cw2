% Insert name here
% Insert email address here


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

clear

a = arduino('COM3', 'Uno');


ledPin = 'D3';


for i = 1:10  % loop to blink the LED 10 times

    writeDigitalPin(a, ledPin, 1); % Turn the LED on high

    pause(0.5); % wait for 0.5 seconds

    writeDigitalPin(a, ledPin, 0); % turn the LED off (LOW)

    pause(0.5); % Wait for 0.5 seconds

end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

clear

duration = 600; % duration of collecting data in seconds

temp_co = 0.01; % temp coefficient in voltage per degree celcius
voltage_0deg = 0.0; % voltage at 0 degree celcius in voltage

% setting up the arrays used
voltage_values = zeros(1,duration); 
temp_values = zeros(1,duration);

% collecting data 
for t = 1:duration
    v = 0.2 + 0.4 * rand();
    voltage_values(t) = v; % stpring the values collected 
    temp = (v - voltage_0deg) / temp_co;
    temp_values(t) = temp;
end


min_temp = min(temp_values);
avrg_temp = min(temp_values);
max_temp = min(temp_values);

fprintf('The min temp : %.2f °C\n', min_temp)
fprintf('The max temp : %.2f °C\n', max_temp)
fprintf('The average temp : %.2f °C\n', avrg_temp)
%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
