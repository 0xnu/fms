## FMS — Financial Modelling System

FMS implements a financial model for stock market simulation using [OCaml](https://en.wikipedia.org/wiki/OCaml). It models the behaviour of a £5,000 investment over 3 years, providing an understanding of potential outcomes and risk metrics for both individual stocks and the overall portfolio.

> [!WARNING]
> Disclaimer: FMS is for educational purposes only! Please do not use it for actual investment decisions. Always consult a qualified financial advisor for investment choices.

### Features

- Monte Carlo simulation of stock price movements
- Portfolio modelling with multiple stocks (AAPL, GOOGL, MSFT, NVDA, META)
- Risk metrics calculation (Value at Risk, Expected Return, Probability of Profit, Sharpe Ratio)
- Configurable parameters (investment amount, time horizon, stock characteristics)

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

- Overall portfolio metrics (Expected Return, VaR, Probability of Profit, Sharpe Ratio)
- Individual stock metrics (Current Price, Expected Return, Probability of Profit, Sharpe Ratio)

### Customisation

Modify `fms.ml` to adjust:

- Initial investment and investment horizon
- Stock portfolio composition and characteristics
- Number of Monte Carlo simulations

### License

This project is licensed under the [BSD 3-Clause](LICENSE) License.

### Citation

```tex
@misc{fmsafo2024,
  author       = {Oketunji, A.F.},
  title        = {FMS — Financial Modelling System},
  year         = 2024,
  version      = {0.0.1},
  publisher    = {Zenodo},
  doi          = {},
  url          = {}
}
```

### Copyright

(c) 2024 [Finbarrs Oketunji](https://finbarrs.eu). All Rights Reserved.
