import json
import os


def filter_file(filename):
    output_filename = filename + ".html"
    with open(output_filename, "w") as output:

        try:
            with open(filename, "r") as f:
                data = json.load(f)

            if 'runs' in data and isinstance(data['runs'], list):
                for run in data['runs']:
                    if 'results' in run and isinstance(run['results'], list):
                        for result in run['results']:
                            rule_id = result['ruleId']
                            message = result['message']['text']
                            location = result['locations'][0]['physicalLocation']['artifactLocation']['uri']
                            startline = result['locations'][0]['physicalLocation']['region']['startLine']
                            endcolumn = result['locations'][0]['physicalLocation']['region']['endColumn']

                        #    output.writelines(f"<h3>RuleID: {rule_id}</h3>\n")
                        #    output.writelines(f"<h3>Message: {message}</h3>\n")
                        #    output.writelines(f"<h3>Location: {location}</h3>\n")
                        #    output.writelines(f"<h3>StartLine: {startline}</h3>\n")
                        #    output.writelines(f"<h3>EndColumn: {endcolumn}</h3>\n")



        except FileNotFoundError:
            print(f"Error: File '{filename}' not found.")
        except json.JSONDecodeError:
            print(f"Error: Invalid JSON in '{filename}'.")
        except Exception as e:
            print(f"An unexpected error occurred: {e}")

if __name__ == '__main__':

    filename = os.environ.get("INPUT_FILENAME")
    print(f"Error: File '{filename}' passed as arguments.")
    filter_file(filename)