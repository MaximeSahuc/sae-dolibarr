#!/usr/bin/env python3

import csv
import requests

API_URL = "http://0.0.0.0/api/index.php/users"
API_KEY = "1Q2b68bUAQohJg9iuh4MXqK1q91XH8Fm"

# Import users list via HTTP requests
with open('../csv_import/test_users.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        user_data = {
            "login": row["login"],
            "password": row["password"],
            "firstname": row["firstname"],
            "lastname": row["lastname"],
            "email": row["email"],
        }
        
        response = requests.post(
            API_URL,
            headers={
                "DOLAPIKEY": API_KEY,
                "Content-Type": "application/json"
            },
            json=user_data
        )
        
        if response.status_code != 200:
            print(f"Error: Failed to create user {row['login']}.\nResponse: {response.text}")
