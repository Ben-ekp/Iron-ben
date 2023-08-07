#!/usr/bin/env python
# coding: utf-8

# In[3]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
from sklearn.preprocessing import Normalizer
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_squared_error
import pickle as pkl

import warnings
warnings.filterwarnings('ignore') 


# In[5]:


data = pd.read_csv('marketing_customer_analysis.csv')
data.head(1)


# In[7]:


#X-y split.
y = data['Total Claim Amount']
X = data.drop(['Total Claim Amount'], axis=1)


# In[8]:


X_num = X.select_dtypes(include = np.number)
X_cat = X.select_dtypes(include = np.object)
cat_data = pd.get_dummies(X, drop_first=True)
cat_data


# In[9]:


#One Hot/Label Encoding (categorical).
encoder = OneHotEncoder(handle_unknown='error', drop='first')
encoder.fit(X_cat)


# In[10]:


# after the .fit()
{'Male': [1,0],
'Female': [0,0],
'U': [0,1]}


# In[11]:


encoded = encoder.transform(X_cat).toarray()
encoded #.shape # 


# In[12]:


encoder.categories_


# In[13]:


#Concat DataFrames
X = np.concatenate([X_num, encoded], axis=1)
X.shape


# In[ ]:


#looking for relationships
data.groupby('Gender', as_index=False).agg({'Total Claim Amount': 'mean'})


# In[ ]:


### Linear Regression
    # Train-test split.
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)


# In[ ]:


# Apply linear regression.
model = LinearRegression()
model.fit(X_train,y_train)


# In[ ]:


### Model Validation
predictions  = model.predict(X_test)
predictions.shape


# In[ ]:


# Description:
  # R2.
  # MSE.
  # RMSE.
  # MAE.
r2_score(y_test, predictions), mean_squared_error(y_test, predictions, squared=False), mean_squared_error(y_test, predictions)

