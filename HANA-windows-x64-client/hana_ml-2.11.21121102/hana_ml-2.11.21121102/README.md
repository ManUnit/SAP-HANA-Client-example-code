Introduction
------------

<img src="https://raw.githubusercontent.com/SAP-samples/hana-ml-samples/main/Python-API/portal/SAP_R_grad.jpg" align="left" alt="" width="120" />


Welcome to Python machine learning client for SAP HANA (hana-ml)!

This package enables Python data scientists to access SAP HANA data and build various machine learning models using the data directly in SAP HANA. This page provides an overview of hana-ml.

Overview
--------
Python machine learning client for SAP HANA consists of two main parts:

  - SAP HANA DataFrame, which provides a set of methods for accessing and querying data in SAP HANA without bringing the data to the client.
  - A set of machine learning APIs for developing machine learning models.

Specifically, machine learning APIs are composed of two packages:

  - **PAL** package

    PAL package consists of a set of Python algorithms and functions which provide access to machine learning capabilities in SAP HANA Predictive Analysis Library (PAL). SAP HANA PAL functions cover a variety of machine learning algorithms for training a model and then the trained model is used for scoring.

  - **APL** package

    Automated Predictive Library (APL) package exposes the data mining capabilities of the Automated Analytics engine in SAP HANA through a set of
    functions. These functions develop a predictive modeling process that analysts can use to answer simple questions on their customer datasets stored in SAP HANA.

In addition to SAP HANA DataFrame methods and machine learning API, hana-ml also offers the following features:
- Visualizers: a bunch of methods to visualize dataset and model, e.g. eda (plot functions, e.g. Distribution plot, Pie plot and Correlation plot), dataset_report (analyze the dataset and generate a report in HTML format), model_debriefing (visualize a tree model and explain the output of  model with Shapley value ), unified_report (integrated dataset report and model report for UnifiedClassfication() and UnifiedRegression()).
- Model storage: offers a series of methods to save, list, load and delete models in SAP HANA. Models are saved into SAP HANA tables in a schema specified by the user.
- Text Mining: provides a series of functions, such as perform tf_analysis, text classification on the given document.
- Spatial and Graph: introduces additional engines that can be used for analytics focused on Geospatial and Graph or network modeled data.

Please see [Python Machine Learning Client for SAP HANA Documentation](https://help.sap.com/doc/1d0ebfe5e8dd44d09606814d83308d4b/2.0.05/en-US/html/index.html) for more details of methods.

Prerequisites
-------------

hana-ml uses SAP HANA Python driver (hdbcli) to connect to SAP HANA. Please install and see the following information:

  - SAP HANA Python driver: hdbcli 2.2.23 (shipped with SAP HANA SP03) or higher. Please see [SAP HANA  Client Interface Programming Reference for SAP HANA Service](https://help.sap.com/viewer/1efad1691c1f496b8b580064a6536c2d/latest/en-US/f3b8fabf34324302b123297cdbe710f0.html)

hana-ml uses SAP HANA PAL and SAP HANA APL for machine learning API. Please refer to the following information:

  - SAP HANA PAL: Security **AFL__SYS_AFL_AFLPAL_EXECUTE** and **AFL__SYS_AFL_AFLPAL_EXECUTE_WITH_GRANT_OPTION** roles. See [SAP HANA Predictive Analysis Library](https://help.sap.com/viewer/2cfbc5cf2bc14f028cfbe2a2bba60a50/latest/en-US/253f2b552f55436ba1243ff0d7b374b3.html) for more information.

  - SAP HANA APL 1905 or higher. Please see [SAP HANA Automated Predictive Library Reference Guide](https://help.sap.com/viewer/cb31bd99d09747089754a0ba75067ed2/latest/en-US) for more information. Only valid when using the APL package.

Getting Started
---------------

Install via

    >>> pip install hana-ml

Quick Start
-----------

First, create a connection to SAP HANA:

    >>> from hana_ml import dataframe
    >>> conn = dataframe.ConnectionContext(address="<hostname>",
                                           port=3<NN>MM,
                                           user="<username>",
                                           password="<password>")

NN and MM in Port is explained as follows:
 - For HANA tenant databases, use the port number 3**NN**13 (where **NN** is the SAP instance number - e.g. 30013).
 - For HANA system databases in a multitenant system, the port number is 3**NN**13.
 - For HANA single-tenant databases, the port number is 3**NN**15.

Return a DataFrame referenced to a SAP HANA table:

    >>> df = conn.table('MY_TABLE', schema='MY_SCHEMA').filter('COL3>5').select('COL1', 'COL2')

Return a DataFrame from select statement:

    >>> df = dataframe.DataFrame(conn, 'select * from MY_SCHEMA.MY_TABLE')

Convert a SAP HANA DataFrame to be a pandas DataFrame:

    >>> pandas_df = df.collect()

Convert to a pandas DataFrame to be a SAP HANA DataFrame:

    >>> df = dataframe.create_dataframe_from_pandas(conn, pandas_df, 'MY_TABLE', force=True)



Example: Build an `UnifiedClassification` model and display the dataset and model with UnifiedReport function.

Step 1: Import related modules:

    >>> from hana_ml import dataframe
    >>> from hana_ml.algorithms.pal.unified_classification import UnifiedClassification
    >>> from hana_ml.visualizers.unified_report import UnifiedReport

Step 2: Create a ConnectionContext object:

    >>> conn = dataframe.ConnectionContext('<address>', <port>, '<user>', '<password>')

Step 3: Create a SAP HANA DataFrame df_fit and point to a table "DATA_TBL_FIT":

    >>> df_fit = conn.table("DATA_TBL_FIT")

Step 4: Inspect df_fit:

    >>> df_fit.head(6).collect()
      ID   OUTLOOK  TEMP  HUMIDITY WINDY        CLASS
    0  1     Sunny    75      70.0   Yes         Play
    1  2     Sunny    80      90.0   Yes  Do not Play
    2  3     Sunny    85      85.0    No  Do not Play
    3  4     Sunny    72      95.0    No  Do not Play
    4  5     Sunny    69      70.0    No         Play
    5  6  Overcast    72      90.0   Yes         Play

Step 5: Invoke UnifiedReport function to display the dataset:

    >>> UnifiedReport(df_fit).build().display()

<img src="https://raw.githubusercontent.com/SAP-samples/hana-ml-samples/main/Python-API/portal/datasetreport.PNG" align="left" alt="" width="2000" />

Step 6: Create an 'UnifiedClassification' instance and specify the parameters:

    >>> rdt_params = dict(random_state=2,
                          split_threshold=1e-7,
                          min_samples_leaf=1,
                          n_estimators=10,
                          max_depth=55)
    >>> uc_rdt = UnifiedClassification(func = 'RandomDecisionTree', **rdt_params)

Step 7: Invoke the fit method and inspect one of returned attributes importance_:

      >>> uc_rdt.fit(data=df_fit, 
                     partition_method='stratified',
                     stratified_column='CLASS', 
                     partition_random_state=2,
                     training_percent=0.7, 
                     ntiles=2)
      >>> print(uc_rdt.importance_.collect())
        VARIABLE_NAME  IMPORTANCE
      0       OUTLOOK    0.191748
      1          TEMP    0.418285
      2      HUMIDITY    0.389968
      3         WINDY    0.000000

Step 8: View the 'UnifiedClassification' model report:

    >>> UnifiedReport(uc_rdt).build().display()

<img src="https://raw.githubusercontent.com/SAP-samples/hana-ml-samples/main/Python-API/portal/modelreport.PNG" align="left" alt="" width="2000" />

Step 9: Create a SAP HANA DataFrame df_predict and point to a table "DATA_TBL_PREDICT":

    >>> df_predict = conn.table("DATA_TBL_PREDICT")

Step 10: Preview df_predict:

    >>> df_predict.collect()
       ID   OUTLOOK     TEMP  HUMIDITY WINDY
    0   0  Overcast     75.0      70.0   Yes
    1   1      Rain     78.0      70.0   Yes
    2   2     Sunny     66.0      70.0   Yes
    3   3     Sunny     69.0      70.0   Yes
    4   4      Rain      NaN      70.0   Yes
    5   5      None     70.0      70.0   Yes
    6   6       ***     70.0      70.0   Yes

Step 11: Invoke the predict method and inspect the result:

    >>> result = uc_rdt.predict(df_predict, key = "ID", top_k_attributions=10)
    >>> print(result.collect())
       ID       SCORE  CONFIDENCE
    0   0        Play         0.8
    1   1        Play         1.0
    2   2        Play         0.6
    3   3        Play         1.0
    4   4        Play         1.0
    5   5 Do not Play         0.8
    6   6        Play         0.8

Step 12: Create a TreeModelDebriefing.shapley_explainer object and then invoke summary_plot() to explain the output of 'UnifiedClassification' model :

    >>> from hana_ml.visualizers.model_debriefing import TreeModelDebriefing
    >>> shapley_explainer = TreeModelDebriefing.shapley_explainer(res, df_score, key='ID', label='CLASS')
    >>> shapley_explainer.summary_plot()

<img src="https://raw.githubusercontent.com/SAP-samples/hana-ml-samples/main/Python-API/portal/shap.png" align="left" alt="" width="2000" />

Step 13: Create a SAP HANA DataFrame df_score and point to a "DATA_TBL_SCORE" Table:

    >>> df_score = conn.table("DATA_TBL_SCORE")

Step 14: Preview df_score:

    >>> df_score.collect()
       ID   OUTLOOK     TEMP  HUMIDITY WINDY        CLASS
    0   0  Overcast     75.0  -10000.0   Yes         Play
    1   1      Rain     78.0      70.0   Yes         Play
    2   2     Sunny -10000.0       NaN   Yes  Do not Play
    3   3     Sunny     69.0      70.0   Yes  Do not Play
    4   4      Rain      NaN      70.0   Yes         Play
    5   5      None     70.0      70.0   Yes  Do not Play
    6   6       ***     70.0      70.0   Yes         Play

Step 15: Perform the score method and inspect the result:

    >>> score_res = uc_rdt.score(data=df_score,
                                 key='ID',
                                 max_result_num=2,
                                 ntiles=2,
                                 attribution_method='tree-shap')[1].head(4)
    >>> print(score_res.collect())
       STAT_NAME          STAT_VALUE   CLASS_NAME
    0        AUC  0.5102040816326531         None
    1     RECALL                   0  Do not Play
    2  PRECISION                   0  Do not Play
    3   F1_SCORE                   0  Do not Play

Step 16: Close the connection to the SAP HANA:

    >>> conn.close()

Help
----

Please see [Python Machine Learning Client for SAP HANA Documentation](https://help.sap.com/doc/1d0ebfe5e8dd44d09606814d83308d4b/2.0.05/en-US/html/index.html) for more details of methods.

License
-------

The SAP HANA ML API is provided via the [SAP Developer License Agreement](https://tools.hana.ondemand.com/developer-license-3_1.txt).

By using this software, you agree that the following text is incorporated into the terms of the Developer Agreement:

If you are an existing SAP customer for On Premise software, your use of this current software is also covered by the
terms of your software license agreement with SAP, including the Use Rights, the current version of which can be found at:
https://www.sap.com/about/agreements/product-use-and-support-terms.html?tag=agreements:product-use-support-terms/on-premise-software/software-use-rights



