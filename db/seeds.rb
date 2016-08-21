require 'sqlite3'

database = SQLite3::Database.new("db/robot_world_development.db")

# Delete exisiting records from the tasks table before inserting these new records; we'll start from scratch.
database.execute("DELETE FROM robots;")

# Insert records.
database.execute("INSERT INTO robots
                (name, city, state, avatar, birthdate, date_hired, department)
                VALUES
                  ('Jimtron', 'Dallas', 'TX', 'https://robohash.org/YOUR-TEXT.png', '04-20-1970', '05-21-2003', 'Advanced Systems'),
                  ('Bobtron', 'Boston', 'MA', 'https://robohash.org/YOUR-TET.png', '06-22-1975', '05-12-2005', 'Synth Retention'),
                  ('Timtron', 'San Francisco', 'CA', 'https://robohash.org/YOUR-TT.png', '07-26-1989', '05-01-2013', 'Bio Science');"
                )

# verifying that our SQL INSERT statement wroked
puts "It worked and:"
p database.execute("SELECT * FROM robots;")
