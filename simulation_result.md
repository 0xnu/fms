## Simulation Result
File content:
let stocks = [
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
  ({symbol = "HL"; current_price = 7.16; volatility = 0.50; expected_return = 0.15}, 20);
]

Successfully parsed 34 stocks.
Initial Investment: £5000.00
Investment Horizon: 3 years

Overall Portfolio Metrics:
                   Traditional   SR-LSTM
Expected Return:   £9255.37         £430.75
VaR (95%):        £1101.77         £430.75
VaR (99%):        £-379.44         £430.75
Prob. of Profit:   98.34%         100.00%
Sharpe Ratio:      0.94           7487648730505.60

Individual Stock Metrics:
TSLA:
  Current Price: £260.13
  Traditional Model:
    Expected Return: £144.48
    Probability of Profit: 57.54%
    Sharpe Ratio: 0.40
  SR-LSTM Model:
    Expected Return: £25.93
    Probability of Profit: 100.00%
    Sharpe Ratio: 5688041815575.66

GOOGL:
  Current Price: £165.27
  Traditional Model:
    Expected Return: £147.88
    Probability of Profit: 67.25%
    Sharpe Ratio: 0.56
  SR-LSTM Model:
    Expected Return: £32.94
    Probability of Profit: 100.00%
    Sharpe Ratio: 57920962211220.16

NVDA:
  Current Price: £121.35
  Traditional Model:
    Expected Return: £260.51
    Probability of Profit: 67.36%
    Sharpe Ratio: 0.54
  SR-LSTM Model:
    Expected Return: £36.28
    Probability of Profit: 100.00%
    Sharpe Ratio: 12791168921664.86

IBM:
  Current Price: £223.93
  Traditional Model:
    Expected Return: £77.88
    Probability of Profit: 68.39%
    Sharpe Ratio: 0.57
  SR-LSTM Model:
    Expected Return: £22.32
    Probability of Profit: 100.00%
    Sharpe Ratio: 25829272113190.31

MSFT:
  Current Price: £429.93
  Traditional Model:
    Expected Return: £172.32
    Probability of Profit: 71.48%
    Sharpe Ratio: 0.62
  SR-LSTM Model:
    Expected Return: £42.85
    Probability of Profit: 100.00%
    Sharpe Ratio: 8723333355665.99

AMZN:
  Current Price: £188.41
  Traditional Model:
    Expected Return: £205.76
    Probability of Profit: 65.55%
    Sharpe Ratio: 0.52
  SR-LSTM Model:
    Expected Return: £37.56
    Probability of Profit: 100.00%
    Sharpe Ratio: 9729001998600.08

BIDU:
  Current Price: £106.98
  Traditional Model:
    Expected Return: £191.81
    Probability of Profit: 54.77%
    Sharpe Ratio: 0.35
  SR-LSTM Model:
    Expected Return: £31.99
    Probability of Profit: 100.00%
    Sharpe Ratio: 6075417118412.12

IONQ:
  Current Price: £9.72
  Traditional Model:
    Expected Return: £257.94
    Probability of Profit: 51.46%
    Sharpe Ratio: 0.32
  SR-LSTM Model:
    Expected Return: £15.14
    Probability of Profit: 100.00%
    Sharpe Ratio: 39040857415459.50

CRM:
  Current Price: £277.26
  Traditional Model:
    Expected Return: £136.24
    Probability of Profit: 69.41%
    Sharpe Ratio: 0.59
  SR-LSTM Model:
    Expected Return: £27.63
    Probability of Profit: 100.00%
    Sharpe Ratio: 99649172097143.70

AMD:
  Current Price: £167.85
  Traditional Model:
    Expected Return: £231.19
    Probability of Profit: 60.89%
    Sharpe Ratio: 0.45
  SR-LSTM Model:
    Expected Return: £33.46
    Probability of Profit: 100.00%
    Sharpe Ratio: 22844934659129.20

QUBT:
  Current Price: £0.67
  Traditional Model:
    Expected Return: £114.99
    Probability of Profit: 49.89%
    Sharpe Ratio: 0.31
  SR-LSTM Model:
    Expected Return: £0.90
    Probability of Profit: 100.00%
    Sharpe Ratio: 28246880893737.76

RGTI:
  Current Price: £0.75
  Traditional Model:
    Expected Return: £94.36
    Probability of Profit: 51.88%
    Sharpe Ratio: 0.33
  SR-LSTM Model:
    Expected Return: £0.78
    Probability of Profit: 100.00%
    Sharpe Ratio: 10751130421952.17

ARRXF:
  Current Price: £0.18
  Traditional Model:
    Expected Return: £137.84
    Probability of Profit: 45.56%
    Sharpe Ratio: 0.24
  SR-LSTM Model:
    Expected Return: £0.72
    Probability of Profit: 100.00%
    Sharpe Ratio: 4617870917461.39

QBTS:
  Current Price: £0.92
  Traditional Model:
    Expected Return: £116.93
    Probability of Profit: 50.93%
    Sharpe Ratio: 0.28
  SR-LSTM Model:
    Expected Return: £0.98
    Probability of Profit: 100.00%
    Sharpe Ratio: 60299936248792.82

NIO:
  Current Price: £6.70
  Traditional Model:
    Expected Return: £197.83
    Probability of Profit: 56.33%
    Sharpe Ratio: 0.38
  SR-LSTM Model:
    Expected Return: £8.34
    Probability of Profit: 100.00%
    Sharpe Ratio: 12597775074263.33

REKR:
  Current Price: £1.10
  Traditional Model:
    Expected Return: £83.06
    Probability of Profit: 54.58%
    Sharpe Ratio: 0.34
  SR-LSTM Model:
    Expected Return: £0.84
    Probability of Profit: 100.00%
    Sharpe Ratio: 3852108122675.19

LTRX:
  Current Price: £3.92
  Traditional Model:
    Expected Return: £91.09
    Probability of Profit: 57.62%
    Sharpe Ratio: 0.39
  SR-LSTM Model:
    Expected Return: £2.74
    Probability of Profit: 100.00%
    Sharpe Ratio: 13679242233968.17

AEVA:
  Current Price: £3.08
  Traditional Model:
    Expected Return: £793.09
    Probability of Profit: 47.59%
    Sharpe Ratio: 0.25
  SR-LSTM Model:
    Expected Return: £12.57
    Probability of Profit: 100.00%
    Sharpe Ratio: 10119177724433.09

VLDR:
  Current Price: £1.26
  Traditional Model:
    Expected Return: £298.51
    Probability of Profit: 49.40%
    Sharpe Ratio: 0.28
  SR-LSTM Model:
    Expected Return: £2.71
    Probability of Profit: 100.00%
    Sharpe Ratio: 6836991319670.23

ARBE:
  Current Price: £1.88
  Traditional Model:
    Expected Return: £307.96
    Probability of Profit: 51.16%
    Sharpe Ratio: 0.27
  SR-LSTM Model:
    Expected Return: £3.63
    Probability of Profit: 100.00%
    Sharpe Ratio: 5553941547439.85

MVIS:
  Current Price: £1.15
  Traditional Model:
    Expected Return: £132.08
    Probability of Profit: 51.63%
    Sharpe Ratio: 0.29
  SR-LSTM Model:
    Expected Return: £1.29
    Probability of Profit: 100.00%
    Sharpe Ratio: 4748939430490.32

GOEV:
  Current Price: £0.96
  Traditional Model:
    Expected Return: £1103.71
    Probability of Profit: 44.52%
    Sharpe Ratio: 0.22
  SR-LSTM Model:
    Expected Return: £7.69
    Probability of Profit: 100.00%
    Sharpe Ratio: 8694852424329.26

AUR:
  Current Price: £5.19
  Traditional Model:
    Expected Return: £1656.96
    Probability of Profit: 46.93%
    Sharpe Ratio: 0.26
  SR-LSTM Model:
    Expected Return: £37.16
    Probability of Profit: 100.00%
    Sharpe Ratio: 4334120185663.58

FRSX:
  Current Price: £0.70
  Traditional Model:
    Expected Return: £809.51
    Probability of Profit: 45.61%
    Sharpe Ratio: 0.22
  SR-LSTM Model:
    Expected Return: £5.05
    Probability of Profit: 100.00%
    Sharpe Ratio: 8975127001711.24

SLI:
  Current Price: £1.63
  Traditional Model:
    Expected Return: £177.00
    Probability of Profit: 50.32%
    Sharpe Ratio: 0.31
  SR-LSTM Model:
    Expected Return: £1.94
    Probability of Profit: 100.00%
    Sharpe Ratio: 13631289150429.43

NRVTF:
  Current Price: £0.09
  Traditional Model:
    Expected Return: £127.47
    Probability of Profit: 46.34%
    Sharpe Ratio: 0.24
  SR-LSTM Model:
    Expected Return: £0.62
    Probability of Profit: 100.00%
    Sharpe Ratio: 17653514782188.89

WWR:
  Current Price: £0.51
  Traditional Model:
    Expected Return: £115.22
    Probability of Profit: 48.17%
    Sharpe Ratio: 0.28
  SR-LSTM Model:
    Expected Return: £0.80
    Probability of Profit: 100.00%
    Sharpe Ratio: 6748258525663.40

AMLI:
  Current Price: £0.55
  Traditional Model:
    Expected Return: £114.03
    Probability of Profit: 49.70%
    Sharpe Ratio: 0.28
  SR-LSTM Model:
    Expected Return: £0.77
    Probability of Profit: 100.00%
    Sharpe Ratio: 9196238283980.60

CVU:
  Current Price: £3.33
  Traditional Model:
    Expected Return: £158.55
    Probability of Profit: 51.85%
    Sharpe Ratio: 0.31
  SR-LSTM Model:
    Expected Return: £3.13
    Probability of Profit: 100.00%
    Sharpe Ratio: 5740095557889.88

BBAI:
  Current Price: £1.61
  Traditional Model:
    Expected Return: £172.09
    Probability of Profit: 49.95%
    Sharpe Ratio: 0.29
  SR-LSTM Model:
    Expected Return: £1.90
    Probability of Profit: 100.00%
    Sharpe Ratio: 13537613981053.95

LUNA:
  Current Price: £1.90
  Traditional Model:
    Expected Return: £167.06
    Probability of Profit: 49.27%
    Sharpe Ratio: 0.28
  SR-LSTM Model:
    Expected Return: £2.07
    Probability of Profit: 100.00%
    Sharpe Ratio: 7600706626804.46

ONDS:
  Current Price: £0.90
  Traditional Model:
    Expected Return: £192.40
    Probability of Profit: 47.67%
    Sharpe Ratio: 0.25
  SR-LSTM Model:
    Expected Return: £1.50
    Probability of Profit: 100.00%
    Sharpe Ratio: 5406625658133.03

AVAV:
  Current Price: £215.39
  Traditional Model:
    Expected Return: £183.65
    Probability of Profit: 56.65%
    Sharpe Ratio: 0.36
  SR-LSTM Model:
    Expected Return: £21.47
    Probability of Profit: 100.00%
    Sharpe Ratio: 4900106789182.78

HL:
  Current Price: £7.16
  Traditional Model:
    Expected Return: £83.98
    Probability of Profit: 54.11%
    Sharpe Ratio: 0.34
  SR-LSTM Model:
    Expected Return: £5.06
    Probability of Profit: 100.00%
    Sharpe Ratio: 7278934772015.65

Dynamic Portfolio Value after 3 years: £37064.79

Comparison of Total Expected Returns:
Traditional Model: £9255.37
SR-LSTM Model: £430.75
Difference (SR-LSTM - Traditional): £-8824.62

Average Sharpe Ratios:
Traditional Model: 0.35
SR-LSTM Model: 16567459981764.47

Best Performing Stocks (Based on Sharpe Ratio):
Traditional Model: MSFT (Sharpe Ratio: 0.62)
SR-LSTM Model: CRM (Sharpe Ratio: 99649172097143.70)
