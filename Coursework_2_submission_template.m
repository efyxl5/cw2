% Insert name here
% Insert email address here


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

clear

a = arduino('COM3', 'Uno');


ledPin = 'D8';


for i = 1:10  % loop to blink the LED 10 times

    writeDigitalPin(a, ledPin, 1); % Turn the LED on high

    pause(0.5); % wait for 0.5 seconds

    writeDigitalPin(a, ledPin, 0); % turn the LED off (LOW)

    pause(0.5); % Wait for 0.5 seconds

end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

clear

a = arduino('COM3', 'Uno');

% duration of data logging
duration = 600;


temp_co = 0.01;          % voltage change per °C
voltage_0deg = 0.5;      % voltage at 0°C (V)

% initialize arrays
voltage_values = zeros(1, duration);
temp_values = zeros(1, duration);

% begin data collection
disp('Starting temperature data acquisition...')
for t = 1:duration
    v = readVoltage(a, 'A0');
    
    % voltage range check 
    if v < 0 || v > 5
        disp(['Warning: Voltage out of range at t = ', num2str(t)])
        continue
    end
    
    voltage_values(t) = v;
    
    % convert voltage to temperature using linear model
    temp_values(t) = (v - voltage_0deg) / temp_co; 
end

% calculate statistics
min_temp = min(temp_values);
max_temp = max(temp_values);
avg_temp = mean(temp_values);

% display results
fprintf('Minimum Temperature: %.2f °C\n', min_temp);
fprintf('Maximum Temperature: %.2f °C\n', max_temp);
fprintf('Average Temperature: %.2f °C\n', avg_temp);

% plot the graph between time and temp
time = 0:duration - 1;
figure;
plot(time, temp_values, 'b-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature vs Time');
grid on;

% printing formatted data 
r_date = datetime('now');
formatted_date = datestr(r_date, 'dd/mm/yyyy');
location = 'Nottingham';

fprintf('\n-------------------------------\n');
fprintf('CABIN DATA\n');
fprintf('Date: %s\n', formatted_date);
fprintf('Location: %s\n\n', location);
fprintf('Time (min)\tTemp (°C)\n');
fprintf('-------------------------------\n');

% use sprintf to build strings then print the lines
for i = 0:9
    idx = i * 60 + 1; % every 60 seconds
    if idx > length(temp_values)
        break;
    end
    line1 = sprintf('Minute\t\t%d', i);
    line2 = sprintf('Temperature\t%.2f °C\n', temp_values(idx));
    fprintf('%s\n%s\n\n', line1, line2);
end

% writing the data into a text file 
fileID = fopen('cabin_temperature.txt', 'w');

if fileID == -1
    error('Could not open file for writing.');
end

fprintf(fileID, 'CABIN DATA\n');
fprintf(fileID, 'Date: %s\n', formatted_date);
fprintf(fileID, 'Location: %s\n\n', location);
fprintf(fileID, 'Time (min)\tTemp (°C)\n');
fprintf(fileID, '-------------------------------\n');

for i = 0:9
    index = i * 60 + 1;
    if index > length(temp_values)
        break;
    end
    fprintf(fileID, 'Minute\t\t%d\n', i);
    fprintf(fileID, 'Temperature\t%.2f °C\n\n', temp_values(index));
end

fclose(fileID);
disp('Data has been recorded in cabin_data.txt');

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

clear;

a = arduino('COM3', 'Uno'); 

duration = 600;  
temp_co = 0.01;  
voltage_0deg = 0.0;  

temp_monitor(a, duration, temp_co, voltage_0deg);


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
