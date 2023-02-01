<div align="center">
  <p> <img src="https://dl.circleci.com/status-badge/img/gh/Gather-Studio/gather_be/tree/main.svg?style=svg"> </p>
  <a href="https://moon-garden-fe.herokuapp.com/" target="_blank" rel="noopener noreferrer"><img src="https://user-images.githubusercontent.com/48455658/203390802-70fbe4a6-6741-40f5-8dd5-beed7cac0a2d.png" alt="logo" width="30%"/></a>
</div>

<p align="center">
  <a href="#"><strong>Check out Gather Studio's Deployed Website Here »</strong></a>
  <br>
  <a href="https://github.com/Gather-Studio/gather_fe"><strong>Explore the Front End Repository »</strong></a>
  </p>
</div>

## About The Gather Studio API

Welcome!
This API is the backend for the Gather Studio website deployed to Heroku. It allows members to create an account, sign in, and track the pottery pieces they have made at the studio. 

<details>
  <summary>Table Of Contents</summary>
  <ol>
    <li>
      <a href="#schema">Schema</a>
     </li>
    <li>
      <a href="#user-endpoints">User Endpoints</a>
      <ul>
        <li><a href="#get-all-users---admin-only">Get All Users</a></li>
        <li><a href="#get-user-by-id">Get User By ID</a></li>
        <li><a href="#create-user">Create User</a></li>
        <li><a href="#update-user">Update User</a></li>
        <li><a href="#delete-user">Delete User</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">User Item Endpoints</a>
      <ul>
        <li><a href="#get-all-user-items">Get All of a User's Items</a></li>
        <li><a href="#get-item">Get Item</a></li>
        <li><a href="#create-item">Create Item</a></li>
        <li><a href="#update-item">Update Item</a></li>
        <li><a href="#delete-item">Delete Item</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Session Endpoints</a>
      <ul>
        <li><a href="#login">Login/Create Session</a></li>
      </ul>
    </li>
  </ol>
</details>

## Schema
<div align = "center">
  <img src="https://user-images.githubusercontent.com/48455658/216098476-00f5c207-dba7-4656-94ca-e890d105818d.png">
</div>

## User Endpoints

### Get All Users - Admin Only
This endpoint will return all users who are currently signed up to the Gather Studio API. This endpoint is only accessible by admin, and requires authorization through an api key query parameter. Admin members are given an unique API key upon creation of their user account. Admin API keys can be retrieved through this endpoint, default users return an api key value of null.

#### Request:
```
GET /api/v1/users?api_key=api_key_here
Content-Type: application/json
Accept: application/json
```
Sample Response:

```json
{
    "data": [
        {
            "id": "1",
            "type": "user",
            "attributes": {
                "first_name": "Winston",
                "last_name": "Bishop",
                "email": "winston1@newgirl.com",
                "api_key": null
            }
        },
        {
            "id": "2",
            "type": "user",
            "attributes": {
                "first_name": "Jessica",
                "last_name": "Day",
                "email": "missday@newgirl.com",
                "api_key": null
            }
        },
                {
            "id": "3",
            "type": "user",
            "attributes": {
                "first_name": "Example",
                "last_name": "Admin",
                "email": "admin@gmail.com",
                "api_key": "93387c3571f3dd2113bb36bc65005803"
            }
        }
    ]
}
```

### Get User by ID 

```
GET /api/v1/users/3
Content-Type: application/json
Accept: application/json
```
Sample Response:

```json
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "first_name": "Winston",
            "last_name": "Bishop",
            "email": "winston@newgirl.com"
        }
    }
}
```
## Create User
This endpoint takes in a user's unique email and password through the JSON payload in the body of the request. The password is processed with the BCrypt gem, which securely encrypts the password through a salt and hashing and returns a password digest. The user is also assigned an API key if they are an admin using the SecureRandom library. The email is downcased then stored with the password digest in the user table, they are a default user the api key value is null. An unsuccessful request returns the appropriate 400 level status code and a specific error explaining the issue i.e passwords do not match, email already taken, missing field.

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "jessday@newgirl.com",
  "password": "craftygal123",
  "password_confirmation": "craftygal123",
  "first_name": "Jessica",
  "last_name": "Day
}
```


