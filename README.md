# greenpython

GreenPython is a static analysis tool that scans Python Scripts for energy inefficient code

** Instructions on how to use static analysis tool **

1.  Create a workflow folder called .github/workflows in the root of your project.
2.  Create a file in the workflows folder called codeql-config.yml.
3.  Copy the below to the .yml file


# greenpython

GreenPython is a static analysis tool that scans Python Scripts for energy inefficient code

** Instructions on how to use static analysis tool **

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
        

5. Place your python files to scan in a specific folder.  Edit the following in action.yml if you are not using the default src/ folder

```
main: src/*.*   
```        
        

6. output from scan are found in the Upload filtered SARIF file as artfifact (for download). The link to the .csv file output is in line 34

![image](https://github.com/user-attachments/assets/881aa1e2-a9fb-457c-a671-19c515b2e2aa)

