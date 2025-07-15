This repository contains a collection of MATLAB scripts and functions organized by topic. These codes are intended for educational, research, and prototyping purposes in various areas of numerical computation and data analysis.


# Machine Learning

Contains MATLAB scripts related to basic machine learning methods and optimization techniques.

- `ml_Project.m`, `ml_Project_JGeraci.m`: Project-specific implementations, including classification tasks on the MNIST dataset.
- `ml_MNIST_display.m`: Visualizes digits from the MNIST dataset.
- `steepestDescent.m`, `steepestDescentExample.m`: Implements the steepest descent algorithm and demonstrates its use.
- `t10k-images-idx3-ubyte`, `t10k-labels-idx1-ubyte`: MNIST test dataset files used in the project.

# Algorithms

  # Fourier Transforms

  Implements numerical methods for analyzing and solving PDEs using spectral and Fourier methods.

  - `myFFT.m`: Custom Fast Fourier Transform function.
  - `heat.m`, `heat2D.m`: 1D and 2D heat equation solvers.
  - `waveSpectralEuler2D.m`, `waveSpectralEuler2D2.m`: 2D wave equation solvers using spectral Euler methods.

  # Runge-Kutta Methods

  Implements second- and fourth-order Runge-Kutta methods for solving systems of differential equations.

  - `RK2.m`, `RK2_TEST.m`, `RK2_ndim.m`: 2nd-order RK methods and tests.
  - `RK4_ndim.m`: 4th-order RK method for multidimensional systems.
  - `ErrorComputationNDIMRK2.m`, `ErrorComputationRK4_NDIM.m`: Computes numerical errors for RK methods.

  # Euler Methods

  Implements and tests basic and forward Euler methods.
  
  - `euler.m`, `euler_test.m`, `feuler.m`: Basic numerical integrators and test cases.

# Matrix Solvers

A collection of direct and iterative methods for solving systems of linear equations.

  - **Direct methods**:
    - `gaussianElimination.m`, `gaussian_elimination2.m`
  - **Iterative methods**:
    - `Jacobi_method.m`, `jacobi_iteration.m`, `jacobi_application.m`
    - `gauss_seidel.m`, `gauss_seidel_app.m`
  - **Comparison and error analysis**:
    - `Comparing_our_matrix_solvers.m`, `Comparison.m`, `plottingErrors.m`
