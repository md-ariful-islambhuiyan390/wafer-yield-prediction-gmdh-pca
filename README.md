Wafer Yield Prediction Using GMDH and PCA
Overview

This project develops a novel wafer yield prediction model for semiconductor manufacturing using:

GMDH (Group Method of Data Handling): Polynomial-based neural network approach
PCA (Principal Component Analysis): Dimensionality reduction of electrical test parameters
CIM (Cluster Index Metric): Defect clustering quantification
Key Features

✓ GMDH yield model with Kolmogorov-Gabor polynomials
✓ PCA-based dimensionality reduction (12→3 parameters, 99.5% variance retained)
✓ Defect cluster index (CIM) calculation
✓ Comparison with Poisson & Negative Binomial models
✓ High accuracy: RMSE = 0.1027, r = 0.9784

Results Summary
Model	RMSE	Correlation (r)
Poisson	-	-
Negative Binomial	-	-
GMDH	0.1027	0.9784
Repository Structure
├── docs/
│   ├── Project_Proposal.pdf
│   └── Final_Report.pdf
├── src/
│   ├── wafer_yield_modeling.m
│   └── clustering_analysis.m
├── data/
│   └── README.md
└── README.md
Quick Start
Prerequisites
MATLAB R2020a or later
Statistics and Machine Learning Toolbox
Signal Processing Toolbox
Usage
matlab
% Run main analysis
run main_analysis.m

% Expected outputs:
% - Yield model comparison plots
% - PCA scree plot
% - Clustering pattern visualization
% - RMSE and correlation metrics
Methodology
1. Data Preparation
Synthetic wafer data: 12 critical electrical test parameters
111 wafer samples
2. Dimensionality Reduction
Applied PCA with Kaiser's rule (eigenvalues > 1.0)
Reduced to 3 principal components
Retained 99.5% of variance
3. GMDH Model
Polynomial neural network (Kolmogorov-Gabor form)
Captures non-linear relationships
Training/testing split: 89/22 samples
4. Defect Clustering
Calculated CIM based on variance-to-mean ratio
CIM = 1.24 indicates significant clustering
Key Findings

✓ GMDH outperforms traditional models

Poisson yield: 0.2231 (overestimates)
Negative Binomial yield: 0.2581 (improved but limited)
GMDH: Superior accuracy with r = 0.9784

✓ PCA validation

Scree plot confirms 3-component selection
Eigenvalues > 1.0 threshold satisfied

✓ Clustering detection

CIM = 1.24 successfully quantifies defect clustering
Visualized 5 clustering patterns (bullseye, bottom, crescent moon, edge, random)
Visualization Examples

The project includes:

Yield Comparison Chart: Model performance comparison
PCA Scree Plot: Eigenvalue analysis
Scatter Plots: Predicted vs. actual yield (all models)
Clustering Patterns: 5 defect distribution patterns on wafer surface
Posterior Distribution: Bayesian analysis of Poisson parameter (λ)
Author

Md Ariful Islam Bhuiyan

MS Electrical Engineering, California State University, Northridge (CSUN)
System Engineer, Mainwins Technology
Research: Microelectronics Lab, CSUN
Supervisor

Prof. Ben (ECE-650: Probability and Random Process)

Citation

Based on: Jun-Shuw Lin, "A novel design of wafer yield model for semiconductor using a GMDH polynomial and principal component analysis," Expert Systems with Applications, 39(4), 2012.

License

MIT License - See LICENSE file

Future Work
 Integration with real wafer defect data
 Hybrid models (GMDH + machine learning ensemble)
 Dynamic clustering metrics for real-time analysis
 Production environment deployment
 Non-linear dimensionality reduction (t-SNE, UMAP)
References
Ivakhnenko, A. G. (1971). Polynomial Theory of Complex Systems
Pearson, K. (1901). On lines and planes of closest fit
Jun-Shuw Lin (2012). Expert Systems with Applications, 39(4)

Last Updated: November 2024
Project Status: Complete
