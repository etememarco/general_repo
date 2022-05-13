import xlrd
import mysql.connector

# Ouvre le fichier Excel et definit la feuille de calcul où les données sont stockées
book = xlrd.open_workbook("reservations.xls")
sheet = book.sheet_by_name("reservations")

# Etablit la connexion à la base de données
mydb = mysql.connector.connect (host="localhost", user = "root", passwd = "", database = "reservations")

# Obtention du curseur utilisé pour parcourir la base de données ligne par ligne
cursor = mydb.cursor()

# requête SQL permettant d'insérer les données dans la base de données
query = """insert into oeuvre (ID, type_document, nb_reservations, titre, auteur) VALUES (%s, %s, %s, %s, %s)"""
# Create a For loop to iterate through each row in the XLS file, starting at row 2 to skip the headers
for r in range(1, sheet.nrows):
		ID		    = sheet.cell(r,0).value
		type_document	= sheet.cell(r,1).value
		nb_reservations = sheet.cell(r,2).value
		titre		    = sheet.cell(r,3).value 
		auteur		    = sheet.cell(r,4).value
        
		
		# Affecte les valeurs correspondant à chaqueligne
		values = (ID, type_document, nb_reservations, titre, auteur)

		# Execute la requête SQL
		cursor.execute(query, values)

# fermele curseur
cursor.close()

# permet la validation d'une transaction en cours lorsque les données de la table sont modifiées
mydb.commit()
#permet d'annuler une modification lorsque celà est nécessaire
mydb.rollback()

# Close the database connection
mydb.close()

# Affichage pour la vérification de l'import effectué
#print ""
print ("Tout est bon!")
columns = str(sheet.ncols)
rows = str(sheet.nrows)
print ("Nous avons importe " +columns+" colonnes et "  +rows+  " lignes a MYSQL! ")