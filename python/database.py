

import os
import pymysql.cursors


db_host = os.environ["DB_HOST"]
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]


class Database:

  @staticmethod
  def connect(bot_name=None):
    """
        This method creates a connection with my database
        
        """
    try:
      conn = pymysql.connect(host=db_host,
                             port=3306,
                             user=db_username,
                             password=db_password,
                             db=db_name,
                             charset="utf8mb4",
                             cursorclass=pymysql.cursors.DictCursor)
      print("Bot {} connected to database {}".format(bot_name, db_name))
      return conn
    except ConnectionError as err:
      print(f"An error has occurred: {err.args[1]}")
      print("\n")


  def get_response(self, query, values=None, fetch=False, many_entities=False):
    """
        query: the SQL query with wildcards (if applicable) to avoid injection attacks
        values: the values passed in the query
        """

    # test code ??
    con = Database.connect()
    cur = con.cursor()
    if values:
      if many_entities:
        cur.executemany(query, values)
      else:
        cur.execute(query, values)
    else:
      cur.execute(query)
    if fetch:
      con.close()
      return cur.fetchall()
    return None
    #####

  @staticmethod
  def select(query, values=None, fetch=True):
    database = Database()
    return database.get_response(query, values=values, fetch=fetch)

  @staticmethod
  def insert(query, values=None, many_entities=False):
    database = Database()
    return database.get_response(query,
                                 values=values,
                                 many_entities=many_entities)

  @staticmethod
  def update(query, values=None):
    database = Database()
    return database.get_response(query, values=values)

  @staticmethod
  def delete(query, values=None):
    database = Database()
    return database.get_response(query, values=values)


class Query:
  # Retrieve Astronauts for a mission
  GET_ASTRONAUTS_FOR_MISSION = """
  SELECT Astronaut.*, COUNT(Astronaut_Missions.Mission_ID) AS missions_participated
  FROM Astronaut
  LEFT JOIN Astronaut_Missions ON Astronaut.Astronaut_ID = Astronaut_Missions.Astronaut_ID
  LEFT JOIN Mission ON Astronaut_Missions.Mission_ID = Mission.Mission_ID
  WHERE Mission.Mission_Name = %s
  GROUP BY Astronaut.Astronaut_ID;
  
  """

  #  Insert sustainablity reports
  INSERT_SUSTAINABILITY_REPORT = """
  INSERT INTO Sustainability_Report
  (timestamp, author_first_name, author_last_name, code_name, target_carbon, actual_carbon, season_id)
  VALUES (%s, %s, %s, %s, %s, %s, %s)
  """
  #  Update the capcity of a space colony
  GET_SPACE_COLONY_BY_ID = """
  SELECT * FROM Space_Colony
  WHERE base_id = %s

  """

  UPDATE_SPACE_COLONY_CAPACITY = """
  UPDATE Space_Colony
  SET colony_capacity = %s
  WHERE base_id = %s
  """
  # Delete the inactive colonies
  DELETE_INACTIVE_COLONIES = """
  DELETE FROM Colony
  WHERE colony_type = %s
  AND Colony.base_id NOT IN (
    SELECT DISTINCT Mission_Colony.base_id
    FROM Mission_Colony
  )
  """
  # Average age of astronauts for a mission (will be a function)
  AVG_AGE_FOR_MISSION = """
  SELECT AVG(DATEDIFF(CURDATE(), Astronaut.Date_of_Birth) / 365) AS avg_age
  FROM Astronaut
  LEFT JOIN Astronaut_Missions ON Astronaut.Astronaut_ID = Astronaut_Missions.Astronaut_ID
  LEFT JOIN Mission ON Astronaut_Missions.Mission_ID = Mission.Mission_ID
  WHERE Mission.Mission_Name = %s
  """
  # Retrieve total astronauts with a medical condition (will be a procedure)
  TOTAL_ASTRONAUTS_WITH_CONDITION = """
  SELECT COUNT(*) AS total_astronauts
  FROM Astronaut
  LEFT JOIN Medical_History ON Astronaut.Astronaut_ID= Medical_History.astronaut_id_medical
  WHERE Medical_History.medical_condition = %s
  """
  # Find average power consumption by the resource category.
  AVG_POWER_BY_CATEGORY = """
  SELECT Resource_Category.category_name, AVG(Power.power_percentage) AS avg_power
  FROM Resource_Category
  LEFT JOIN Power ON Resource_Category.resource_manager_id = Power.resource_manager_id
  GROUP BY Resource_Category.category_name
  HAVING AVG(Power.power_percentage) IS NOT NULL
  """
  #  Insert a Research Discovery
  GET_RESEARCH_DISCOVERY_BY_ID = """
  SELECT * FROM Research_Discovery
  WHERE discovery_id = %s
  """

  INSERT_DISCOVERY = """
  INSERT INTO Research_Discovery (discovery_description) VALUES (%s)
  """
  # Update completed missions for astronauts
  AUTO_UPDATE_ASTRONAUT_STATUS_COMPLETED = """
  CREATE TRIGGER update_astronaut_status_completed
  AFTER UPDATE ON Mission
  FOR EACH NOW
  BEGIN
    IF NEW.End_Date <= NOW() THEN
      UPDATE Astronaut_Missions
      SET Status = 'Completed'
      WHERE Mission_ID = NEW.Mission_ID
    END IF;
  END;
  """
  # Delete mission reports that have no associated missions
  DELETE_MISSION_REPORTS_WITHOUT_MISSIONS = """
  DELETE FROM Mission_Report
  WHERE report_id = %s
  AND mission_id_report NOT IN (
    SELECT DISTINCT Mission_Report.mission_id_report
    FROM Mission_Report
    JOIN Mission ON Mission_Report.mission_id_report = Mission.Mission_ID
  )
  """
  #  Find the total resources in category (func)
  TOTAL_RESOURCES_IN_CATEGORY = """
  SELECT COUNT(*) AS total_resources
  FROM Resource_Category
  LEFT JOIN Resource_Manager ON Resource_Category.resource_manager_id = Resource_Manager.resource_manager_id
  WHERE Resource_Category.category_name = %s
  """
  #  Update vital sign critical (trigger)
  AUTO_UPDATE_VITAL_SIGN_TYPE_CRITICAL = """
  CREATE TRIGGER update_vital_sign_type_critical
  BEFORE INSERT ON Vital_Sign_Reading
  FOR EACH ROW
  BEGIN
    IF NEW.reading_value < 50 THEN
      SET NEW.reading_type = 'Critical';
    END IF;
  END;
  """

  #  Find the scientists for a respective discovery
  GET_SCIENTISTS_FOR_DISCOVERY = """
  SELECT Colony_Scientist.first_name, Colony_Scientist.last_name
  FROM Colony_Scientist
  JOIN Colony_Scientist_Research_Discovery ON Colony_Scientist.scientist_id = Colony_Scientist_Research_Discovery.scientist_id
  WHERE Colony_Scientist_Research_Discovery.discovery_id = %s
  """

  # Find the astronauts who have not participated in any missions since a certain date
  GET_INACTIVE_ASTRONAUTS = """
  SELECT Astronaut
  FROM Astronaut
  LEFT JOIN Astronaut_Missions ON Astronaut.Astronaut_ID = Astronaut_Missions.Astronaut_ID
  WHERE Astronaut_Missions.Mission_ID IS NULL
  OR Astronaut_Missions.Mission_ID NOT IN (
    SELECT Mission_ID
    FROM Mission
    WHERE Start_Date >= %s
  )
  """
