# Citation # 1: for the following code (basic set-up of app.py with import statements/login credentials/set-up):
# Date: 05/19/2024
# Code was adapted from Flask Starter Code: OSU bsg-ppl example (Step 1- Step 6):
# Source URL: https://github.com/osu-cs340-ecampus/flask-starter-app/tree/master

# Citation # 2: for the following code (CRUD SET-UP - STEP 7):
# Date: 05/19/2024
# Code was adapted from Flask Starter Code: OSU bsg-ppl example (bsg app.py) (CRUD - Step 7):
# Source URL: https://github.com/osu-cs340-ecampus/flask-starter-app/tree/master

# Citation # 3: for the following code (SQL JOINS):
# Date: 05/19/2024
# Code was adapted from Canvas OSU Explorations - SQL JOINS: for sql query help:
# Source URL: https://canvas.oregonstate.edu/courses/1958399/pages/exploration-sql-joins?module_item_id=24181825

# Citation # 4: for the following code (SQL CONCAT):
# Date: 05/20/2024
# Code was adapted from Canvas OSU Explorations - SQL CONCAT: for sql query help:
# Source URL: https://www.w3schools.com/sql/func_sqlserver_concat.asp
# -------- Citation # 1 --------------#
import sys
from flask import Flask, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os
import database.db_connector as db

db_connection = db.connect_to_database()

# -------- Citation # 1 --------------#

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_bremnere'
app.config['MYSQL_PASSWORD'] = '2295' #last 4 of onid
app.config['MYSQL_DB'] = 'cs340_bremnere'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"

mysql = MySQL(app)

# -------- Citation # 1 --------------#
# Routes 

@app.route('/home')
def root():
    return render_template("main.j2")

# -------- Citation # 2 --------------#
# -------- INSERT FOR PLANTS GET/POST --------------#

@app.route('/plants', methods=["POST", "GET"])
def plants():
    print((("insert species by Kavya, request: %s") % (request.method)), file=sys.stdout)
    if request.method == "POST":
        # check if the user presses add plants
        if request.form.get("add_plant"):
            plant_name = request.form["plantname"]
            date_planted = request.form["dateplanted"]
            drought_resistant = request.form["addroughtresistant"]
            garden_bed_id = request.form["addplantgardenbed"]
            species_id = request.form["addplantspecies"]

            # Assume that both of these are null
            if garden_bed_id == "0" and species_id == "0":
                query = "INSERT INTO Plants (plant_name, date_planted, drought_resistant) VALUES (%s, %s,%s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (plant_name, date_planted, drought_resistant))
                mysql.connection.commit()

            # else add everything   
            else:
                query = "INSERT INTO Plants (plant_name, date_planted, drought_resistant, garden_bed_id, species_id) VALUES (%s, %s,%s,%s,%s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (plant_name, date_planted, drought_resistant, garden_bed_id, species_id))
                mysql.connection.commit()
                    

            # redirect back to plants page
            return redirect("/plants")
            
# -------- Citation # 2 --------------#
# -------- GET METHOD FOR PLANTS--------------#

    # GET all of the plants
    if request.method == "GET":
# -------- Citation # 3 --------------#
        query = """
        SELECT 
            Plants.plant_id, 
            Plants.plant_name, 
            Plants.date_planted, 
            Plants.drought_resistant, 
            GardenBeds.garden_bed_name, 
            Species.species_name 
        FROM 
            Plants 
        LEFT JOIN 
            GardenBeds ON Plants.garden_bed_id = GardenBeds.garden_bed_id 
        LEFT JOIN 
            Species ON Plants.species_id = Species.species_id
        """
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        # SQL query to grab species name for the dropdown
        query2 = "SELECT species_id, species_name FROM Species;"
        cur = mysql.connection.cursor()
        cur.execute(query2)
        species_data = cur.fetchall()
    

        # SQL query to grab gardenbed name for the dropdown
        query3 = "SELECT garden_bed_id, garden_bed_name FROM GardenBeds;"
        cur = mysql.connection.cursor()
        cur.execute(query3)
        garden_bed_data = cur.fetchall()

        return render_template("plants.j2", Plants=data, Species = species_data, GardenBeds = garden_bed_data)
    

# -------- Citation # 2 --------------#
# -------- UPDATE FOR PLANTS GET/POST --------------#
    
# -------- Citation # 2 --------------#
# -------- DELETE FOR PLANTS --------------#

@app.route("/delete_plant/<int:plant_id>")
def delete_plant(plant_id):
    # SQL query to delete the plant with selected input
    query = "DELETE FROM Plants WHERE plant_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (plant_id,))
    mysql.connection.commit()

    # redirect back to the plants page
    return redirect("/plants")

# -------- Citation # 2 --------------#
# -------- INSERT FOR SPECIES GET/POST --------------#
    
@app.route('/species', methods=['GET', 'POST'])
def species():   
    if request.method == "POST":
        # check if the user presses add species
        if request.form.get("add_species"):
            # find the species name input
            species_name = request.form["speciesname"]

            # insert input value into table
            query = "INSERT INTO Species (species_name) VALUES (%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (species_name,))
            mysql.connection.commit()
        return redirect("/species")
    
# -------- Citation # 2 --------------#
# -------- GET METHOD FOR SPECIES--------------#

    # Apply the Species row to the table          
    if request.method == "GET":
        query = "SELECT Species.species_id, species_name FROM Species"
        cur = mysql.connection.cursor()
        cur.execute(query)
        species_data = cur.fetchall()
        return render_template("species.j2", Species=species_data) 
    

# -------- Citation # 2 --------------#
# -------- DELETE FOR SPECIES --------------#

@app.route("/delete_species/<int:species_id>")
def delete_species(species_id):
    # SQL query to delete the species with selected input
    query = "DELETE FROM Species WHERE species_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (species_id,))
    mysql.connection.commit()

    # redirect back to the species page
    return redirect("/species")

# -------- Citation # 2 --------------#
# -------- INSERT FOR HARVESTS GET/POST --------------#
    
@app.route('/harvests', methods=['GET', 'POST'])
def harvests():   
    if request.method == "POST":
        # check if the user presses add harvests
        if request.form.get("add_harvests"):
            # find the harvests name input
            plant_id = request.form["pname"]
            harvest_date = request.form["hdate"]
            harvest_quantity = request.form["hquantity"]

            # insert input value into table
            query = "INSERT INTO Harvests (plant_id, harvest_date, harvest_quantity) VALUES (%s,%s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (plant_id, harvest_date, harvest_quantity))
            mysql.connection.commit()
        return redirect("/harvests")
    
# -------- Citation # 2 --------------#
# -------- Citation # 3 --------------# 
# -------- GET METHOD FOR HARVESTS--------------#
  
    if request.method == "GET":     
        query = """
        SELECT 
            Harvests.harvest_id,
            Plants.plant_name, 
            Harvests.harvest_date, 
            Harvests.harvest_quantity
        FROM 
            Harvests 
        LEFT JOIN 
            Plants ON Harvests.plant_id = Plants.plant_id 
        """
        cur = mysql.connection.cursor()
        cur.execute(query)
        harvest_data = cur.fetchall()      

        # SQL query to grab plant name for the dropdown
        query2 = "SELECT plant_id, plant_name FROM Plants;"
        cur = mysql.connection.cursor()
        cur.execute(query2)
        plants_data = cur.fetchall() 

        return render_template("harvests.j2", Harvests=harvest_data, PlantHarvests=plants_data)
    

# -------- Citation # 2 --------------#
# -------- DELETE FOR Harvest --------------#

@app.route("/delete_harvest/<int:harvest_id>")
def delete_harvest(harvest_id):
    # SQL query to delete the harvest with selected input
    query = "DELETE FROM Harvests WHERE harvest_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (harvest_id,))
    mysql.connection.commit()

    # redirect back to the plants page
    return redirect("/harvests")
    
# -------- Citation # 2 --------------#
# -------- INSERT FOR AMENDMENTS GET/POST --------------#

@app.route('/amendments', methods=["POST", "GET"])
def amendments():
    if request.method == "POST":
        # check if the user presses add_amendment
        if request.form.get("add_amendment"):
            amendment_type = request.form["atype"]
            amendment_quantity = request.form["aquantity"]
            date_applied = request.form["adateapplied"]


            query = "INSERT INTO Amendments (amendment_type, amendment_quantity, date_applied) VALUES (%s, %s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (amendment_type, amendment_quantity, date_applied))
            mysql.connection.commit()
                

            # redirect back to amendments page
            return redirect("/amendments")
        
    if request.method == "GET":
        query = "SELECT * FROM Amendments;"
        cur = mysql.connection.cursor()
        cur.execute(query)
        amendment_data = cur.fetchall()
        return render_template("amendments.j2", Amendments=amendment_data)
            
# -------- Citation # 2 --------------#
# -------- GET METHOD FOR AMENDMENTS--------------#
# -------- Citation # 3 --------------#

    # GET all of the amendments
    if request.method == "GET":
        query = "SELECT * FROM Amendments;"
        cur = mysql.connection.cursor()
        cur.execute(query)
        amendment_data = cur.fetchall()
        return render_template("amendments.j2", Amendments=amendment_data)
    

# -------- Citation # 2 --------------#
# -------- DELETE FOR Amendments --------------#

@app.route("/delete_amendment/<int:amendment_id>")
def delete_amendment(amendment_id):
    # SQL query to delete the amendment with selected input
    query = "DELETE FROM Amendments WHERE amendment_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (amendment_id,))
    mysql.connection.commit()

    # redirect back to the amendments page
    return redirect("/amendments")

# -------- Citation # 2 --------------#
# -------- UPDATE FOR Amendments --------------#

@app.route('/update_amendment', methods=['POST', 'GET'])
def update_amendment():
    if request.method == "POST":
        # Check if the user presses update_amendment
        if request.form.get("update_amendment"):
            amendment_id = request.form["updatedamendmentid"]
            amendment_type = request.form["updateatype"]
            amendment_quantity = request.form["updateaquantity"]
            date_applied = request.form["updateadateapplied"]

            # SQL query to update the amendment
            query = """
            UPDATE Amendments 
            SET amendment_type = %s, amendment_quantity = %s, date_applied = %s 
            WHERE amendment_id = %s
            """
            cur = mysql.connection.cursor()
            cur.execute(query, (amendment_type, amendment_quantity, date_applied, amendment_id))
            mysql.connection.commit()

            # Redirect back to the amendments page
            return redirect("/amendments")

    if request.method == "GET":
        # GET the amendment data for pre-filling the form if necessary
        amendment_id = request.args.get('amendment_id')
        if amendment_id:
            query = "SELECT * FROM Amendments WHERE amendment_id = %s"
            cur = mysql.connection.cursor()
            cur.execute(query, (amendment_id,))
            amendment_data = cur.fetchone()
            return render_template("update_amendment.j2", Amendment=amendment_data)
        return redirect("/amendments")


# -------- Citation # 2 --------------#
# -------- INSERT FOR GARDENBEDS GET/POST --------------#

@app.route('/gardenbeds', methods=["POST", "GET"])
def gardenbeds():
    if request.method == "POST":
        # check if the user presses add_garden_bed
        if request.form.get("add_garden_beds"):
            garden_bed_name = request.form["gbname"]
            sun_level = request.form["slevel"]
            square_feet = request.form["sfeet"]
            cardinal_direction = request.form["cdirection"]


            query = "INSERT INTO GardenBeds (garden_bed_name, sun_level, square_feet, cardinal_direction) VALUES (%s, %s,%s, %s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (garden_bed_name, sun_level, square_feet, cardinal_direction))
            mysql.connection.commit()
                

            # redirect back to gardenbeds page
            return redirect("/gardenbeds")
            
# -------- Citation # 2 --------------#
# -------- GET METHOD FOR GARDENBEDS--------------#
# -------- Citation # 3 --------------#

    # GET all of the gardenbeds
    if request.method == "GET":
        query = "SELECT * FROM GardenBeds;"
        cur = mysql.connection.cursor()
        cur.execute(query)
        garden_bed_data = cur.fetchall()
        return render_template("gardenbeds.j2", GardenBeds=garden_bed_data)
    

# -------- Citation # 2 --------------#
# -------- DELETE FOR GardenBeds --------------#

@app.route("/delete_gardenbed/<int:garden_bed_id>")
def delete_gardenbed(garden_bed_id):
    # SQL query to delete the amendment with selected input
    query = "DELETE FROM GardenBeds WHERE garden_bed_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (garden_bed_id,))
    mysql.connection.commit()

    # redirect back to the garenbeds page
    return redirect("/gardenbeds")

# -------- Citation # 2 --------------#
# -------- INSERT FOR GARDENBEDAMENDMENTS GET/POST --------------#

@app.route('/gardenbedamendments', methods=["POST", "GET"])
def gardenbedamendments():
    if request.method == "POST":
        # check if the user presses add_gardenbed_amendment
        if request.form.get("add_gardenbed_amendment"):
            garden_bed_id = request.form["gbid"]
            amendment_id = request.form["amendid"]

            query = "INSERT INTO GardenBedAmendments (garden_bed_id, amendment_id) VALUES (%s, %s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (garden_bed_id, amendment_id))
            mysql.connection.commit()
                

            # redirect back to gardenbedamendments intersection table page
            return redirect("/gardenbedamendments")
            
# -------- Citation # 2 --------------#
# -------- Citation # 3 --------------#
# -------- Citation # 4 --------------#
# -------- GET METHOD FOR GARDENBEDAMENDMENTS--------------#

    # GET all of the gardenbeds
    if request.method == "GET":
        query = """
        SELECT 
            GardenBedAmendments.garden_bed_amendments_id, 
            GardenBeds.garden_bed_name, 
            CONCAT(Amendments.amendment_type, ' - ', Amendments.amendment_quantity) AS amendment_details
             
        FROM 
            GardenBedAmendments
        LEFT JOIN 
            GardenBeds ON GardenBedAmendments.garden_bed_id = GardenBeds.garden_bed_id 
        LEFT JOIN 
            Amendments ON GardenBedAmendments.amendment_id = Amendments.amendment_id
        """
        cur = mysql.connection.cursor()
        cur.execute(query)
        garden_bed_amend_data = cur.fetchall()
        
        # SQL query to grab amendment name for the dropdown
        query2 = "SELECT amendment_id, amendment_type, amendment_quantity FROM Amendments;"
        cur = mysql.connection.cursor()
        cur.execute(query2)
        amendment_data = cur.fetchall()
    

        # SQL query to grab gardenbed name for the dropdown
        query3 = "SELECT garden_bed_id, garden_bed_name FROM GardenBeds;"
        cur = mysql.connection.cursor()
        cur.execute(query3)
        garden_bed_data = cur.fetchall()

        return render_template("gardenbedamendments.j2", GardenBedAmendments=garden_bed_amend_data, Amendments=amendment_data, GardenBeds=garden_bed_data)
    

# -------- Citation # 2 --------------#
# -------- DELETE FOR GardenBeds --------------#

@app.route("/delete_gbamendment/<int:garden_bed_amendments_id>")
def delete_gbamendment(garden_bed_amendments_id):
    # SQL query to delete the gardenbedamendment with selected input
    query = "DELETE FROM GardenBedAmendments WHERE garden_bed_amendments_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (garden_bed_amendments_id,))
    mysql.connection.commit()

    # redirect back to the gardenbedamendments page
    return redirect("/gardenbedamendments")
    
    
# -------- Citation # 2 --------------#

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 4242))
    app.run(port=port, debug=True)