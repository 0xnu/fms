(* Financial Modelling System *)
module FMS = struct
  (* Types *)
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

  (* Constants *)
  let initial_investment = 5000.0
  let investment_horizon = 3 (* years *)
  let simulation_runs = 10000
  let risk_free_rate = 0.02 (* 2% annual risk-free rate *)

  (* Utility functions *)
  let gaussian_random () =
    let u1 = Random.float 1.0 in
    let u2 = Random.float 1.0 in
    sqrt (-2.0 *. log u1) *. cos (2.0 *. Float.pi *. u2)

  (* Stock price simulation *)
  let simulate_stock_price stock time =
    let drift = (stock.expected_return -. 0.5 *. stock.volatility ** 2.0) *. time in
    let random_component = stock.volatility *. sqrt time *. gaussian_random () in
    stock.current_price *. exp (drift +. random_component)

  (* Portfolio simulation *)
  let simulate_portfolio portfolio time =
    let simulate_holding (stock, quantity) =
      let new_price = simulate_stock_price stock time in
      (new_price -. stock.current_price) *. float_of_int quantity
    in
    List.map simulate_holding portfolio.stocks

  (* Monte Carlo simulation *)
  let monte_carlo_simulation portfolio =
    List.init simulation_runs (fun _ -> simulate_portfolio portfolio (float_of_int investment_horizon))

  (* Risk metrics *)
  let calculate_var results confidence_level =
    let sorted_results = List.sort Float.compare results in
    let index = int_of_float (float_of_int (List.length sorted_results) *. (1.0 -. confidence_level)) in
    List.nth sorted_results index

  let calculate_expected_return results =
    let sum = List.fold_left (+.) 0.0 results in
    sum /. float_of_int (List.length results)

  let calculate_probability_of_profit results =
    let profitable_runs = List.filter (fun x -> x > 0.0) results in
    100.0 *. float_of_int (List.length profitable_runs) /. float_of_int (List.length results)

  let calculate_sharpe_ratio results =
    let expected_return = calculate_expected_return results in
    let std_dev =
      let squared_diff = List.map (fun x -> (x -. expected_return) ** 2.0) results in
      sqrt (List.fold_left (+.) 0.0 squared_diff /. float_of_int (List.length results))
    in
    (expected_return -. risk_free_rate) /. std_dev

  (* Main function *)
  let run_simulation () =
    Random.self_init ();
    let portfolio_experiment = {
      stocks = [
        ({symbol = "TSLA"; current_price = 260.13; volatility = 0.45; expected_return = 0.15}, 5); (* Autonomous Vehicles *)
        ({symbol = "GOOGL"; current_price = 165.27; volatility = 0.30; expected_return = 0.12}, 7); (* AI *)
        ({symbol = "NVDA"; current_price = 121.35; volatility = 0.40; expected_return = 0.18}, 10); (* AI & Autonomous Vehicles *)
        ({symbol = "IBM"; current_price = 223.93; volatility = 0.25; expected_return = 0.10}, 6); (* Quantum Computing *)
        ({symbol = "MSFT"; current_price = 429.93; volatility = 0.25; expected_return = 0.11}, 3); (* Cloud Computing *)
        ({symbol = "AMZN"; current_price = 188.41; volatility = 0.35; expected_return = 0.14}, 6); (* AI & Cloud Computing *)
        ({symbol = "BIDU"; current_price = 106.98; volatility = 0.50; expected_return = 0.16}, 10); (* Autonomous Vehicles & AI *)
        ({symbol = "IONQ"; current_price = 9.72; volatility = 0.60; expected_return = 0.20}, 100); (* Quantum Computing *)
        ({symbol = "CRM"; current_price = 277.26; volatility = 0.30; expected_return = 0.13}, 4); (* Cloud Computing *)
        ({symbol = "AMD"; current_price = 167.85; volatility = 0.45; expected_return = 0.17}, 6); (* AI & Cloud Computing *)
      ];
      cash = 500.0;
    } in

    let results = monte_carlo_simulation portfolio_experiment in

    (* Calculate overall portfolio metrics *)
    let overall_results = List.map (List.fold_left (+.) 0.0) results in
    let expected_return = calculate_expected_return overall_results in
    let var_95 = calculate_var overall_results 0.95 in
    let var_99 = calculate_var overall_results 0.99 in
    let prob_profit = calculate_probability_of_profit overall_results in
    let sharpe_ratio = calculate_sharpe_ratio overall_results in

    (* Calculate individual stock metrics *)
    let stock_metrics = List.mapi (fun i stock ->
      let stock_results = List.map (fun run -> List.nth run i) results in
      let stock_expected_return = calculate_expected_return stock_results in
      let stock_prob_profit = calculate_probability_of_profit stock_results in
      let stock_sharpe_ratio = calculate_sharpe_ratio stock_results in
      (fst stock, stock_expected_return, stock_prob_profit, stock_sharpe_ratio)
    ) portfolio_experiment.stocks in

    (* Print results *)
    Printf.printf "Initial Investment: £%.2f\n" initial_investment;
    Printf.printf "Investment Horizon: %d years\n" investment_horizon;
    Printf.printf "\nOverall Portfolio Metrics:\n";
    Printf.printf "Expected Return: £%.2f\n" expected_return;
    Printf.printf "Value at Risk (95%% confidence): £%.2f\n" var_95;
    Printf.printf "Value at Risk (99%% confidence): £%.2f\n" var_99;
    Printf.printf "Probability of Profit: %.2f%%\n" prob_profit;
    Printf.printf "Sharpe Ratio: %.2f\n\n" sharpe_ratio;

    Printf.printf "Individual Stock Metrics:\n";
    List.iter (fun (stock, exp_return, prob_profit, sharpe_ratio) ->
      Printf.printf "%s:\n" stock.symbol;
      Printf.printf "  Current Price: £%.2f\n" stock.current_price;
      Printf.printf "  Expected Return: £%.2f\n" exp_return;
      Printf.printf "  Probability of Profit: %.2f%%\n" prob_profit;
      Printf.printf "  Sharpe Ratio: %.2f\n\n" sharpe_ratio;
    ) stock_metrics;
end

(* Run the simulation *)
let () = FMS.run_simulation ()
