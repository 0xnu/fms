(** Financial Modelling System *)
module FMS : sig
  (** Types *)
  type stock = {
    symbol: string;
    current_price: float;
    volatility: float;
    expected_return: float;
  }

  type portfolio = {
    stocks: (stock * int) list;
    cash: float;
  }

  type sr_lstm_state = {
    h: float array;
    c: float array;
  }

  type sr_lstm_weights = {
    r_weights: float array;
    f_weights: float array;
    i_weights: float array;
    c_weights: float array;
    o_weights: float array;
  }

  type sr_lstm_biases = {
    r_bias: float;
    f_bias: float;
    i_bias: float;
    c_bias: float;
    o_bias: float;
  }

  (** Constants *)
  val initial_investment : float
  val investment_horizon : int
  val simulation_runs : int
  val risk_free_rate : float

  (** Utility functions *)
  val gaussian_random : unit -> float
  val sigmoid : float -> float
  val tanh : float -> float

  (** SR-LSTM functions *)
  val calculate_regulatory_factor : sr_lstm_state -> float array -> float -> float
  val sr_lstm_predict : float array -> sr_lstm_state -> sr_lstm_weights -> sr_lstm_biases -> sr_lstm_state * float

  (** Stock price simulation functions *)
  val simulate_stock_price : stock -> float -> float
  val simulate_stock_price_sr_lstm : stock -> float -> sr_lstm_state -> sr_lstm_weights -> sr_lstm_biases -> float

  (** Portfolio simulation functions *)
  val simulate_portfolio : portfolio -> float -> float list
  val simulate_portfolio_sr_lstm : portfolio -> float -> sr_lstm_state list -> sr_lstm_weights -> sr_lstm_biases -> float list

  (** Monte Carlo simulation functions *)
  val monte_carlo_simulation : portfolio -> float list list
  val monte_carlo_simulation_sr_lstm : portfolio -> sr_lstm_state list -> sr_lstm_weights -> sr_lstm_biases -> float list list

  (** Risk metrics functions *)
  val calculate_var : float list -> float -> float
  val calculate_expected_return : float list -> float
  val calculate_probability_of_profit : float list -> float
  val calculate_sharpe_ratio : float list -> float

  (** Dynamic portfolio value calculation *)
  val calculate_dynamic_portfolio_value : portfolio -> float -> float

  (** Main function *)
  val run_simulation : unit -> unit
end
