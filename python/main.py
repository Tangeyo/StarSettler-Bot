
import discord
from discord.ext import commands
from models import *
from database import Database

TOKEN = 'REDACTED'

intents = discord.Intents.all()

bot = commands.Bot(command_prefix='!', intents=discord.Intents.all())


@bot.event
async def on_ready():
  print(f"Bot {bot.user} has joined the room")
  Database.connect(bot.user)


@bot.command(
    name="test",
    description="database business requirement"
)
async def _test(ctx):
  testModel = TestModel(ctx)
  response = testModel.response()
  await ctx.send(response)


@bot.command(
    name="missionastronauts",
    description=
    "Retrieves the list of astronauts, their assigned suits, and the number of missions each astronaut has participated in for a given mission. missionastronauts <mission_name>"
)
async def missionastronauts(ctx, mission_name: str):
  astronauts = Astronaut.all(mission_name)

  if not astronauts:
    await ctx.send(f"No astronauts have participated in mission {mission_name}"
                   )
    return

  response = ""
  for astronaut in astronauts:
    response += f"\nAstronaut ID: {astronaut._id}"
    response += f"\nAstronaut Name: {astronaut.get_name()}"
    response += f"\nAstronaut Missions Participated: {astronaut.get_misisons.participated()}\n"

  await ctx.send("This method is not implemented yet")


@bot.command(
    name="insertsustainability",
    description=
    "Inserts a new sustainability report for a specific mission with the provided details. insertsustainability <mission_name> <timestamp> <author_first_name> <author_last_name> <code_name> <target_carbon> <actual_carbon> <season_id>"
)
async def insertsustainability(ctx, *args):
  if len(args) != 7:
    await ctx.send("Invalid number of arguments, please try again")
    return

  try:
    timestamp, author_first_name, author_last_name, code_name, target_carbon, actual_carbon, season_id = args
    sustainability_report = SustainabilityReport(timestamp, author_first_name,
                                                 author_last_name, code_name,
                                                 target_carbon, actual_carbon,
                                                 season_id)

    Database.insert(Query.INSERT_SUSTAINABILITY_REPORT,
                    (sustainability_report._timestamp,
                     sustainability_report._author_first_name,
                     sustainability_report._author_last_name,
                     sustainability_report._code_name,
                     sustainability_report._target_carbon,
                     sustainability_report._actual_carbon,
                     sustainability_report._season_id))

    await ctx.send("Report inserted successfully")
  except Exception as e:
    await ctx.send(f"Invalid arguments: {e}")


@bot.command(
    name="updatespacecolony",
    description=
    "Updates the capacity of a space colony with the specified base ID to a new value. updatespacecolony <base_id> <new_capacity>"
)
async def updatespacecolony(ctx, *args):
  if len(args) != 2:
    await ctx.send("Invalid number of arguments, please try again")
    return
  try:
    base_id, new_capacity = map(int, args)
    space_colony = SpaceColony.get(base_id)
    if space_colony is not None:
      space_colony.update_colony_capacity(new_capacity)
      await ctx.send(f"Space colony with base ID {base_id} has been updated.")
    else:
      await ctx.send("Space colony not found with the specified base ID")
  except ValueError:
    await ctx.send("Invalid arguments, please try again")


@bot.command(
    name="deleteinactivecolonies",
    description=
    "Deletes all records of colonies of the specified type that have no associated missions. deleteinactivecolonies <colony_type>"
)
async def deleteinactivecolonies(ctx, *args):
  if len(args) != 1:
    await ctx.send("Invalid number of arguments, please try again")
    return

  try:
    colony_type = args[0]
    colony = Colony.get_colony_type(colony_type)

    if colony is not None:
      Colony.delete_inactive_colonies(colony_type)
      await ctx.send(
          f"All inactive colonies of type {colony_type} have been deleted.")

    else:
      await ctx.send(f"No colonies of type {colony_type} found")
  except Exception as e:
    await ctx.send(f"Invalid arguments: {e}")


@bot.command(
    name="avgageformission",
    description=
    "Calculates and returns the average age of astronauts assigned to a specific mission. avgageformission <mission_name>"
)
async def avgageformission(ctx, *args):
  if len(args) != 1:
    await ctx.send("Invalid number of arguments, please try again")
    return

  try:
    mission_name = args[0]
    avg_age_instance = AvgAgeMission.get_by_mission_name(mission_name)

    if avg_age_instance is not None:
      await ctx.send(
          f"The average age of astronauts assigned to mission {mission_name} is {avg_age_instance.get_avg_age()} years."
      )
    else:
      await ctx.send(f"No data found for mission {mission_name}")

  except Exception as e:
    await ctx.send(f"Invalid arguments: {e}")


@bot.command(
    name="Update Spacecraft Status for Maintenance",
    description=
    "A trigger that updates the status of a spacecraft to 'Maintenance Required' when its flight time exceeds a certain threshold. NO COMMAND."
)
async def updatespacecraft(ctx, *args):
  await ctx.send("Error. No command found.")


@bot.command(
    name="totalastronautscondition",
    description=
    "Executes a stored procedure to retrieve the total number of astronauts with a specific medical condition. totalastronautscondition <medical_condition>"
)
async def totalastronautscondition(ctx, *args):
  if len(args) != 1:
    await ctx.send("Invalid number of arguments, please try again")
    return

  medical_condition = args[0]

  try:
    astronaut = Astronaut()
    astronaut.set_medical_condition(medical_condition)

    total_astronauts = astronaut.get_total_astronauts_with_condition()

    await ctx.send(
        f"Total astronauts with medical condition {medical_condition}: {total_astronauts}"
    )
  except Exception as e:
    await ctx.send(f"Invalid arguments: {e}")


@bot.command(
    name="avgpowerbycategory",
    description=
    "Retrieves a report showing the average power consumption for each resource category, excluding categories with total consumption below a certain threshold."
)
async def avgpowerbycategory(ctx, *args):
  if len(args) != 1:
    await ctx.send("Invalid number of arguments, please try again")
    return

  try:
    category_name = args[0]
    resource_category = ResourceCategory.get_by_category_name(category_name)

    if resource_category.get_avg_power() is not None:
      await ctx.send(
          f"Avergae power consumption for category {category_name}: {resource_category}.get_avg_power()"
      )
    else:
      await ctx.send(f"No data found for category {category_name}")

  except Exception as e:
    await ctx.send(f"Invalid arguments: {e}")


@bot.command(
    name="insertdiscovery",
    description=
    "Inserts a new research discovery with the provided description. insertdiscovery <discovery_description>"
)
async def insertdiscovery(ctx, *args):
  if len(args) < 1:
    await ctx.send("Invalid number of arguments, please try again")
    return

  discovery_description = " ".join(args)

  try:
    discovery_id = Database.insert(Query.INSERT_DISCOVERY,
                                   values=(discovery_description, ))
    await ctx.send(f"Inserted description: {discovery_description}")
  except Exception as e:
    await ctx.send(f"Invalid arguments: {e}")


@bot.command(
    name="Update Colony Status for Completed Mission",
    description=
    " Trigger based, automatically updates the status of all astronauts assigned to a specific mission to 'Completed' when the mission's end date is reached. NO COMMAND FOUND"
)
async def updatecolonystatus(ctx, *args):
  await ctx.send("Error. No command")


@bot.command(
    name="deletereports",
    description=
    "Deletes all records from the Mission_Report table where the report ID is specified and there are no associated missions. deletereports <report_id>"
)
async def deletereports(ctx, *args):
  await ctx.send("This method is not implemented yet")


@bot.command(
    name="totalresourcescategory",
    description=
    "Executes a function to return the total number of resources in a specific category. totalresourcescategory <category_name>"
)
async def totalresourcecategory(ctx, *args):
  await ctx.send("This method is not implemented yet")


@bot.command(
    name="Update Vital Sign Reading Type to 'Critical'",
    description=
    "Automatically updates the reading type of vital signs to 'Critical' when the reading falls below a certain value."
)
async def vitalsigncritical(ctx, *args):
  await ctx.send("This method is not implemented yet")


@bot.command(
    name="scientistsfordiscovery",
    description=
    "Executes a stored procedure to retrieve the names of scientists involved in a specific discovery. scientistsfordiscovery <discovery_id>"
)
async def scientistsfordiscovery(ctx, *args):
  await ctx.send("This method is not implemented yet")


@bot.command(
    name="inactiveastronauts",
    description=
    "Retrieves a list of astronauts who have not participated in any missions since the specified date. inactiveastronauts <date>"
)
async def inactiveastronauts(ctx, *args):
  await ctx.send("This method is not implemented yet")


bot.run(TOKEN)
