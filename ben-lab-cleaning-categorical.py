#!/usr/bin/env python
# coding: utf-8

# # Lab | Cleaning categorical data

# ### For this lab, we will be using the dataset in the Customer Analysis Business Case. This dataset can be found in files_for_lab folder. In this lab we will explore categorical data. You can also continue working on the same jupyter notebook from the previous lab. However that is not necessary.

# # 1. Import the necessary libraries if you are starting a new notebook.

# In[74]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import scipy
import sklearn
import statsmodels.api as sm


# # 2.Load the csv. Use the variable customer_df as customer_df = pd.read_csv().
# 

# In[75]:


customer_df = pd.read_csv('2_we_fn_use_c_marketing_customer_value_analysis.csv')
customer_df.head(1)


# In[76]:


customer_df.shape


# In[77]:


customer_df.columns = customer_df.columns.str.lower()                              # Convert column names to lowercase
customer_df.columns = customer_df.columns.str.replace(' ', '_')                    # Replace spaces with underscores


# In[78]:


customer_df.head(1)


# In[79]:


customer_df.describe()


# # 3.What should we do with the customer_id column?

# In[80]:


customer_df.columns


# In[81]:


# Drop custome_id
customer_df = customer_df.drop('customer', axis=1)
customer_df.head(1)


# # 4.Load the continuous and discrete variables into numericals_df and categorical_df variables, for eg.

# In[82]:


numerical_df = customer_df.select_dtypes(include='number')
categorical_df = customer_df.select_dtypes('object')


# In[83]:


numerical_df.head(1)


# In[85]:


categorical_df


# ## 5. Plot every categorical variable. What can you see in the plots? Note that in the previous lab you used a bar plot to plot categorical data, with each unique category in the column on the x-axis and an appropriate measure on the y-axis. However, this time you will try a different plot. This time in each plot for the categorical variable you will have, each unique category in the column on the x-axis and the target(which is numerical) on the Y-axis

# In[89]:


for col in categorical_df.columns:
  sns.barplot(x=categorical_df[col], y=data["total_claim_amount"])
  plt.xticks(rotation=90)
  plt.show()


# insight: 
#     
# **Coverage**
# The majority of people have a premium coverage
# 
# **Education**
# The majority of people have a high level education (Bachelor, College, Master or Doctor)
# 
# **Employment status**
# The majority of people are not working due to several reasons.
# 
# **Location_code**
# The majority of people are living in Suburban areas.
# 
# Etc..

# # 6. For the categorical data, check if there is any data cleaning that need to perform. Hint: You can use the function value_counts() on each of the categorical columns and check the representation of different categories in each column. Discuss if this information might in some way be used for data cleaning.

# In[90]:


for col in categorical_df:
    print(customer_df[col].value_counts())
    print()


# In[91]:


# Converting time colume to a datatime format
customer_df['effective_to_date'] = pd.to_datetime(customer_df['effective_to_date'])
customer_df['effective_to_date']


# In[ ]:





# # Lab | Feature extraction

# ### For this lab, we will be using the same dataset we used in the previous labs. We recommend using the same notebook since you will be reusing the same variables you previous created and used in labs.
# ### Instructions:

# ## 1. Open the categoricals variable we created before.

# In[94]:


categoricals = data.select_dtypes(object)
categoricals.head(1)


# ## 2. Plot all the categorical variables with the proper plot. What can you see?

# In[95]:


for col in categorical_df.columns:
  sns.barplot(x=categorical_df[col], y=data["total_claim_amount"])
  plt.xticks(rotation=90)
  plt.show()


# insight: 
#     
# **Coverage**
# The majority of people have a premium coverage
# 
# **Education**
# The majority of people have a high level education (Bachelor, College, Master or Doctor)
# 
# **Employment status**
# The majority of people are not working due to several reasons.
# 
# **Location_code**
# The majority of people are living in Suburban areas.
# 
# Etc..

# ## 3.There might be some columns that seem to be redundant, check their values to be sure. What should we do with them?

# In[96]:


# We should drop them
customer_df = customer_df.drop(['response','policy_type','policy','sales_channel'],axis=1)
customer_df.head()


# ## 4.Plot time variable. Can you extract something from it?

# In[ ]:




