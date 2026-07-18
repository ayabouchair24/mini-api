from flask import Flask, jsonify
import platform

app = Flask(__name__)

@app.route("/health")
def health():
    return jsonify(status="updated", hostname=platform.node())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)