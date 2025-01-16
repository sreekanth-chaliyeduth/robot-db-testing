"""
Module to combine data from multiple MySQL databases
and generate a new SQL file with the combined data.
Raises exceptions for errors.
"""

import pymysql


DB_CONFIGS = {
    "db1": {
        "host": "localhost",
        "user": "myuser",
        "password": "mypass",
        "database": "InsuranceDB1",
        "port": 3306,
    },
    "db2": {
        "host": "localhost",
        "user": "myuser",
        "password": "mypass",
        "database": "InsuranceDB2",
        "port": 3307,
    },
    "db3": {
        "host": "localhost",
        "user": "myuser",
        "password": "mypass",
        "database": "InsuranceDB3",
        "port": 3308,
    },
}


def fetch_data(db_config, query):
    """
    Fetch data from a MySQL database using the provided query.

    Args:
        db_config (dict): Configuration for the database connection.
        query (str): SQL query to execute.

    Returns:
        list: Fetched data from the database.

    Raises:
        RuntimeError: If a database error occurs.
    """
    try:
        connection = pymysql.connect(
            host=db_config["host"],
            user=db_config["user"],
            password=db_config["password"],
            database=db_config["database"],
            port=db_config["port"],
        )
        with connection.cursor() as cursor:
            cursor.execute(query)
            result = cursor.fetchall()
        return result
    except pymysql.MySQLError as error:
        raise RuntimeError(
            f"Database error for {db_config['database']}: {error}"
        ) from error
    finally:
        if "connection" in locals():
            connection.close()


def generate_combined_data():
    """
    Combine data from multiple databases and generate a new dataset.

    Returns:
        list: Combined data from all databases.

    Raises:
        AssertionError: If any data validation fails.
    """
    # Queries to fetch data
    queries = {
        "db1": "SELECT CustomerID, FullName, Age, Gender FROM Customers;",
        "db2": (
            "SELECT CorporateID, CompanyName, ContactPerson "
            "FROM CorporateCustomers;"
        ),
        "db3": (
            "SELECT PolicyNumber, ClaimDate, ClaimAmount FROM Claims;"
        ),
    }

    # Fetch data from databases
    db1_data = fetch_data(DB_CONFIGS["db1"], queries["db1"])
    db2_data = fetch_data(DB_CONFIGS["db2"], queries["db2"])
    db3_data = fetch_data(DB_CONFIGS["db3"], queries["db3"])

    # Validate fetched data
    assert isinstance(db1_data, (list, tuple)), (
        "Data from db1 is not a list or tuple."
    )
    assert isinstance(db2_data, (list, tuple)), (
        "Data from db2 is not a list or tuple."
    )
    assert isinstance(db3_data, (list, tuple)), (
        "Data from db3 is not a list or tuple."
    )

    # Combine the data
    max_rows = max(len(db1_data), len(db2_data), len(db3_data))
    combined_data = [
        {
            "CustomerID": db1_data[i][0] if i < len(db1_data) else None,
            "CustomerName": db1_data[i][1] if i < len(db1_data) else None,
            "Age": db1_data[i][2] if i < len(db1_data) else None,
            "Gender": db1_data[i][3] if i < len(db1_data) else None,
            "CompanyName": db2_data[i][1] if i < len(db2_data) else None,
            "ContactPerson": db2_data[i][2] if i < len(db2_data) else None,
            "PolicyNumber": db3_data[i][0] if i < len(db3_data) else None,
            "ClaimDate": db3_data[i][1] if i < len(db3_data) else None,
            "ClaimAmount": db3_data[i][2] if i < len(db3_data) else None,
        }
        for i in range(max_rows)
    ]

    assert combined_data, "No combined data generated."
    return combined_data


def write_sql_file(data, file_name="new-db.sql"):
    """
    Write the combined data to a SQL file.

    Args:
        data (list): Combined data to write to the file.
        file_name (str): Name of the output SQL file.

    Returns:
        str: Success message.

    Raises:
        RuntimeError: If writing to the file fails.
    """
    try:
        with open(file_name, "w", encoding="utf-8") as sql_file:
            sql_file.write("CREATE DATABASE IF NOT EXISTS CombinedDB;\n")
            sql_file.write("USE CombinedDB;\n")
            sql_file.write(
                """
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
                """
            )
            for row in data:
                sql_file.write(
                    f"INSERT INTO CombinedData "
                    f"(CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, "
                    f"PolicyNumber, ClaimDate, ClaimAmount) VALUES "
                    f"({row['CustomerID']}, '{row['CustomerName']}', {row['Age']}, "
                    f"'{row['Gender']}', '{row['CompanyName']}', '{row['ContactPerson']}', "
                    f"'{row['PolicyNumber']}', '{row['ClaimDate']}', {row['ClaimAmount']});\n"
                )
        return f"SQL file '{file_name}' generated successfully."
    except Exception as error:
        raise RuntimeError(f"Failed to write SQL file: {error}") from error


def combine_data():
    """
    Main function to combine data from databases and write it to an SQL file.

    Returns:
        str: Success or error message.

    Raises:
        RuntimeError: If any step in the process fails.
    """
    combined_data = generate_combined_data()
    return write_sql_file(combined_data)


if __name__ == "__main__":
    try:
        RESULT = combine_data()
        print(RESULT)
    except RuntimeError as error:
        print(f"Error: {error}")
