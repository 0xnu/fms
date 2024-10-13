## Simulation Result
File content:
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
  ({symbol = "CVU"; current_price = 3.33; volatility = 0.65; expected_return = 0.22}, 50);
  ({symbol = "BBAI"; current_price = 1.61; volatility = 0.70; expected_return = 0.24}, 100);
  ({symbol = "LUNA"; current_price = 1.90; volatility = 0.68; expected_return = 0.23}, 85);
  ({symbol = "ONDS"; current_price = 0.90; volatility = 0.75; expected_return = 0.26}, 180);
  ({symbol = "AVAV"; current_price = 215.39; volatility = 0.55; expected_return = 0.20}, 1);
];

Successfully parsed 33 stocks.
Initial Investment: £5000.00
Investment Horizon: 3 years

Overall Portfolio Metrics:
                   Traditional   SR-LSTM
Expected Return:   £9203.80         £425.69
VaR (95%):        £1057.31         £425.69
VaR (99%):        £-477.27         £425.69
Prob. of Profit:   98.26%         100.00%
Sharpe Ratio:      0.93           6319451803691.85

Individual Stock Metrics:
TSLA:
  Current Price: £260.13
  Traditional Model:
    Expected Return: £151.19
    Probability of Profit: 57.28%
    Sharpe Ratio: 0.40
  SR-LSTM Model:
    Expected Return: £25.93
    Probability of Profit: 100.00%
    Sharpe Ratio: 5688041815575.66

GOOGL:
  Current Price: £165.27
  Traditional Model:
    Expected Return: £140.19
    Probability of Profit: 66.54%
    Sharpe Ratio: 0.54
  SR-LSTM Model:
    Expected Return: £32.94
    Probability of Profit: 100.00%
    Sharpe Ratio: 57920962211220.16

NVDA:
  Current Price: £121.35
  Traditional Model:
    Expected Return: £259.05
    Probability of Profit: 66.70%
    Sharpe Ratio: 0.54
  SR-LSTM Model:
    Expected Return: £36.28
    Probability of Profit: 100.00%
    Sharpe Ratio: 12791168921664.86

IBM:
  Current Price: £223.93
  Traditional Model:
    Expected Return: £77.34
    Probability of Profit: 68.15%
    Sharpe Ratio: 0.56
  SR-LSTM Model:
    Expected Return: £22.32
    Probability of Profit: 100.00%
    Sharpe Ratio: 25829272113190.31

MSFT:
  Current Price: £429.93
  Traditional Model:
    Expected Return: £167.22
    Probability of Profit: 70.35%
    Sharpe Ratio: 0.61
  SR-LSTM Model:
    Expected Return: £42.85
    Probability of Profit: 100.00%
    Sharpe Ratio: 8723333355665.99

AMZN:
  Current Price: £188.41
  Traditional Model:
    Expected Return: £195.10
    Probability of Profit: 65.10%
    Sharpe Ratio: 0.51
  SR-LSTM Model:
    Expected Return: £37.56
    Probability of Profit: 100.00%
    Sharpe Ratio: 9729001998600.08

BIDU:
  Current Price: £106.98
  Traditional Model:
    Expected Return: £198.68
    Probability of Profit: 55.02%
    Sharpe Ratio: 0.37
  SR-LSTM Model:
    Expected Return: £31.99
    Probability of Profit: 100.00%
    Sharpe Ratio: 6075417118412.12

IONQ:
  Current Price: £9.72
  Traditional Model:
    Expected Return: £267.23
    Probability of Profit: 52.06%
    Sharpe Ratio: 0.33
  SR-LSTM Model:
    Expected Return: £15.14
    Probability of Profit: 100.00%
    Sharpe Ratio: 39040857415459.50

CRM:
  Current Price: £277.26
  Traditional Model:
    Expected Return: £133.75
    Probability of Profit: 68.76%
    Sharpe Ratio: 0.58
  SR-LSTM Model:
    Expected Return: £27.63
    Probability of Profit: 100.00%
    Sharpe Ratio: 99649172097143.70

AMD:
  Current Price: £167.85
  Traditional Model:
    Expected Return: £221.92
    Probability of Profit: 60.38%
    Sharpe Ratio: 0.44
  SR-LSTM Model:
    Expected Return: £33.46
    Probability of Profit: 100.00%
    Sharpe Ratio: 22844934659129.20

QUBT:
  Current Price: £0.67
  Traditional Model:
    Expected Return: £130.92
    Probability of Profit: 50.52%
    Sharpe Ratio: 0.30
  SR-LSTM Model:
    Expected Return: £0.90
    Probability of Profit: 100.00%
    Sharpe Ratio: 28246880893737.76

RGTI:
  Current Price: £0.75
  Traditional Model:
    Expected Return: £89.72
    Probability of Profit: 51.29%
    Sharpe Ratio: 0.31
  SR-LSTM Model:
    Expected Return: £0.78
    Probability of Profit: 100.00%
    Sharpe Ratio: 10751130421952.17

ARRXF:
  Current Price: £0.18
  Traditional Model:
    Expected Return: £124.02
    Probability of Profit: 45.92%
    Sharpe Ratio: 0.26
  SR-LSTM Model:
    Expected Return: £0.72
    Probability of Profit: 100.00%
    Sharpe Ratio: 4617870917461.39

QBTS:
  Current Price: £0.92
  Traditional Model:
    Expected Return: £115.03
    Probability of Profit: 50.42%
    Sharpe Ratio: 0.23
  SR-LSTM Model:
    Expected Return: £0.98
    Probability of Profit: 100.00%
    Sharpe Ratio: 60299936248792.82

NIO:
  Current Price: £6.70
  Traditional Model:
    Expected Return: £204.72
    Probability of Profit: 56.79%
    Sharpe Ratio: 0.40
  SR-LSTM Model:
    Expected Return: £8.34
    Probability of Profit: 100.00%
    Sharpe Ratio: 12597775074263.33

REKR:
  Current Price: £1.10
  Traditional Model:
    Expected Return: £82.35
    Probability of Profit: 53.68%
    Sharpe Ratio: 0.35
  SR-LSTM Model:
    Expected Return: £0.84
    Probability of Profit: 100.00%
    Sharpe Ratio: 3852108122675.19

LTRX:
  Current Price: £3.92
  Traditional Model:
    Expected Return: £97.75
    Probability of Profit: 57.74%
    Sharpe Ratio: 0.39
  SR-LSTM Model:
    Expected Return: £2.74
    Probability of Profit: 100.00%
    Sharpe Ratio: 13679242233968.17

AEVA:
  Current Price: £3.08
  Traditional Model:
    Expected Return: £850.39
    Probability of Profit: 47.70%
    Sharpe Ratio: 0.26
  SR-LSTM Model:
    Expected Return: £12.57
    Probability of Profit: 100.00%
    Sharpe Ratio: 10119177724433.09

VLDR:
  Current Price: £1.26
  Traditional Model:
    Expected Return: £303.03
    Probability of Profit: 49.00%
    Sharpe Ratio: 0.29
  SR-LSTM Model:
    Expected Return: £2.71
    Probability of Profit: 100.00%
    Sharpe Ratio: 6836991319670.23

ARBE:
  Current Price: £1.88
  Traditional Model:
    Expected Return: £278.59
    Probability of Profit: 49.71%
    Sharpe Ratio: 0.31
  SR-LSTM Model:
    Expected Return: £3.63
    Probability of Profit: 100.00%
    Sharpe Ratio: 5553941547439.85

MVIS:
  Current Price: £1.15
  Traditional Model:
    Expected Return: £129.00
    Probability of Profit: 51.96%
    Sharpe Ratio: 0.30
  SR-LSTM Model:
    Expected Return: £1.29
    Probability of Profit: 100.00%
    Sharpe Ratio: 4748939430490.32

GOEV:
  Current Price: £0.96
  Traditional Model:
    Expected Return: £1193.82
    Probability of Profit: 45.82%
    Sharpe Ratio: 0.21
  SR-LSTM Model:
    Expected Return: £7.69
    Probability of Profit: 100.00%
    Sharpe Ratio: 8694852424329.26

AUR:
  Current Price: £5.19
  Traditional Model:
    Expected Return: £1622.99
    Probability of Profit: 47.91%
    Sharpe Ratio: 0.27
  SR-LSTM Model:
    Expected Return: £37.16
    Probability of Profit: 100.00%
    Sharpe Ratio: 4334120185663.58

FRSX:
  Current Price: £0.70
  Traditional Model:
    Expected Return: £771.28
    Probability of Profit: 44.94%
    Sharpe Ratio: 0.24
  SR-LSTM Model:
    Expected Return: £5.05
    Probability of Profit: 100.00%
    Sharpe Ratio: 8975127001711.24

SLI:
  Current Price: £1.63
  Traditional Model:
    Expected Return: £186.33
    Probability of Profit: 50.63%
    Sharpe Ratio: 0.30
  SR-LSTM Model:
    Expected Return: £1.94
    Probability of Profit: 100.00%
    Sharpe Ratio: 13631289150429.43

NRVTF:
  Current Price: £0.09
  Traditional Model:
    Expected Return: £130.27
    Probability of Profit: 47.29%
    Sharpe Ratio: 0.26
  SR-LSTM Model:
    Expected Return: £0.62
    Probability of Profit: 100.00%
    Sharpe Ratio: 17653514782188.89

WWR:
  Current Price: £0.51
  Traditional Model:
    Expected Return: £116.29
    Probability of Profit: 47.51%
    Sharpe Ratio: 0.26
  SR-LSTM Model:
    Expected Return: £0.80
    Probability of Profit: 100.00%
    Sharpe Ratio: 6748258525663.40

AMLI:
  Current Price: £0.55
  Traditional Model:
    Expected Return: £110.53
    Probability of Profit: 48.51%
    Sharpe Ratio: 0.29
  SR-LSTM Model:
    Expected Return: £0.77
    Probability of Profit: 100.00%
    Sharpe Ratio: 9196238283980.60

CVU:
  Current Price: £3.33
  Traditional Model:
    Expected Return: £154.40
    Probability of Profit: 51.21%
    Sharpe Ratio: 0.31
  SR-LSTM Model:
    Expected Return: £3.13
    Probability of Profit: 100.00%
    Sharpe Ratio: 5740095557889.88

BBAI:
  Current Price: £1.61
  Traditional Model:
    Expected Return: £171.21
    Probability of Profit: 49.70%
    Sharpe Ratio: 0.29
  SR-LSTM Model:
    Expected Return: £1.90
    Probability of Profit: 100.00%
    Sharpe Ratio: 13537613981053.95

LUNA:
  Current Price: £1.90
  Traditional Model:
    Expected Return: £159.51
    Probability of Profit: 50.86%
    Sharpe Ratio: 0.28
  SR-LSTM Model:
    Expected Return: £2.07
    Probability of Profit: 100.00%
    Sharpe Ratio: 7600706626804.46

ONDS:
  Current Price: £0.90
  Traditional Model:
    Expected Return: £197.23
    Probability of Profit: 48.47%
    Sharpe Ratio: 0.24
  SR-LSTM Model:
    Expected Return: £1.50
    Probability of Profit: 100.00%
    Sharpe Ratio: 5406625658133.03

AVAV:
  Current Price: £215.39
  Traditional Model:
    Expected Return: £172.75
    Probability of Profit: 55.68%
    Sharpe Ratio: 0.38
  SR-LSTM Model:
    Expected Return: £21.47
    Probability of Profit: 100.00%
    Sharpe Ratio: 4900106789182.78

Dynamic Portfolio Value after 3 years: £25020.68

Comparison of Total Expected Returns:
Traditional Model: £9203.80
SR-LSTM Model: £425.69
Difference (SR-LSTM - Traditional): £-8778.11

Average Sharpe Ratios:
Traditional Model: 0.35
SR-LSTM Model: 16848930442665.95

Best Performing Stocks (Based on Sharpe Ratio):
Traditional Model: MSFT (Sharpe Ratio: 0.61)
SR-LSTM Model: CRM (Sharpe Ratio: 99649172097143.70)
