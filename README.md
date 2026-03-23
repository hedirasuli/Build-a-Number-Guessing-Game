# Number Guessing Game 🎮

A Bash-based interactive game that challenges users to guess a randomly generated number between 1 and 1000. This project integrates **Bash Scripting** with a **PostgreSQL Database** to track user statistics and high scores.

## 🚀 Features
- **User Recognition:** Greets returning users with their play history (total games and best score).
- **Persistent Data:** Stores user info and game stats in a PostgreSQL database.
- **Input Validation:** Ensures only integers are processed, providing helpful feedback for invalid inputs.
- **Dynamic Hints:** Provides "higher" or "lower" clues until the secret number is found.

## 🛠️ Tech Stack
- **Language:** Bash Shell Scripting
- **Database:** PostgreSQL
- **Version Control:** Git

## 📋 Database Schema
The project uses a database named `number_guess` with a `users` table:
- `user_id`: Unique identifier (Serial)
- `username`: Unique name (up to 22 characters)
- `games_played`: Total number of games completed
- `best_game`: Fewest number of guesses taken to win

## ⚙️ Installation & Usage
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/hedirasuli/number-guessing-game.git](https://github.com/hedirasuli/number-guessing-game.git)
    ```
2. Setup the Database:
Import the provided SQL dump:
 ```bash
psql -U postgres < number_guess.sql
 ```
3. Run the Game:
 ```bash
   chmod +x number_guess.sh
./number_guess.sh
 ```
Created as part of the freeCodeCamp Relational Database Certification
