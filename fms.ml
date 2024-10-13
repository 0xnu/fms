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

  (* New function to read stocks from file *)
  let read_stocks_from_file filename =
    let ic = open_in filename in
    let content = really_input_string ic (in_channel_length ic) in
    close_in ic;
    Printf.printf "File content:\n%s\n" content;  (* Debug print *)
    if String.length content = 0 then
      raise (Failure "File is empty")
    else
      let lines = String.split_on_char '\n' content in
      let stock_lines = List.filter (fun line ->
        let trimmed = String.trim line in
        String.length trimmed > 0 && not (String.starts_with ~prefix:"(*" trimmed) &&
        not (String.starts_with ~prefix:"stocks =" trimmed) &&
        not (String.starts_with ~prefix:"];" trimmed)
      ) lines in
      let parse_stock str =
        try
          Scanf.sscanf str " ({symbol = %S; current_price = %f; volatility = %f; expected_return = %f}, %d)"
            (fun symbol price volatility return quantity ->
              Some ({symbol = symbol; current_price = price; volatility = volatility; expected_return = return}, quantity))
        with e ->
          Printf.printf "Failed to parse stock: '%s'\n" str;
          Printf.printf "Error: %s\n" (Printexc.to_string e);
          None
      in
      let stocks = List.filter_map parse_stock stock_lines in
      if List.length stocks = 0 then
        raise (Failure "No valid stocks found in the file")
      else
        stocks

  (* Main function *)
  let run_simulation () =
    Random.self_init ();
    let stocks =
      try
        read_stocks_from_file "stocks.txt"
      with
      | Failure msg ->
          Printf.printf "Error: %s\n" msg;
          exit 1
    in
    Printf.printf "Successfully parsed %d stocks.\n" (List.length stocks);

    let portfolio_experiment = {
      stocks = stocks;
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
