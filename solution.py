import pandas as pd

class Chitfund:
    def __init__(self, fileName):
        self.df = pd.read_excel(fileName, header=1)
        self.total = self.df['Amount returned to everyone in the group'].sum()

    def annualizedReturn(self):
        self.df['Annualized Return'] = (self.df['Net amount recd by Bid winner'] + self.total) * (12 / 25)

    def annualizedReturnPercentage(self):
        self.df['Annualized Return (%)'] = (self.df['Net amount recd by Bid winner'] + self.total) * (100 / 50000)


data = Chitfund('ExerciseData.xlsx')

data.annualizedReturn()
data.annualizedReturnPercentage()

print('Annualized Return of the person who bids in the last month is ' + str(data.df['Annualized Return'].iloc[-1]))
print('Annualized Return of the person who bids in the first month is ' + str(data.df['Annualized Return'].iloc[0]))
print("Return % for each month's bid winner is")
print(data.df['Annualized Return (%)'])

data.df.to_excel('output.xlsx')
