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

  let sigmoid x =
    1. /. (1. +. exp (-.x))

  let tanh x =
    (exp x -. exp (-.x)) /. (exp x +. exp (-.x))

  (* SR-LSTM functions *)
  let calculate_regulatory_factor state weights bias =
    let dot_product = Array.fold_left (fun (acc, i) w -> (acc +. w *. state.h.(i), i + 1)) (0., 0) weights |> fst in
    max 0. (dot_product +. bias) (* ReLU activation *)

  let sr_lstm_predict input state weights biases =
    let r_t = calculate_regulatory_factor state weights.r_weights biases.r_bias in

    let f_t = sigmoid (Array.fold_left (fun (acc, i) w -> (acc +. w *. input.(i), i + 1)) (biases.f_bias, 0) weights.f_weights |> fst) in
    let i_t = sigmoid (Array.fold_left (fun (acc, i) w -> (acc +. w *. input.(i), i + 1)) (biases.i_bias, 0) weights.i_weights |> fst) in
    let c_tilde = tanh (Array.fold_left (fun (acc, i) w -> (acc +. w *. input.(i), i + 1)) (biases.c_bias, 0) weights.c_weights |> fst) in
    let o_t = sigmoid (Array.fold_left (fun (acc, i) w -> (acc +. w *. input.(i), i + 1)) (biases.o_bias, 0) weights.o_weights |> fst) in

    let f_t' = f_t *. r_t in
    let i_t' = i_t *. r_t in

    let c_new = (f_t' *. state.c.(0)) +. (i_t' *. c_tilde) in
    let h_new = o_t *. tanh c_new in

    let new_state = { h = [|h_new|]; c = [|c_new|] } in
    (new_state, h_new)

  (* Stock price simulation functions *)
  let simulate_stock_price stock time =
    let annual_return = stock.expected_return in
    let annual_volatility = stock.volatility in
    let drift = (annual_return -. 0.5 *. annual_volatility ** 2.0) *. time in
    let random_shock = annual_volatility *. sqrt time *. gaussian_random () in
    stock.current_price *. exp (drift +. random_shock)

  let simulate_stock_price_sr_lstm stock _time sr_lstm_state weights biases =
    let input = [|stock.current_price; stock.volatility; stock.expected_return|] in
    let (_, prediction) = sr_lstm_predict input sr_lstm_state weights biases in
    stock.current_price *. (1.0 +. prediction)

  (* Portfolio simulation *)
  let simulate_portfolio portfolio time =
    let simulate_holding (stock, quantity) =
      let new_price = simulate_stock_price stock time in
      (new_price -. stock.current_price) *. float_of_int quantity
    in
    List.map simulate_holding portfolio.stocks

  (* Portfolio simulation using SR-LSTM *)
  let simulate_portfolio_sr_lstm portfolio time sr_lstm_states weights biases =
    let simulate_holding (stock, quantity) sr_lstm_state =
      let new_price = simulate_stock_price_sr_lstm stock time sr_lstm_state weights biases in
      (new_price -. stock.current_price) *. float_of_int quantity
    in
    List.map2 simulate_holding portfolio.stocks sr_lstm_states

  (* Monte Carlo simulation *)
  let monte_carlo_simulation portfolio =
    List.init simulation_runs (fun _ -> simulate_portfolio portfolio (float_of_int investment_horizon))

  (* Monte Carlo simulation using SR-LSTM *)
  let monte_carlo_simulation_sr_lstm portfolio sr_lstm_states weights biases =
    List.init simulation_runs (fun _ ->
      simulate_portfolio_sr_lstm portfolio (float_of_int investment_horizon) sr_lstm_states weights biases)

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

  (* Dynamic portfolio value calculation *)
  let calculate_dynamic_portfolio_value portfolio time =
    let simulate_holding (stock, quantity) =
      let new_price = simulate_stock_price stock time in
      new_price *. float_of_int quantity
    in
    let stock_values = List.map simulate_holding portfolio.stocks in
    List.fold_left (+.) portfolio.cash stock_values

  (* Main function *)
  let run_simulation () =
    Random.self_init ();
    let portfolio_experiment = {
      stocks = [
        ({symbol = "TSLA"; current_price = 260.13; volatility = 0.45; expected_return = 0.15}, 1);
        ({symbol = "GOOGL"; current_price = 165.27; volatility = 0.30; expected_return = 0.12}, 2);
        ({symbol = "NVDA"; current_price = 121.35; volatility = 0.40; expected_return = 0.18}, 3);
        ({symbol = "IBM"; current_price = 223.93; volatility = 0.25; expected_return = 0.10}, 1);
        ({symbol = "MSFT"; current_price = 429.93; volatility = 0.25; expected_return = 0.11}, 1);
        ({symbol = "AMZN"; current_price = 188.41; volatility = 0.35; expected_return = 0.14}, 2);
        ({symbol = "BIDU"; current_price = 106.98; volatility = 0.50; expected_return = 0.16}, 3);
        ({symbol = "IONQ"; current_price = 9.72; volatility = 0.60; expected_return = 0.20}, 33);
        ({symbol = "CRM"; current_price = 277.26; volatility = 0.30; expected_return = 0.13}, 1);
        ({symbol = "AMD"; current_price = 167.85; volatility = 0.45; expected_return = 0.17}, 2);
        ({symbol = "QUBT"; current_price = 0.67; volatility = 0.70; expected_return = 0.25}, 165);
        ({symbol = "RGTI"; current_price = 0.75; volatility = 0.65; expected_return = 0.23}, 127);
        ({symbol = "ARRXF"; current_price = 0.18; volatility = 0.80; expected_return = 0.28}, 582);
        ({symbol = "QBTS"; current_price = 0.92; volatility = 0.68; expected_return = 0.24}, 118);
        ({symbol = "NIO"; current_price = 6.70; volatility = 0.55; expected_return = 0.20}, 37);
        ({symbol = "REKR"; current_price = 1.10; volatility = 0.60; expected_return = 0.22}, 82);
        ({symbol = "LTRX"; current_price = 3.92; volatility = 0.50; expected_return = 0.18}, 34);
        ({symbol = "AEVA"; current_price = 3.08; volatility = 0.75; expected_return = 0.26}, 223);
        ({symbol = "VLDR"; current_price = 1.26; volatility = 0.72; expected_return = 0.25}, 205);
        ({symbol = "ARBE"; current_price = 1.88; volatility = 0.68; expected_return = 0.24}, 151);
        ({symbol = "MVIS"; current_price = 1.15; volatility = 0.65; expected_return = 0.23}, 115);
        ({symbol = "GOEV"; current_price = 0.96; volatility = 0.85; expected_return = 0.30}, 798);
        ({symbol = "AUR"; current_price = 5.19; volatility = 0.78; expected_return = 0.27}, 255);
        ({symbol = "FRSX"; current_price = 0.70; volatility = 0.85; expected_return = 0.30}, 798);
        ({symbol = "SLI"; current_price = 1.63; volatility = 0.70; expected_return = 0.25}, 100);
        ({symbol = "NRVTF"; current_price = 0.094; volatility = 0.80; expected_return = 0.28}, 1000);
        ({symbol = "WWR"; current_price = 0.51; volatility = 0.75; expected_return = 0.26}, 200);
        ({symbol = "AMLI"; current_price = 0.55; volatility = 0.72; expected_return = 0.25}, 180);
        (* avionics and autonomous systems stocks *)
        ({symbol = "CVU"; current_price = 3.33; volatility = 0.65; expected_return = 0.22}, 50);
        ({symbol = "BBAI"; current_price = 1.61; volatility = 0.70; expected_return = 0.24}, 100);
        ({symbol = "LUNA"; current_price = 1.90; volatility = 0.68; expected_return = 0.23}, 85);
        ({symbol = "ONDS"; current_price = 0.90; volatility = 0.75; expected_return = 0.26}, 180);
        ({symbol = "AVAV"; current_price = 215.39; volatility = 0.55; expected_return = 0.20}, 1);
      ];
      cash = 0.0;
    } in

    (* Initialize SR-LSTM states, weights, and biases *)
    let sr_lstm_states = List.map (fun _ -> { h = [|0.; 0.; 0.|]; c = [|0.; 0.; 0.|] }) portfolio_experiment.stocks in
    let weights = {
      r_weights = [|0.1; 0.1; 0.1|];
      f_weights = [|0.1; 0.1; 0.1|];
      i_weights = [|0.1; 0.1; 0.1|];
      c_weights = [|0.1; 0.1; 0.1|];
      o_weights = [|0.1; 0.1; 0.1|];
    } in
    let biases = {
      r_bias = 0.1;
      f_bias = 0.1;
      i_bias = 0.1;
      c_bias = 0.1;
      o_bias = 0.1;
    } in

    let traditional_results = monte_carlo_simulation portfolio_experiment in
    let sr_lstm_results = monte_carlo_simulation_sr_lstm portfolio_experiment sr_lstm_states weights biases in

    (* Calculate overall portfolio metrics *)
    let calculate_metrics results =
      let overall_results = List.map (List.fold_left (+.) 0.0) results in
      let expected_return = calculate_expected_return overall_results in
      let var_95 = calculate_var overall_results 0.95 in
      let var_99 = calculate_var overall_results 0.99 in
      let prob_profit = calculate_probability_of_profit overall_results in
      let sharpe_ratio = calculate_sharpe_ratio overall_results in
      (expected_return, var_95, var_99, prob_profit, sharpe_ratio)
    in

    let (trad_expected_return, trad_var_95, trad_var_99, trad_prob_profit, trad_sharpe_ratio) =
      calculate_metrics traditional_results in
    let (sr_expected_return, sr_var_95, sr_var_99, sr_prob_profit, sr_sharpe_ratio) =
      calculate_metrics sr_lstm_results in

    (* Calculate individual stock metrics *)
    let calculate_stock_metrics results =
      List.mapi (fun i stock ->
        let stock_results = List.map (fun run -> List.nth run i) results in
        let stock_expected_return = calculate_expected_return stock_results in
        let stock_prob_profit = calculate_probability_of_profit stock_results in
        let stock_sharpe_ratio = calculate_sharpe_ratio stock_results in
        (fst stock, stock_expected_return, stock_prob_profit, stock_sharpe_ratio)
      ) portfolio_experiment.stocks
    in

    let trad_stock_metrics = calculate_stock_metrics traditional_results in
    let sr_stock_metrics = calculate_stock_metrics sr_lstm_results in

    (* Print results *)
    Printf.printf "Initial Investment: £%.2f\n" initial_investment;
    Printf.printf "Investment Horizon: %d years\n" investment_horizon;
    Printf.printf "\nOverall Portfolio Metrics:\n";
    Printf.printf "                   Traditional   SR-LSTM\n";
    Printf.printf "Expected Return:   £%.2f         £%.2f\n" trad_expected_return sr_expected_return;
    Printf.printf "VaR (95%%):        £%.2f         £%.2f\n" trad_var_95 sr_var_95;
    Printf.printf "VaR (99%%):        £%.2f         £%.2f\n" trad_var_99 sr_var_99;
    Printf.printf "Prob. of Profit:   %.2f%%         %.2f%%\n" trad_prob_profit sr_prob_profit;
    Printf.printf "Sharpe Ratio:      %.2f           %.2f\n\n" trad_sharpe_ratio sr_sharpe_ratio;

    Printf.printf "Individual Stock Metrics:\n";
    List.iter2 (fun (stock, trad_exp_return, trad_prob_profit, trad_sharpe_ratio)
                    (_, sr_exp_return, sr_prob_profit, sr_sharpe_ratio) ->
      Printf.printf "%s:\n" stock.symbol;
      Printf.printf "  Current Price: £%.2f\n" stock.current_price;
      Printf.printf "  Traditional Model:\n";
      Printf.printf "    Expected Return: £%.2f\n" trad_exp_return;
      Printf.printf "    Probability of Profit: %.2f%%\n" trad_prob_profit;
      Printf.printf "    Sharpe Ratio: %.2f\n" trad_sharpe_ratio;
      Printf.printf "  SR-LSTM Model:\n";
      Printf.printf "    Expected Return: £%.2f\n" sr_exp_return;
      Printf.printf "    Probability of Profit: %.2f%%\n" sr_prob_profit;
      Printf.printf "    Sharpe Ratio: %.2f\n\n" sr_sharpe_ratio;
    ) trad_stock_metrics sr_stock_metrics;

    (* Calculate and print dynamic portfolio value *)
    let dynamic_portfolio_value = calculate_dynamic_portfolio_value portfolio_experiment (float_of_int investment_horizon) in
    Printf.printf "Dynamic Portfolio Value after %d years: £%.2f\n" investment_horizon dynamic_portfolio_value;

    (* Calculate and print the difference between traditional and SR-LSTM expected returns *)
    let trad_total_return = List.fold_left (fun acc (_, exp_return, _, _) -> acc +. exp_return) 0.0 trad_stock_metrics in
    let sr_total_return = List.fold_left (fun acc (_, exp_return, _, _) -> acc +. exp_return) 0.0 sr_stock_metrics in
    Printf.printf "\nComparison of Total Expected Returns:\n";
    Printf.printf "Traditional Model: £%.2f\n" trad_total_return;
    Printf.printf "SR-LSTM Model: £%.2f\n" sr_total_return;
    Printf.printf "Difference (SR-LSTM - Traditional): £%.2f\n" (sr_total_return -. trad_total_return);

    (* Calculate and print the average Sharpe ratio for both models *)
    let avg_trad_sharpe = List.fold_left (fun acc (_, _, _, sharpe) -> acc +. sharpe) 0.0 trad_stock_metrics /. float_of_int (List.length trad_stock_metrics) in
    let avg_sr_sharpe = List.fold_left (fun acc (_, _, _, sharpe) -> acc +. sharpe) 0.0 sr_stock_metrics /. float_of_int (List.length sr_stock_metrics) in
    Printf.printf "\nAverage Sharpe Ratios:\n";
    Printf.printf "Traditional Model: %.2f\n" avg_trad_sharpe;
    Printf.printf "SR-LSTM Model: %.2f\n" avg_sr_sharpe;

    (* Identify the best performing stock based on Sharpe ratio for both models *)
    let best_trad_stock = List.fold_left (fun acc (stock, _, _, sharpe) ->
      if sharpe > (let _, _, _, acc_sharpe = acc in acc_sharpe)
      then (stock, 0.0, 0.0, sharpe)
      else acc
    ) (List.hd trad_stock_metrics) trad_stock_metrics in
    let best_sr_stock = List.fold_left (fun acc (stock, _, _, sharpe) ->
      if sharpe > (let _, _, _, acc_sharpe = acc in acc_sharpe)
      then (stock, 0.0, 0.0, sharpe)
      else acc
    ) (List.hd sr_stock_metrics) sr_stock_metrics in
    Printf.printf "\nBest Performing Stocks (Based on Sharpe Ratio):\n";
    Printf.printf "Traditional Model: %s (Sharpe Ratio: %.2f)\n"
      (let stock, _, _, _ = best_trad_stock in stock.symbol)
      (let _, _, _, sharpe = best_trad_stock in sharpe);
    Printf.printf "SR-LSTM Model: %s (Sharpe Ratio: %.2f)\n"
      (let stock, _, _, _ = best_sr_stock in stock.symbol)
      (let _, _, _, sharpe = best_sr_stock in sharpe);
end

(* Run the simulation *)
let () = FMS.run_simulation ()
