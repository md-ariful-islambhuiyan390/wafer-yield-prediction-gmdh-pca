%% Wafer Yield Modeling and PCA Analysis - Full Code

% Set up parameters for wafer simulation
numChips = 473;       % Total number of chips on a wafer
averageDefects = 1.5; % Average defects per chip (Poisson parameter)

%% 1. Yield Estimation using Poisson and Negative Binomial Models

% Poisson Yield Model
poissonYield = exp(-averageDefects);

% Negative Binomial Yield Model (introduces a clustering factor)
k = 2; % Clustering parameter for Negative Binomial model
negBinomYield = (1 + averageDefects / k)^(-k);

% Display yield results
fprintf('Poisson Yield Estimate: %.4f\n', poissonYield);
fprintf('Negative Binomial Yield Estimate: %.4f\n', negBinomYield);

% Plot Yield Estimates Comparison
figure;
bar([poissonYield, negBinomYield]);
set(gca, 'xticklabel', {'Poisson', 'Negative Binomial'});
title('Yield Estimate Comparison');
ylabel('Yield');

%% 2. Bayesian Posterior Distribution for Poisson Yield Parameter

% Define a prior for Bayesian estimation of defect rate (lambda)
priorMu = averageDefects;
priorSigma = 0.5;  % Standard deviation for prior

% Generate posterior samples assuming a normal prior distribution
numSamples = 1000;
posteriorSamples = normrnd(priorMu, priorSigma, [numSamples, 1]);

% Plot the posterior distribution
figure;
histogram(posteriorSamples, 'Normalization', 'pdf');
title('Posterior Distribution for Poisson Yield Parameter (\lambda)');
xlabel('\lambda');
ylabel('Density');

%% 3. Principal Component Analysis (PCA) for Electrical Test Parameters

% Simulate data matrix with 12 variables and 111 samples (replace with actual data if available)
dataMatrix = randn(111, 12); % Each row represents a sample, and each column represents a variable

% Perform PCA on the data matrix
[coeff, score, latent, explained] = pca(dataMatrix);

% Display Eigenvalues (latent) and Explained Variance (explained)
disp('Eigenvalues (latent):');
disp(latent);
disp('Explained Variance (%):');
disp(explained);

% Scree Plot for Eigenvalues
figure;
plot(1:length(latent), latent, '-o', 'MarkerSize', 5, 'LineWidth', 1.5);
title('Eigenvalues of Correlation Matrix - Active Variables Only');
xlabel('Eigenvalue Number');
ylabel('Eigenvalue');
grid on;

% Annotate each point with the explained variance
hold on;
for i = 1:length(latent)
    text(i, latent(i), sprintf('%.2f%%', explained(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;

% Display Eigenvectors in Tabular Form
disp('Eigenvectors of Correlation Matrix (PCA):');
disp(coeff);

% Format and print Eigenvectors with variable names for clarity
varNames = {'X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9', 'X10', 'X11', 'X12'};
factorNames = strcat("Factor ", string(1:size(coeff, 2)));

% Create table for display
eigenvectorTable = array2table(coeff, 'RowNames', varNames, 'VariableNames', factorNames);
disp('Eigenvectors of Correlation Matrix (PCA) with Variable Names:');
disp(eigenvectorTable);

%% 4. Defect Cluster Index (CIM) Calculation

% Simulate defect positions on a wafer
waferDiameter = 20;  % Diameter of wafer in cm
numDefects = 100;    % Number of defects on the wafer
x = waferDiameter * rand(numDefects, 1);  % Random x-coordinates
y = waferDiameter * rand(numDefects, 1);  % Random y-coordinates

% Sort defect positions and calculate intervals between defects
xSorted = sort(x);
ySorted = sort(y);
xIntervals = diff(xSorted);
yIntervals = diff(ySorted);

% Calculate Variance-to-Mean ratio (V/M) for clustering index
VM_x = var(xIntervals) / mean(xIntervals);
VM_y = var(yIntervals) / mean(yIntervals);

% Defect Cluster Index (CIM) is the average of the V/M ratios for x and y intervals
CIM = mean([VM_x, VM_y]);  % Simplified clustering index calculation
fprintf('Defect Cluster Index (CIM): %.4f\n', CIM);

% Visualize defect distribution on wafer with clustering
figure;
scatter(x, y, 50, 'filled');  % Set marker size to 50 for better visibility
title('Simulated Defect Distribution on Wafer');
xlabel('X Position (cm)');
ylabel('Y Position (cm)');
axis([0 waferDiameter 0 waferDiameter]);

%% 5. Scatter Plots of Predictive vs. Actual Yield Values for Different Models

% Number of samples for scatter plot
numSamples = 30;

% Simulate actual yield values (linearly spaced between 0.6 and 1.0)
actualYield = linspace(0.6, 1.0, numSamples)';

% Simulate predictive yield values with small variations for each model
noiseLevel = 0.02;  % Adjust noise level to simulate prediction accuracy

% Negative Binomial Model Predictions
predictedYield_NB = actualYield + noiseLevel * randn(numSamples, 1);

% BPNN Model Predictions
predictedYield_BPNN = actualYield + 0.015 * randn(numSamples, 1);

% GRNN Model Predictions
predictedYield_GRNN = actualYield + 0.01 * randn(numSamples, 1);

% GMDH Model Predictions
predictedYield_GMDH = actualYield + 0.005 * randn(numSamples, 1);

% Plot Scatter Diagram for Negative Binomial Model
figure;
scatter(actualYield, predictedYield_NB, 'filled');
title('Scatter Plot in Negative Binomial Yield Model');
xlabel('Actual yield value');
ylabel('Predictive yield value');
axis([0.6 1 0.6 1]);

% Plot Scatter Diagram for BPNN Model
figure;
scatter(actualYield, predictedYield_BPNN, 'filled');
title('Scatter Plot in BPNN Yield Model');
xlabel('Actual yield value');
ylabel('Predictive yield value');
axis([0.6 1 0.6 1]);

% Plot Scatter Diagram for GRNN Model
figure;
scatter(actualYield, predictedYield_GRNN, 'filled');
title('Scatter Plot in GRNN Yield Model');
xlabel('Actual yield value');
ylabel('Predictive yield value');
axis([0.6 1 0.6 1]);

% Plot Scatter Diagram for GMDH Model
figure;
scatter(actualYield, predictedYield_GMDH, 'filled');
title('Scatter Plot in GMDH Yield Model');
xlabel('Actual yield value');
ylabel('Predictive yield value');
axis([0.6 1 0.6 1]);

%% 6. Clustering Patterns for Defect Distribution on Wafer

% Define figure for multiple subplots
figure;

% 1. Bullseye Pattern
subplot(2, 3, 1);
theta = 2 * pi * rand(100, 1); % Random angles
r = 10 * sqrt(rand(100, 1));    % Radius for inner circle
x = r .* cos(theta);
y = r .* sin(theta);
scatter(x, y, 'b.');
hold on;
scatter(30 * cos(theta), 30 * sin(theta), 'b.');
title('Bullseye Pattern');
xlabel('In-Phase');
ylabel('Quadrature');
axis([-100 100 -100 100]);
grid on;

% 2. Bottom Pattern
subplot(2, 3, 2);
x = 100 * rand(100, 1) - 50; % Random x values within range
y = -50 * rand(100, 1) - 50; % Concentrated at the bottom
scatter(x, y, 'b.');
title('Bottom Pattern');
xlabel('In-Phase');
ylabel('Quadrature');
axis([-100 100 -100 100]);
grid on;

% 3. Crescent Moon Pattern
subplot(2, 3, 3);
theta = pi * rand(100, 1); % Semi-circle angles
r = 50 + 20 * rand(100, 1); % Radius for outer crescent shape
x = r .* cos(theta);
y = r .* sin(theta);
scatter(x, y, 'b.');
title('Crescent Moon Pattern');
xlabel('In-Phase');
ylabel('Quadrature');
axis([-100 100 -100 100]);
grid on;

% 4. Edge Pattern
subplot(2, 3, 4);
theta = 2 * pi * rand(100, 1); % Full circle angles
r = 80 + 10 * randn(100, 1);   % Radius around edge
x = r .* cos(theta);
y = r .* sin(theta);
scatter(x, y, 'b.');
title('Edge Pattern');
xlabel('In-Phase');
ylabel('Quadrature');
axis([-100 100 -100 100]);
grid on;

% 5. Random Pattern
subplot(2, 3, 5);

% Uniformly distribute points across the wafer's surface
theta = 2 * pi * rand(100, 1); % Random angles (0 to 2π)
r = sqrt(rand(100, 1)) * 100;  % Radius with uniform distribution
x = r .* cos(theta);           % Convert polar to Cartesian x-coordinates
y = r .* sin(theta);           % Convert polar to Cartesian y-coordinates

scatter(x, y, 'b.');           % Plot points
title('Random Pattern');
xlabel('In-Phase');
ylabel('Quadrature');
axis([-100 100 -100 100]);      % Ensure axes are consistent
grid on;