from flask import Flask
import json, sys

app = Flask(__name__)

version = {
    'Python Version is: ': sys.version,
    'Version Info: ': sys.version_info
}

# Directs to to home page
@app.route('/', methods=["GET"])
def home():
    return json.dumps({'message': 'Please visit /version to check the python version.'})

# Returns the python version 
@app.route('/version', methods=['GET'])
def getVersion():
    return json.dumps(version)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)