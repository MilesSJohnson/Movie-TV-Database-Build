# Movie-TV-Database-Build

Is a SQL Server relational database that models movies and TV shows, the people who make and appear in them, the awards they win, and the viewers who watch them across streaming platforms.

## Overview

This script builds a normalized database from scratch. It drops existing constraints and tables if present, recreating the schema, wiring up foreign keys, and seeding it with sample data. It's designed to answer questions like "which actors worked with which directors," "what did a viewer watch and rate," and "which shows won which awards."

## Schema

**Reference tables**
- `Director` — directors (name, gender)
- `Actor` — actors (name, gender)
- `Genre` — genre descriptions (Action, Comedy, Drama, etc.)
- `Award` — award categories (Best Movie, Leading Actor, etc.)
- `Platform` — streaming/broadcast platforms, flagged as internet-based or not

**Core entity**
- `Show` — movies and TV shows, including title, release date, description, box office earnings, IMDB rating, and an `IsMovie` flag; linked to one `Genre` and one `Director`

**Relationship tables**
- `Role` — links `Actor` ↔ `Show`, with character name and salary (composite PK: ShowID + ActorID)
- `ShowAward` — links `Show` ↔ `Award`, with the year won (composite PK: ShowID + AwardID)
- `Viewing` — links `Viewer` ↔ `Show` ↔ `Platform`, with watch datetime and the viewer's star rating (composite PK: ViewerID + PlatformID + ShowID)

**People who watch**
- `Viewer` — viewers (name, gender), with a self-referencing `BestFriendID` FK pointing to another `Viewer`


## Key Design Notes

- All primary keys use `IDENTITY(1,1)` surrogate integer IDs except the relationship tables, which use composite primary keys of their foreign keys.
- `Viewer.BestFriendID` is a self-referencing foreign key, allowing (but not enforcing mutual) best-friend relationships between viewers.
- The script is idempotent for reruns: it conditionally drops foreign keys and tables (`IF OBJECT_ID(...) IS NOT NULL`) before recreating them, so it can be run repeatedly without manual cleanup.
- `IsMovie` and `IsInternetBased` use `BIT` flags rather than separate tables, keeping the schema simpler for what are effectively boolean attributes.

## Getting Started

The script will:
1. Drop existing foreign keys and tables (if they exist)
2. Recreate all tables
3. Add foreign key constraints
4. Seed reference and sample data (genres, directors, actors, awards, platforms, viewers, shows, roles, awards won, and viewings)
5. Run `SELECT *` against every table so you can verify the load

## Example Queries to Try

- List every actor who has worked with a given director
- Find all awards a show has won and in what years
- Get a viewer's full watch history with ratings, joined to show titles and platforms
- Find viewers and their best friends' favorite genres
- Rank shows by IMDB rating within each genre
