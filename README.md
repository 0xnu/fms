## FMS — Financial Modelling System

FMS implements a financial model for stock market simulation using [OCaml](https://en.wikipedia.org/wiki/OCaml). It models the behaviour of a £5,000 investment over 3 years, providing an understanding of potential outcomes and risk metrics for both individual stocks and the overall portfolio.

> [!WARNING]
> Disclaimer: FMS is for educational purposes only! Please do not use it for actual investment decisions. Always consult a qualified financial advisor for investment choices.

### Features

- Monte Carlo simulation of stock price movements using both traditional and SR-LSTM models
- Portfolio modelling with multiple stocks (TSLA, GOOGL, NVDA, IBM, MSFT, AMZN, and many more)
- Risk metrics calculation (Value at Risk, Expected Return, Probability of Profit, Sharpe Ratio)
- Configurable parameters (investment amount, time horizon, stock characteristics)
- Dynamic Portfolio Value calculation to estimate future portfolio worth
- SR-LSTM (Self-Regulating Long Short-Term Memory) implementation for advanced stock price prediction
- Comparative analysis between traditional Monte Carlo and SR-LSTM models
- Individual stock performance metrics for both traditional and SR-LSTM models
- Identification of best-performing stocks based on Sharpe Ratio
- Calculation of the average Sharpe Ratio across the portfolio for both models
- Detailed output of overall portfolio metrics and individual stock metrics
- Extensive portfolio with a mix of established tech giants and emerging technology companies

### Mathematical Model

#### Stock Price Simulation

Stock prices follow geometric Brownian motion:

$$dS = \mu S dt + \sigma S dW$$

where $S$ is the stock price, $\mu$ is the drift, $\sigma$ is the volatility, and $dW$ is a Wiener process.

The discrete simulation uses:

$$S(t + \Delta t) = S(t) \exp\left(\left(\mu - \frac{\sigma^2}{2}\right)\Delta t + \sigma \sqrt{\Delta t} Z\right)$$

where $Z$ is a standard normal random variable.

#### Portfolio Value

The portfolio value $V$ at time $t$ is:

$$V(t) = \sum_{i=1}^{n} q_i S_i(t) + C$$

where $q_i$ is the quantity of stock $i$, $S_i(t)$ is the price of stock $i$ at time $t$, and $C$ is the cash holding.

### Risk Metrics

#### Value at Risk (VaR)

VaR is calculated using the percentile method:

$$VaR_\alpha = -\text{percentile}(1-\alpha, \{V_1, V_2, ..., V_n\})$$

where $\{V_1, V_2, ..., V_n\}$ are the simulated portfolio values.

#### Expected Return

The expected return is:

$$E[R] = \frac{1}{n} \sum_{i=1}^{n} \frac{V_i - V_0}{V_0}$$

where $V_0$ is the initial portfolio value.

#### Probability of Profit

Calculated for both individual stocks and the overall portfolio.

#### Sharpe Ratio

The Sharpe Ratio is calculated as:

$$\text{Sharpe Ratio} = \frac{E[R] - R_f}{\sigma}$$

where $E[R]$ is the expected return, $R_f$ is the risk-free rate, and $\sigma$ is the standard deviation of returns.

#### Dynamic Portfolio Value

The portfolio value $V$ at time $t$ remains:

$$V(t) = \sum_{i=1}^{n} w_i(t) S_i(t) + C(t)$$

where $w_i(t)$ is the dynamic weight of stock $i$, $S_i(t)$ is the price of stock $i$ at time $t$, and $C(t)$ is the cash holding at time $t$.

#### Machine Learning Integration with SR-LSTM

We incorporate a [Self-Regulating Long Short-Term Memory](https://arxiv.org/abs/2312.08948) (SR-LSTM) neural network to predict future stock prices:

+ Regulatory Factor Calculation:

   $$R_t = \rho(W_r \cdot h_{t-1} + b_r)$$

   Here, $R_t$ is the regulatory factor for time step $t$, $W_r$ is the weight matrix, $b_r$ is the bias term, and $\rho$ is a non-linear activation function.

+ Modified Forget and Input Gates:

   $$f'_t = f_t \odot R_t$$
   $$i'_t = i_t \odot R_t$$

   We modify the standard forget gate $f_t$ and input gate $i_t$ by the regulatory factor $R_t$ to adjust the information flow dynamically.

+ Cell State and Output Gate:

   The cell state update and output gate equations remain the same as in standard LSTM, but they operate on the modified gates $f'_t$ and $i'_t$.

### Prerequisite

- [OCaml](https://ocaml.org/) (version 4.08 or higher recommended)
- [OPAM](https://opam.ocaml.org/) (OCaml Package Manager)
- [Make](https://en.wikipedia.org/wiki/Make_(software))

### Building and Running

1. Clone the repository and navigate to the project directory.

2. Build and run the simulation:

```sh
eval $(opam env) && make clean && make all VERBOSE=1 && ./fms
```

### Output

The simulation displays:

- Initial investment amount and investment horizon
- Overall portfolio metrics for both Traditional and SR-LSTM models:
  - Expected Return
  - Value at Risk (VaR) at 95% and 99% confidence levels
  - Probability of Profit
  - Sharpe Ratio
- Individual stock metrics for both Traditional and SR-LSTM models:
  - Current Price
  - Expected Return
  - Probability of Profit
  - Sharpe Ratio
- Dynamic Portfolio Value estimation after the investment horizon
- Comparison of Total Expected Returns between Traditional and SR-LSTM models
- Difference in expected returns between the two models
- Average Sharpe Ratios for both Traditional and SR-LSTM models across the portfolio
- Best Performing Stocks based on Sharpe Ratio for both models

### Customisation

Modify `fms.ml` to adjust:

- Initial investment and investment horizon
- Stock portfolio composition and characteristics
- Number of Monte Carlo simulations

### Future Enhancements (Maybe)

a. Singular Value Decomposition (SVD)

SVD decomposes a matrix $A$ into three matrices:

$$A = U\Sigma V^T$$

Where:

- $A$ is an $m \times n$ matrix
- $U$ is an $m \times m$ orthogonal matrix
- $\Sigma$ is an $m \times n$ diagonal matrix with non-negative real numbers on the diagonal
- $V^T$ is the transpose of an $n \times n$ orthogonal matrix

The diagonal entries $\sigma_i$ of $\Sigma$ are known as the singular values of $A$. For dimensionality reduction, we can approximate $A$ by keeping only the $k$ largest singular values:

$$A_k = \sum_{i=1}^k \sigma_i u_i v_i^T$$

Where $u_i$ and $v_i$ are the $i$-th columns of $U$ and $V$ respectively.

**Benefit:** We could use SVD to analyse and potentially reduce the dimensionality of our stock data. It would be beneficial if we expanded to a larger number of stocks.

b. QR Decomposition

QR decomposition factors a matrix $A$ into a product of an orthogonal matrix $Q$ and an upper triangular matrix $R$:

$$A = QR$$

Where:
- $A$ is an $m \times n$ matrix
- $Q$ is an $m \times m$ orthogonal matrix
- $R$ is an $m \times n$ upper triangular matrix

For solving least squares problems $Ax = b$, we can use QR decomposition:

$$QRx = b$$
$$Rx = Q^Tb$$

Enables the system to solve efficiently due to $R$ being upper triangular.

**Benefit:** We can use it to solve [least squares](https://en.wikipedia.org/wiki/Least_squares) problems more efficiently, which might be useful for fitting models to historical stock price data.

c. Trust Region Methods

Trust region methods solve optimisation problems of the form:

$$\min_{x \in \mathbb{R}^n} f(x)$$

At each iteration, we solve the subproblem:

$$\min_{p \in \mathbb{R}^n} m_k(p) \quad \text{subject to} \quad \|p\| \leq \Delta_k$$

Where:

- $m_k(p)$ is a quadratic approximation of $f(x_k + p)$:

$$m_k(p) = f(x_k) + g_k^T p + \frac{1}{2} p^T B_k p$$

- $g_k$ is the gradient of $f$ at $x_k$
- $B_k$ is an approximation of the Hessian of $f$ at $x_k$
- $\Delta_k$ is the trust region radius

The next iterate is then:

$$x_{k+1} = x_k + p_k$$

Where $p_k$ is the solution to the subproblem. The trust region radius $\Delta_k$ is adjusted based on the agreement between the model $m_k$ and the actual function $f$.

**Benefit:** It could potentially improve the optimization of our portfolio allocation, especially if we're dealing with [non-convex objective functions](https://en.wikipedia.org/wiki/Rosenbrock_function).

### License

This project is licensed under the [BSD 3-Clause](LICENSE) License.

### Citation

```tex
@misc{fmsafo2024,
  author       = {Oketunji, A.F.},
  title        = {FMS — Financial Modelling System},
  year         = 2024,
  version      = {0.0.4},
  publisher    = {Zenodo},
  doi          = {10.5281/zenodo.13910428},
  url          = {https://doi.org/10.5281/zenodo.13910428}
}
```

### Copyright

(c) 2024 [Finbarrs Oketunji](https://finbarrs.eu). All Rights Reserved.
