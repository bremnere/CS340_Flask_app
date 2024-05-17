from flask import Flask, render_template, json
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
    query = "SELECT * FROM Species;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("garden.j2", Species=results)

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 4242)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True)