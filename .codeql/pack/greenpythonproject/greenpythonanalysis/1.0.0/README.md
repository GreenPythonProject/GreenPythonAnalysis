# greenpython #

## GreenPython is a static analysis tool that scans Python Scripts for energy inefficient code ##
## This project is currently a proof of concept as part of a university honours project.  ##
## The following plans for this repo are to ##
1.  Test the energy consumption of more Python libraries, data strucures, algorithms, and fucntion implementation using a Raspberry PI5 and PowerJoular software.
2.  Establish which of these are the most energy efficient.
3.  Increase the capacity of the static analysis tool to detect more energy inefficient code
4.  Produce these results in GitHub docs

I am to undertake this work during the summer of 2025

**Instructions on how to use static analysis tool**

1.  Create a workflow folder called .github/workflows in the root of your project.
2.  Create a file in the workflows folder called codeql-config.yml.
3.  Copy the below to the .yml file


```

name: "CodeQL"

on:
  push:
    branches: [master]
  pull_request:
    branches: [master]

permissions:
  contents: read
  security-events: write



jobs:
  analyze:
    name: Analyze
    runs-on: ubuntu-latest
    strategy:
      matrix:
        language: [python]

    steps:

    - name: Start eco ci energy measurement
      uses: green-coding-solutions/eco-ci-energy-estimation@v4
      with:
        task: start-measurement

    
    - name: Checkout repository
      uses: actions/checkout@v3

    - name: Setup Initialise CodeQL measurement
      uses: green-coding-solutions/eco-ci-energy-estimation@v4
      with:
        task: get-measurement
        label: 'initialize codeql'  

    - name: Initialize CodeQL
      uses: github/codeql-action/init@v3
      with:
        languages: python
        packs: timh1975/greenpython@1.0.9
    
    - name: Performance CodeQL Analysis measurement
      uses: green-coding-solutions/eco-ci-energy-estimation@v4
      with:
          task: get-measurement
          label: 'Perform CodeQL Analysis'  

    - name: Perform CodeQL Analysis
      uses: github/codeql-action/analyze@v3
      with:
          output: results.sarif 
          category: python/example

    - name: Setup Upload Sarif as artifact measurement
      uses: green-coding-solutions/eco-ci-energy-estimation@v4
      with:
        task: get-measurement
        label: 'Upload SARIF measurement'       
         
    - name: Upload SARIF file as artifact (for download)
      uses: actions/upload-artifact@v4
      with:
        name: codeql-sarif-results
        path: results.sarif  

    - name: Install sarif-filter measurement
      uses: green-coding-solutions/eco-ci-energy-estimation@v4
      with:
        task: get-measurement
        label: 'install sarif-filter measurement'      
 
    - name: Install sarif-filter
      run: pip install -i https://test.pypi.org/simple/ sarif-filter

    - name: Filter Sarif file Measurement
      uses: green-coding-solutions/eco-ci-energy-estimation@v4
      with:
        task: get-measurement
        label: 'filter sarif file measurement'

    - name: Filter SARIF file
      run: sarif_filter results.sarif/python.sarif green-python

    - name: Setup Upload Sarif as artifact measurement
      uses: green-coding-solutions/eco-ci-energy-estimation@v4
      with:
        task: get-measurement
        label: 'Upload SARIF measurement'      

    - name: Upload filtered SARIF file as artifact (for download)
      uses: actions/upload-artifact@v4
      with:
        name: filtered-sarif-file
        path: results.sarif

    - name: Show Energy Results
      uses: green-coding-solutions/eco-ci-energy-estimation@v4
      with:
        task: display-results

    - name: Print total data
      run: |
          echo "total json: ${{ steps.total-measurement-step.outputs.data-total-json }}"    

```    
        

5. In the root folder, create an action.yml file and place the following code

```
name: "Green Python"
description: "Demo for Green Python"

runs:
  using: node22
  main: src/*.*

queries:
  disable-default-queries: true
```

Create a folder called scr to store your Python Scripts.  If you are using a different folder, change the src/ in the code in actions.yml as below

```
main: src/*.*   
```        
        

6. output from scan are found in the Upload filtered SARIF file as artfifact (for download). The link to the .csv file output is in line 34

![image](https://github.com/user-attachments/assets/881aa1e2-a9fb-457c-a671-19c515b2e2aa)


7. Information from the output

   ![image](https://github.com/user-attachments/assets/713c1daa-4127-4392-9618-460bfb389668)

Column A - Rule:  Keep this as green-python. This allows the output to identify that it relates to the Green Python static analysis tool.  
Column B - Description: This will be the description of what piece of code was considered energy inefficient and provide recommendations.  
Column C-  directory and file in which the code block as found
Column D/E - Line Number and column end number of line of code

8.  At the moment, the static analysis tool only looks for list.insert and list.append commands in the Scripts
```
import random
a = []
for x in range(1, 1000000):
        random_number = random.randint(0,255)
        a.insert(x, random_number)


b = []
for x in range(1, 1000000):
        random_number = random.randint(0,255)
        a.append(x, random_number)

```
