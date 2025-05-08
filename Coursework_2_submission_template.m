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
disp('starting data collection...')
for t = 1:duration
    v = readVoltage(a, 'A0');
    
    % voltage range check 
    if v < 0 || v > 5
        disp(['warning: voltage out of range at t = ', num2str(t)])
        continue
    end
    
    voltage_values(t) = v; % storing voltage values 
    
    % convert voltage to temperature using linear model
    temp_values(t) = (v - voltage_0deg) / temp_co; 
end

% calculate statistics
min_temp = min(temp_values);
max_temp = max(temp_values);
avg_temp = mean(temp_values);

% display results
fprintf('minimum temperature: %.2f °C\n', min_temp);
fprintf('maximum temperature: %.2f °C\n', max_temp);
fprintf('average temperature: %.2f °C\n', avg_temp);

% plot the graph between time and temp
time = 0:duration - 1;
figure;
plot(time, temp_values, 'b-', 'LineWidth', 1.5);
xlabel('time (s)');
ylabel('temperature (°C)');
title('temperature vs Time');
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
    error('could not open file for writing.');
end

fprintf(fileID, 'CABIN DATA\n');
fprintf(fileID, 'Date: %s\n', formatted_date);
fprintf(fileID, 'Location: %s\n\n', location);
fprintf(fileID, 'Time (min)\tTemp (°C)\n');
fprintf(fileID, '-------------------------------\n');

% printing one temp reading per minute 
for i = 0:9
    index = i * 60 + 1;
    if index > length(temp_values)
        break;
    end

    % opening text file 
    fprintf(fileID, 'Minute\t\t%d\n', i);
    fprintf(fileID, 'Temperature\t%.2f °C\n\n', temp_values(index));
end

fclose(fileID);
disp('data has been recorded in cabin_data.txt');

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

clear

a = arduino('COM3', 'Uno');

% calling the function
temp_monitor(a);


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

clear 

a = arduino('COM3', 'Uno');

temp_prediction(a);


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Challenges I faced were definitely the connections on the breadboard, the
% components were very fragile and trying to find ways to connect all the
% components together took some time. I found correcting the code after
% writing up a skeleton to be my strength because I could trial and error
% the code again to esure it's working as intended. The limitations were
% just my knowledge on different ways to make the code more efficient and
% reduce error. For the future I think I should'nt leave such a long gap
% before coming back to each task because I would forget what I have done.




%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
