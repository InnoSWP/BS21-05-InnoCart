import json
import stat
import traceback
import typing
import fastapi
import starlette.responses
import uvicorn
import sources
import models
import database
import sqlite3

from starlette import status

backendApp = fastapi.FastAPI()
database_connection = sqlite3.connect("base.db")
connection_cursor = database_connection.cursor()


@backendApp.get("/")
async def easterEgg() -> str:
    return sources.easterEggText


@backendApp.post("/register")
async def register(nickname: str,
                   name: str,
                   surname: str,
                   email: str,
                   phone_number: str,
                   telegram: str,
                   password_hash: str) -> starlette.responses.Response:
    print("received")
    userCreateRequest = models.UserCreateRequest()
    userCreateRequest.nickname = nickname
    userCreateRequest.name = name
    userCreateRequest.surname = surname
    userCreateRequest.email = email
    userCreateRequest.phone_number = phone_number
    userCreateRequest.telegram = telegram
    userCreateRequest.password_hash = password_hash
    try:
        user_data = database.Users.insertNewUser(userCreateRequest, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK, content=str(user_data))


@backendApp.get("/loginByNickname")
async def login(nickname: str, password_hash: str) -> starlette.responses.Response:
    loginRequest = models.LoginRequest(nickname, password_hash)
    try:
        assertion: dict[str, typing.Any] = database.Users.checkPassword(loginRequest, connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK, content=json.dumps(assertion))


@backendApp.get("/userPublicInformationById")
async def userPublicInformationById(user_id: int = 0) -> starlette.responses.Response:
    print("received")
    try:
        user_data: dict = database.Users.publicUserInformationById(user_id, connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK, content=json.dumps(user_data))


@backendApp.get("/userContactInformationById")
async def userContactInformationById(contact_user_id: int = 0) -> starlette.responses.Response:
    try:
        user_data: dict = database.Users.contactUserInformationById(contact_user_id, connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK, content=json.dumps(user_data))


@backendApp.post("/registerNewTicket")
async def registerNewTicket(shopper_id: str,
                            shopper_token: str,
                            title: str,
                            reward: str = "0",
                            description: str = "",
                            weight: str = "0",
                            latitude: str = "0",
                            longitude: str = "0",
                            token_image: str = "",
                            product_type: str = "",
                            deadline_unix_time: str = "0") -> starlette.responses.Response:
    shopper_id = int(shopper_id)
    reward = float(reward.replace(',', '.'))
    weight = float(weight.replace(',', '.'))
    latitude = float(latitude.replace(',', '.'))
    longitude = float(longitude.replace(',', '.'))
    deadline_unix_time = int(deadline_unix_time)

    try:
        database.Users.checkTokenSignature(shopper_id, shopper_token, connection_cursor)
        ticket_data: dict = database.Tickets.createNewTicket(shopper_id, title, reward, shopper_token,
                                                             connection_cursor)
        unnecessary_properties_names_in_database: list[str] = ["description",
                                                               "weight",
                                                               "latitude",
                                                               "longitude",
                                                               "token_image",
                                                               "product_type",
                                                               "deadline_unix_time"]
        unnecessary_properties = [description, weight, latitude, longitude, token_image,
                                  product_type, deadline_unix_time]
        ticket_id: int = ticket_data['ticket_id']
        for i in range(len(unnecessary_properties)):
            prop = unnecessary_properties[i]
            prop_name = unnecessary_properties_names_in_database[i]
            database.Tickets.updatePropertyOfTicket(ticket_id, shopper_id, prop_name, prop, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())

    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(
                                            database.Tickets.getTicketInformationById(ticket_id,
                                                                                      connection_cursor))
                                        )


@backendApp.get('/getTicketInfo')
async def getTicketInfo(ticket_id: int) -> starlette.responses.Response:
    try:
        ticket_info: dict[str, typing.Union[str, int, float]] = \
            database.Tickets.getTicketInformationById(ticket_id, connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=ticket_info)


@backendApp.get('/nickExists')
async def nickExists(user_nickname: str) -> starlette.responses.Response:
    print("REVEICED RESPONSE WITH", user_nickname)
    try:
        user_info: dict[str, typing.Union[str, int]] = database.Users.nickExists(user_nickname, connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    print(user_info)
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK, content=str(user_info))


@backendApp.get('/contactDataOccupied')
async def contactDataOccupied(user_nickname: str, user_phone_number: str,
                              user_telegram: str, user_email: str) -> starlette.responses.Response:
    try:
        user_data = database.Users.contactDataIsOccupied(user_nickname, user_phone_number, user_telegram,
                                                         user_email, connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=str(user_data))


@backendApp.post('/updateContactInformation')
async def updateContactInformation(user_id: int,
                                   user_token: str,
                                   email: str,
                                   telegram: str) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(user_id, user_token, connection_cursor)
        database.Users.updateContactInformation(user_id, email, telegram, connection_cursor)
        return_data = database.Users.contactUserInformationById(user_id, connection_cursor)
        database_connection.commit()

    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(return_data))




@backendApp.get('/getTicketsForUser')
async def getTicketsForUser(user_id: int, user_token: str) -> starlette.responses.Response:
    try:
        return_data = database.Tickets.getListOfTicketsForUser(user_id, user_token, connection_cursor)
    except Exception:
        print(traceback.format_exc())
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=str(return_data))


@backendApp.get('/getTicketHistory')
async def getTicketsFromHistory(user_id: int,
                                user_token: str,
                                ticket_states: int,  # 0 - waiting for accept, 1 - in progress, 2 - completed
                                from_angel: int  # 0 - list of tickets from shopper view, 1 - from angel view
                                ) -> starlette.responses.Response:
    # print(user_id, user_token, ticket_states, from_angel)
    try:
        return_data = database.Tickets.getTicketsFromHistory(user_id,
                                                             user_token,
                                                             ticket_states,
                                                             from_angel,
                                                             connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(return_data))


@backendApp.post('/bookTicket')
async def bookTicket(ticket_id: int, angel_id: int, angel_token: str) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(angel_id, angel_token, connection_cursor)
        return_data = database.Tickets.bookTicket(ticket_id, angel_id, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(return_data))


@backendApp.post('/cancelBookOfTicket')
async def cancelBookOfTicket(ticket_id: int, angel_id: int, angel_token: str) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(angel_id, angel_token, connection_cursor)
        if database.Tickets.getTicketInformationById(ticket_id, connection_cursor)['angel_id'] != angel_id:
            raise ValueError
        return_data = database.Tickets.cancelBookOfTicket(ticket_id, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(return_data))


@backendApp.post('/completeOrder')
async def completeOrder(ticket_id: int, shopper_id: int, shopper_token: str) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(shopper_id, shopper_token, connection_cursor)
        if database.Tickets.getTicketInformationById(ticket_id, connection_cursor)['shopper_id'] != shopper_id:
            raise ValueError
        return_data = database.Tickets.completeOrder(ticket_id, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(return_data))


@backendApp.post('/sendOfferToBookTicket')
async def sendOfferToBookTicket(angel_id: int,
                                angel_token: str,
                                ticket_id: int) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(angel_id, angel_token, connection_cursor)
        data = database.Offers.sendOfferToBookTicket(angel_id, ticket_id, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(data))


@backendApp.get('/getOffersByTicketId')
async def getOffersByTicketId(ticket_id: int, shopper_id: int, shopper_token: str) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(shopper_id, shopper_token, connection_cursor)
        database.Tickets.checkAccessToTicketEdition(ticket_id, shopper_id, connection_cursor)
        return_data = database.Offers.getOffersByTicketId(ticket_id, connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(return_data))


@backendApp.post("/acceptOffer")
async def acceptOffer(offer_id: int, shopper_id: int, shopper_token: str) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(shopper_id, shopper_token, connection_cursor)
        database.Offers.acceptOffer(offer_id, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content="OK")


@backendApp.get('/getOfferedTickets')
async def getOfferedTickets(angel_id: int, angel_token: str) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(angel_id, angel_token, connection_cursor)
        return_data = database.Offers.getOfferedTickets(angel_id, connection_cursor)
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps(return_data))


@backendApp.post('/cancelOffer')
async def cancelOffer(angel_id: int, angel_token: str, ticket_id: int) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(angel_id, angel_token, connection_cursor)
        database.Offers.cancelOffer(angel_id, ticket_id, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps({"result": "OK"}))


@backendApp.post('/cancelOrder')
async def cancelOrder(shopper_id: int, shopper_token: str, ticket_id: int) -> starlette.responses.Response:
    try:
        database.Users.checkTokenSignature(shopper_id, shopper_token, connection_cursor)
        database.Tickets.checkAccessToTicketEdition(ticket_id, shopper_id, connection_cursor)
        database.Tickets.cancelOrder(ticket_id, connection_cursor)
        database_connection.commit()
    except Exception:
        return starlette.responses.Response(status_code=starlette.status.HTTP_500_INTERNAL_SERVER_ERROR,
                                            content=traceback.format_exc())
    return starlette.responses.Response(status_code=starlette.status.HTTP_200_OK,
                                        content=json.dumps({"result": "OK"}))
