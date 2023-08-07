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

# # Lab | Data cleaning and wrangling

# ## For this lab, we will be using the same dataset we used in the previous labs. We recommend using the same notebook since you will be reusing the same variables you previous created and used in labs.
# 
# 

# ## Instructions
# ## So far we have worked on EDA. This lab will focus on data cleaning and wrangling from everything we noticed before.

# ### 1. We will start with removing outliers. So far, we have discussed different methods to remove outliers. Use the one you feel more comfortable with, define a function for that. Use the function to remove the outliers and apply it to the dataframe.
# 

# In[99]:


customer_df_num = customer_df.select_dtypes(np.number)
for col in customer_df_num.columns:
    print(col)
    sns.boxplot(x=customer_df_num[col])
    plt.show()


# In[101]:


import pandas as pd

def remove_outliers(df, columns):
    for col in columns:
        Q1 = df[col].quantile(0.25)
        Q3 = df[col].quantile(0.75)
        IQR = Q3 - Q1
        upper_range = Q3 + 1.5 * IQR
        df = df.loc[df[col] < upper_range]
    df.reset_index(drop=True, inplace=True)
    return df

# Assuming 'customer_df' is your DataFrame and you want to remove outliers from the specified columns
columns_to_remove_outliers = ["customer_lifetime_value", "monthly_premium_auto", "number_of_policies", "total_claim_amount"]
customer_df = remove_outliers(customer_df, columns_to_remove_outliers)
print(customer_df.shape)


# ### 2.Create a copy of the dataframe for the data wrangling.
# 

# In[103]:


df_wrang = customer_df.copy()
df_wrang.head()


# ## 3. Normalize the continuous variables

# In[108]:


from sklearn.preprocessing import StandardScaler
x = df_wrang.drop(['total_claim_amount'], axis=1)
y = df_wrang['total_claim_amount']


# In[109]:


x_num = x.select_dtypes(np.number)

scaler = StandardScaler()
scaler.fit(x_num)

x_num_scaled = scaler.transform(x_num)
x_num_scaled = pd.DataFrame(x_num_scaled, columns = x_num.columns)
x_num_scaled


# ## 4.Encode the categorical variables
# 

# In[110]:


x_cat = x.select_dtypes('object')
x_cat.columns


# In[111]:


x_cat_ordinal = x_cat[["coverage","employmentstatus","location_code","vehicle_size"]].copy()

x_cat_ordinal["coverage"] = x_cat_ordinal["coverage"].map({"Basic" : 0, "Extended" : 1, "Premium" : 2})
x_cat_ordinal["employmentstatus"] = x_cat_ordinal["employmentstatus"].map({"Employed" : 0, "Unemployed" : 1, "Medical Leave" : 2, "Disabled" : 3, "Retired" : 4})
x_cat_ordinal["location_code"] = x_cat_ordinal["location_code"].map({"Suburban" : 0, "Urban" : 1, "Rural" : 2})
x_cat_ordinal["vehicle_size"] = x_cat_ordinal["vehicle_size"].map({"Medsize" : 0, "Small" : 1, "Large" : 2})


# In[114]:


from sklearn.preprocessing import OneHotEncoder

x_cat_onehot = x_cat.drop(["coverage","employmentstatus","location_code","vehicle_size"],axis=1)

encoder = OneHotEncoder(drop='first')
encoder.fit(x_cat_onehot)

cols = []
for i in range(len(encoder.categories_)):
    cols += list(encoder.categories_[i])[1:]

og_cols = len(x_cat_onehot.columns)
x_cat_onehot[cols] = encoder.transform(x_cat_onehot).todense()
x_cat_onehot = x_cat_onehot.drop(x_cat_onehot.columns[:og_cols], axis=1)


# In[115]:


x_concat = pd.concat([x_num_scaled, x_cat_onehot, x_cat_ordinal], axis=1)


# In[116]:


x_concat.columns


# ## 5.The time variable can be useful. Try to transform its data into a useful one. Hint: Day week and month as integers might be useful.

# In[119]:


x_concat['eff_to_day'] = x['effective_to_date'].dt.day
x_concat['eff_to_week'] = x['effective_to_date'].dt.week
x_concat['eff_to_month'] = x['effective_to_date'].dt.month
x_concat['eff_to_day'], x_concat['eff_to_week'], x_concat['eff_to_month']


# ## 6 Since the model will only accept numerical data, check and make sure that every column is numerical, if some are not, change it using encoding.

# In[118]:


x_concat

