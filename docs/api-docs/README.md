# API Documentation

This directory contains documentation for the system's APIs, including request and response structures, protocols, and standard conventions.

## Overview
- **Base URL**: `https://api.fhtapp.local`
- **Protocol**: HTTP/1.1 or HTTP/2
- **Data Format**: JSON (application/json)
- **Auth Strategy**: JWT / OAuth2

## Authentication
To authenticate requests, include the bearer token in your request header:
```http
Authorization: Bearer <your_access_token>
```

## Status Codes
- `200 OK` - Request succeeded.
- `201 Created` - Resource successfully created.
- `400 Bad Request` - Invalid request payload or parameters.
- `401 Unauthorized` - Authentication failed or is missing.
- `403 Forbidden` - Insufficient permissions.
- `404 Not Found` - The requested resource does not exist.
- `500 Internal Server Error` - An unexpected error occurred on the server.
