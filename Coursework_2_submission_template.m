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

% using matlab functions to calculate stats
min_temp = min(temp_values);
avrg_temp = mean(temp_values);
max_temp = max(temp_values);

% displaying the results
fprintf('The min temp : %.2f °C\n', min_temp)
fprintf('The max temp : %.2f °C\n', max_temp)
fprintf('The average temp : %.2f °C\n', avrg_temp)

% plotting the graph ------------------------------------------------------

time = 0:duration -1; 

figure;
plot(time, temp_values, 'b-', 'LineWidth', 1);

% adding labels to the graphs
xlabel('Time (s)');
ylabel('Temp (°C)');
title('Temp v Time');
grid on;

% recording cabin data to a screen

r_data = datetime('now'); % getting the information to what date it is when the data is being recorded
formatted_date = datestr(r_data,'dd/mm/yyyy'); % datestr not recommended but used for simplicity for this code, datetime used above to show that there's variation to this issue 
location = 'Nottingham';

minute = 0:9; % recording from minute 0 to minute 9
minute_temp = temp_values(1:60:end); % picking sample data from my temp values every 60 seconds

% printing the border and titles
fprintf('-------------------------------\n');
fprintf('CABIN DATA\n');
fprintf('date: %s\n',formatted_date);
fprintf('location: %s\n\n', location);

fprintf('Time (min)\tTemp (°C)\n');
fprintf('-------------------------------\n');

% this is a loop that allows data to be printed in rows

for i = 1:length(minute)
    fprintf('%-12s %2d\n', 'Minute', minute(i));         
    fprintf('%-12s %.2f C\n\n', 'Temperature', minute_temp(i)); % %-12s means alignment within 12 spaces
end

% opening a file for writing ----------------------------------------------

fileID = fopen('cabin_data.txt', 'w'); % oppening a file for writing 

if fileID == -1 % ensuring that the file was opened with no issues
    error('this file could not be opened');
end

% creating titles for the file 
fprintf(fileID, 'CABIN DATA\n');
fprintf(fileID, 'date: %s\n', formatted_date);
fprintf(fileID, 'location: %s\n\n', location);

fprintf(fileID, 'Time(min)\tTemp (°C)\n');
fprintf(fileID, '-------------------------------\n');

for i = 1:length(minute) % allowing data to be written in the file; loop
    fprintf(fileID, 'minute %d\t\t%.2f\n', minute(i), minute_temp(i));
end 

fclose(fileID); % closing the file 
disp('data has been recorded in file'); % letting the users know that the file has been successfully created

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

clear

a = arduino('COM3', 'Uno');

temp_monitor(a);


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
