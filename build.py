import pandas as pd
import numpy as np

spine = pd.read_csv('./raw/england_spine.csv', dtype={'URN': str})

school_information = spine[['URN', 'LA', 'SCHNAME', 'STREET', 'LOCALITY', 'TOWN', 'POSTCODE']]
school_information.to_csv('./out/school_information.csv', index=False)

ks4 = pd.read_csv('./raw/england_ks4revised.csv', dtype={'URN': str})

school_progress = ks4[['URN', 'P8MEA']]
school_progress['Year'] = '2016'
school_progress['P8MEA'] = pd.to_numeric(school_progress['P8MEA'], errors='coerce')
school_progress = school_progress[school_progress['P8MEA'] != np.nan]
school_progress = school_progress.dropna(subset = ['URN', 'P8MEA'])

school_progress['RankASC'] = school_progress['P8MEA'].rank(ascending=0).round(decimals=0).astype(int)
school_progress['RankDESC'] = school_progress['P8MEA'].rank(ascending=1).round(decimals=0).astype(int)
school_progress['PercentileASC'] = school_progress['RankASC'] / len(school_progress)
school_progress['PercentileASC'] = school_progress['PercentileASC'].round(decimals=2)
school_progress['PercentileDESC'] = school_progress['RankDESC'] / len(school_progress)
school_progress['PercentileDESC'] = school_progress['PercentileDESC'].round(decimals=2)

school_progress.to_csv('./out/school_progress.csv', index=False)