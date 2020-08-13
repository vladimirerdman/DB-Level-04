####################
# INSTALL PostgreSQL #
####################

brew install postgresql

# Check version of PostgreSQL
postgres --version

# Start PostgreSQL
brew services start postgresql

# Open PostgreSQL
psql postgres

# Create database
CREATE DATABASE psql_test;

# Connect to DB
\c psql_test

# Create table
CREATE TABLE users (
id SERIAL PRIMARY KEY,
first_name VARCHAR(128) UNIQUE NOT NULL,
last_name VARCHAR(128) UNIQUE NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL
);

# Show tables
\dt

# Drop table
DROP TABLE users

# Quit from Postgresql
\q

# Stop PostgreSQL
brew services stop postgresql

####################
# INSTALL pgadmin4 #
####################

# Turn on cask-versions
brew tap homebrew/cask-versions

# Install pgadmin4
brew cask install pgadmin4

# Go to "Applications" and Open "pgAdmin 4"
# Copy the link http://127.0.0.1:65220/browser/ and paste it into the browser's address bar.
# Create your password
# Done.