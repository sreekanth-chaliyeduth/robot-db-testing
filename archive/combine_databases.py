import pymysql

# Database connection configurations
DB_CONFIGS = {
    "db1": {"host": "localhost", "user": "myuser", "password": "mypass", "database": "InsuranceDB1", "port": 3306},
    "db2": {"host": "localhost", "user": "myuser", "password": "mypass", "database": "InsuranceDB2", "port": 3307},
    "db3": {"host": "localhost", "user": "myuser", "password": "mypass", "database": "InsuranceDB3", "port": 3308},
}


def fetch_data(config, query):
    """
    Connects to a database and executes a query.
    Returns the fetched data.
    """
    connection = pymysql.connect(
        host=config["host"],
        user=config["user"],
        password=config["password"],
        database=config["database"],
        port=config["port"],
    )
    try:
        with connection.cursor() as cursor:
            cursor.execute(query)
            data = cursor.fetchall()
    finally:
        connection.close()
    return data


def combine_data():
    """
    Combines data from InsuranceDB1, InsuranceDB2, and InsuranceDB3 into a single dataset.
    Writes the combined data to a SQL file (new-db.sql).
    """
    # Queries to fetch data
    query_db1 = "SELECT CustomerID, FullName, Age, Gender FROM Customers;"
    query_db2 = "SELECT CorporateID, CompanyName, ContactPerson FROM CorporateCustomers;"
    query_db3 = "SELECT PolicyNumber, ClaimDate, ClaimAmount FROM Claims;"

    # Fetch data from each database
    db1_data = fetch_data(DB_CONFIGS["db1"], query_db1)
    db2_data = fetch_data(DB_CONFIGS["db2"], query_db2)
    db3_data = fetch_data(DB_CONFIGS["db3"], query_db3)

    # Combine data into a single structure
    combined_data = []
    max_length = max(len(db1_data), len(db2_data), len(db3_data))
    for i in range(max_length):
        combined_data.append({
            "CustomerID": db1_data[i][0] if i < len(db1_data) else None,
            "CustomerName": db1_data[i][1] if i < len(db1_data) else None,
            "Age": db1_data[i][2] if i < len(db1_data) else None,
            "Gender": db1_data[i][3] if i < len(db1_data) else None,
            "CompanyName": db2_data[i][1] if i < len(db2_data) else None,
            "ContactPerson": db2_data[i][2] if i < len(db2_data) else None,
            "PolicyNumber": db3_data[i][0] if i < len(db3_data) else None,
            "ClaimDate": db3_data[i][1] if i < len(db3_data) else None,
            "ClaimAmount": db3_data[i][2] if i < len(db3_data) else None,
        })

    # Write combined data to a new SQL file
    with open("new-db.sql", "w") as f:
        f.write("CREATE DATABASE IF NOT EXISTS CombinedDB;\n")
        f.write("USE CombinedDB;\n")
        f.write("""
        CREATE TABLE IF NOT EXISTS CombinedData (
            CustomerID INT,
            CustomerName VARCHAR(100),
            Age INT,
            Gender ENUM('Male', 'Female'),
            CompanyName VARCHAR(150),
            ContactPerson VARCHAR(100),
            PolicyNumber VARCHAR(20),
            ClaimDate DATE,
            ClaimAmount DECIMAL(10, 2)
        );
        """)
        for row in combined_data:
            f.write(f"INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES "
                    f"({row['CustomerID']}, '{row['CustomerName']}', {row['Age']}, '{row['Gender']}', "
                    f"'{row['CompanyName']}', '{row['ContactPerson']}', '{row['PolicyNumber']}', "
                    f"'{row['ClaimDate']}', {row['ClaimAmount']});\n")

    return "SQL file generated successfully"


# Allow the function to be called directly in Robot Framework
if __name__ == "__main__":
    combine_data()
