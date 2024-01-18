"""
       # opens a new connection to my database
       connection = Database.connect()
       # closes the previous connection to avoid memory leaks
       connection.close()
"""

from database import Database, Query


class Astronaut:
  """
  Class for astronaut_realated things
  """

  def __init__(self, astronaut_id=None):
    self._id = astronaut_id
    self._name = None
    self._missions_participated = None
    self._medical_condition = None
    self._total_astronauts_with_condition = None
    self._load()

  def _load(self):
    astronauts_data = Database.select(Query.GET_ASTRONAUTS_FOR_MISSION,
                                      (self._id, ))
    if astronauts_data is not None:
      if astronauts_data:
        astronaut_data = astronauts_data[0]
        self._name = astronaut_data['Astronaut_Name']
        self._missions_participated = astronaut_data['missions_participated']

    medical_condition_data = Database.select(
        Query.TOTAL_ASTRONAUTS_WITH_CONDITION, (self._medical_condition, ))
    if medical_condition_data is not None:
      if medical_condition_data:
        condition_data = medical_condition_data[0]
        self._total_astronauts_with_condition = condition_data[
            'total_astronauts']

  @staticmethod
  def get(astronaut_id):
    return Astronaut(astronaut_id)

  @staticmethod
  def all(Mission_Name):
    astronauts = []
    astronauts_data = Database.select(Query.GET_ASTRONAUTS_FOR_MISSION,
                                      (Mission_Name))
    if astronauts_data is not None:
      for astronaut_data in astronauts_data:
        astronaut_id = astronaut_data['Astronaut_ID']
        astronaut = Astronaut(astronaut_id)
        astronauts.append(astronaut)
    return astronauts

  def get_name(self):
    return self._name

  def get_missions_participated(self):
    return self._missions_participated

  def get_medical_condition(self):
    return self._medical_condition

  def set_medical_condition(self, medical_condition):
    self._medical_condition = medical_condition

  def get_total_astronauts_with_condition(self):
    return self._total_astronauts_with_condition


class SustainabilityReport:

  def __init__(self,
               timestamp=None,
               author_first_name=None,
               author_last_name=None,
               code_name=None,
               target_carbon=None,
               actual_carbon=None,
               season_id=None,
               report_id=None):
    self._report_id = report_id
    self._timestamp = timestamp
    self._author_first_name = author_first_name
    self._author_last_name = author_last_name
    self._code_name = code_name
    self._target_carbon = target_carbon
    self._actual_carbon = actual_carbon
    self._season_id = season_id

  @staticmethod
  def create_report(timestamp, author_first_name, author_last_name, code_name,
                    target_carbon, actual_carbon, season_id):
    report = SustainabilityReport()
    report._timestamp = timestamp
    report._author_first_name = author_first_name
    report._author_last_name = author_last_name
    report._code_name = code_name
    report._target_carbon = target_carbon
    report._actual_carbon = actual_carbon
    report._season_id = season_id

    return report


class SpaceColony:

  def __init__(self, base_id=None):
    self._base_id = base_id
    self._colony_capacity = None
    self._load()

  def _load(self):
    space_colony_data = Database.select(Query.GET_SPACE_COLONY_BY_ID,
                                        (self._base_id, ))
    if space_colony_data is not None and space_colony_data:
      space_colony = space_colony_data[0]
      self._colony_capacity = space_colony['colony_capacity']

  @staticmethod
  def get(base_id):
    return SpaceColony(base_id)

  def get_colony_capacity(self):
    return self._colony_capacity

  def update_colony_capacity(self, new_capacity):
    Database.update(Query.UPDATE_SPACE_COLONY_CAPACITY,
                    (new_capacity, self._base_id))


class Colony:

  def __init__(self, base_id=None):
    self._base_id = base_id
    self._colony_type = None
    self._load()

  def _load(self):
    colony_data = Database.select(Query.GET_SPACE_COLONY_BY_ID,
                                  (self._base_id, ))
    if colony_data is not None and colony_data:
      colony = colony_data[0]
      self._colony_type = colony['colony_type']

  @staticmethod
  def get_by_id(base_id):
    return Colony(base_id)

  @staticmethod
  def get_by_colony_type(colony_type):
    return Colony(colony_type)

  def get_colony_type(self):
    return self._colony_type

  @staticmethod
  def delete_inactive_colonies(colony_type):
    Database.delete(Query.DELETE_INACTIVE_COLONIES, (colony_type, ))


class AvgAgeMission:

  def __init__(self, mission_name=None):
    self._mission_name = mission_name
    self._avg_age = None
    self._load()

  def _load(self):
    avg_age_data = Database.select(Query.AVG_AGE_FOR_MISSION,
                                   (self._mission_name, ))
    if avg_age_data is not None and avg_age_data:
      avg_age = avg_age_data[0]
      self._avg_age = avg_age['avg_age']

  @staticmethod
  def get_by_mission_name(mission_name):
    return AvgAgeMission(mission_name)

  def get_avg_age(self):
    return self._avg_age


class ResourceCategory:

  def __init__(self, category_name=None):
    self._category_name = category_name
    self._avg_power = None
    self._load()

  def _load(self):
    category_data = Database.select(Query.AVG_POWER_BY_CATEGORY,
                                    (self._category_name, ),
                                    fetch=True)
    if category_data is not None and category_data:
      category = category_data[0]
      self._avg_power = category['avg_power']

  @staticmethod
  def get_by_category_name(category_name):
    return ResourceCategory(category_name)

  def get_category_name(self):
    return self._category_name

  def get_avg_power(self):
    return self._avg_power


class ResearchDiscovery:

  def __init__(self, discovery_id=None):
    self._discovery_id = discovery_id
    self._discovery_description = None
    self._load()

  def _load(self):
    if self._discovery_id is not None:
      discovery_data = Database.select(Query.GET_RESEARCH_DISCOVERY_BY_ID,
                                       (self._discovery_id, ))

      if discovery_data is not None and discovery_data:
        discovery = discovery_data[0]
        self._discovery_description = discovery['discovery_description']

  @staticmethod
  def get_by_id(discovery_id):
    return ResearchDiscovery(discovery_id)

  def get_discovery_description(self):
    return self._discovery_description

  @staticmethod
  def insert_discovery(discovery_description):
    Database.insert(Query.INSERT_DISCOVERY, (discovery_description, ))
