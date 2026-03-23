#!/bin/bash

# Variable for database connection
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Generate a random secret number between 1 and 1000
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

# Prompt user for their username
echo "Enter your username:"
read USERNAME

# Fetch user data from the database
USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")

# Check if the user exists in the system
if [[ -z $USER_INFO ]]
then
  # Welcome message for a new user
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # Insert the new user into the database
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
else
  # Welcome message for a returning user
  echo "$USER_INFO" | while IFS="|" read GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi

# Ask the user for the first guess
echo "Guess the secret number between 1 and 1000:"
GUESS_COUNT=0

# Loop until the correct number is guessed
while true
do
  read USER_GUESS
  (( GUESS_COUNT++ ))

  # Validate if the input is an integer using regex
  if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  # Check if the guess matches the secret number
  elif [[ $USER_GUESS -eq $SECRET_NUMBER ]]
  then
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
    break
  # Hint if the guess is too high
  elif [[ $USER_GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  # Hint if the guess is too low
  else
    echo "It's higher than that, guess again:"
  fi
done

# --- Database Update Logic ---

# Get the user_id for the current player
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

# Update the total number of games played
UPDATE_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE user_id=$USER_ID")

# Get the existing best game record
BEST_SCORE=$($PSQL "SELECT best_game FROM users WHERE user_id=$USER_ID")

# Update best_game if it's the first win or current score is better (fewer guesses)
if [[ -z $BEST_SCORE || $GUESS_COUNT -lt $BEST_SCORE ]]
then
  UPDATE_BEST_SCORE=$($PSQL "UPDATE users SET best_game = $GUESS_COUNT WHERE user_id=$USER_ID")
fi
# Final polish
 
