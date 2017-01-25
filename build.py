import pandas as pd

spine = pd.read_csv('./raw/england_spine.csv', dtype={'URN': str})

school_information = spine[['URN', 'SCHNAME']]
school_information.to_csv('./out/school_information.csv', index=False)

ks4 = pd.read_csv('./raw/england_ks4revised.csv', dtype={'URN': str})

school_progress = ks4[['URN', 'P8MEA']]
school_progress['Year'] = '2016'
school_progress = school_progress.dropna(subset = ['URN'])
school_progress.to_csv('./out/school_progress.csv', index=False)