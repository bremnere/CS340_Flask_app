from flask import Flask, render_template
import os
import database.db_connector as db

db_connection = db.connect_to_database()

# Configuration

app = Flask(__name__)

# Routes 

@app.route('/')
def root():
    return render_template("main.j2")

@app.route('/Species')
def Species():
    return "This is the Species route."

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 4242)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True)