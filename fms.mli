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

    (** Constants *)
    val initial_investment : float
    val investment_horizon : int
    val simulation_runs : int
    val risk_free_rate : float

    (** Main function *)
    val run_simulation : unit -> unit
  end
