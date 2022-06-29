import time
import random
import sqlite3
import typing

import models


class UnauthorizedTokenException(Exception):
    pass


class Users:

    @staticmethod
    def insertNewUser(user_data: models.UserCreateRequest, cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        try:
            print(user_data.name, user_data.surname)
            sql_request = f"""INSERT INTO users (nickname, name, surname, email, 
                phone_number, telegram, password_hash, token) VALUES \
                ('{user_data.nickname}','{user_data.name}','{user_data.surname}',\
                '{user_data.email}','{user_data.phone_number}','{user_data.telegram}','{user_data.password_hash}',
                '{Users.__generateToken__()}')"""
            cursor.execute(sql_request)
            sql_request = f"""SELECT * FROM USERS WHERE nickname = '{user_data.nickname}'"""
            cursor.execute(sql_request)
            data = cursor.fetchone()
            return {
                "user_id": data[0],
                "nickname": data[1],
                "name": data[2],
                "surname": data[3],
                "email": data[4],
                "phone_number": data[5],
                "telegram": data[6],
                "profile_image": data[7],
                "password_hash": data[8],
                "token": data[9],
                "rating": data[10],
                "tickets_amount": data[11]
            }
        except Exception:
            pass

    @staticmethod
    def checkPassword(user_data: models.LoginRequest, cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        sql_request: str = f"SELECT * FROM users WHERE nickname='{user_data.nickname}'"
        cursor.execute(sql_request)
        data = cursor.fetchone()
        print(data)
        if user_data.password_hash == data[8]:
            token: str = Users.__generateToken__()
            sql_request: str = f"UPDATE users SET token='{token}' WHERE nickname='{user_data.nickname}'"
            cursor.execute(sql_request)
            return {
                "user_id": data[0],
                "nickname": data[1],
                "name": data[2],
                "surname": data[3],
                "email": data[4],
                "phone_number": data[5],
                "telegram": data[6],
                "profile_image": data[7],
                "password_hash": data[8],
                "token": token,
                "rating": data[10],
                "tickets_amount": data[11]
            }
        raise ValueError

    @staticmethod
    def __generateToken__() -> str:
        return ''.join([chr(random.randint(65, 90)) for i in range(32)])

    @staticmethod
    def userInformationById(user_id: int, cursor: sqlite3.Cursor) -> dict:
        sql_request: str = f"""SELECT * FROM users WHERE user_id={user_id}"""
        cursor.execute(sql_request)
        data = cursor.fetchone()
        return data

    @staticmethod
    def publicUserInformationById(user_id: int, cursor: sqlite3.Cursor) -> dict:
        data = Users.userInformationById(user_id, cursor)
        return {"user_id": data[0],
                "nickname": data[1],
                "name": data[2],
                "surname": data[3],
                "profile_image": data[7],
                "rating": data[10]}

    @staticmethod
    def checkTokenSignature(user_id: int, token: str, cursor) -> bool:
        sql_request: str = f"SELECT token FROM users WHERE user_id={user_id}"
        cursor.execute(sql_request)
        token_from_database: str = cursor.fetchone()[0]
        print(token_from_database, token)
        assert token_from_database == token

    @staticmethod
    def contactUserInformationById(user_id: int, requester_id: int, requester_token: str,
                                   cursor: sqlite3.Cursor, ) -> dict:
        assert Users.checkTokenSignature(requester_id, requester_token, cursor)
        assert Users.__checkAccessToContactInformation__(user_id, requester_id, cursor)
        data = Users.userInformationById(user_id, cursor)
        return {
            "user_id": data[0],
            "nickname": data[1],
            "name": data[2],
            "surname": data[3],
            "email": data[4],
            "phone_number": data[5],
            "telegram": data[6],
            "profile_image": data[7],
            "rating": data[10]
        }

    @staticmethod
    def nickExists(user_nickname: str, cursor: sqlite3.Cursor) -> dict[str, typing.Union[str, int]]:
        sql_request: str = f'SELECT * FROM USERS WHERE nickname="{user_nickname}"'
        cursor.execute(sql_request)
        return {
            "nick": user_nickname,
            "exists": cursor.fetchone() is not None
        }

    @staticmethod
    def contactDataIsOccupied(user_nickname: str, user_phone_number: str,
                              user_telegram: str, user_email: str, cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        sql_request: str = f'SELECT * FROM users WHERE nickname="{user_nickname}" OR ' \
                           f'phone_number="{user_phone_number}" OR telegram="{user_telegram}" OR email="{user_email}"'
        cursor.execute(sql_request)
        data: tuple[typing.Any] = cursor.fetchone()
        template = {
            "user_nickname": user_nickname,
            "user_phone_number": user_phone_number,
            "user_telegram": user_telegram,
            "user_email": user_email,
            "occupied": 1
        }
        user_info: dict[str, typing.Any] = dict()
        if data is not None:
            user_info = {
                "user_id": data[0],
                "nickname": data[1],
                "name": data[2],
                "surname": data[3],
                "email": data[4],
                "phone_number": data[5],
                "telegram": data[6],
                "profile_image": data[7],
                "rating": data[10]
            }
            template['user_info'] = user_info
            template['occupied'] = 1
            return template
        template['occupied'] = 0
        return template

    @staticmethod
    def __checkAccessToContactInformation__(user_id: int, requester_id: int,
                                            cursor: sqlite3.Cursor) -> bool:
        sql_request_1 = f"SELECT * FROM tickets WHERE angel_id={user_id} AND shopper_id={requester_id} OR " \
                        f"angel_id={requester_id} AND shopper_id={user_id}"
        cursor.execute(sql_request_1)
        return cursor.fetchone() is not None


class Tickets:

    @staticmethod
    def createNewTicket(shopper_id: int, title: str, reward: float, token: str,
                        cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        time_of_reqeust: int = int(time.time())
        sql_request_to_push_ticket: str = f"INSERT INTO tickets (shopper_id, title, creation_unix_time, " \
                                          f"reward, status) " \
                                          f"VALUES" \
                                          f"({shopper_id}, '{title}', {time_of_reqeust}, {reward}, 0)"
        cursor.execute(sql_request_to_push_ticket)
        sql_request_to_get_ticket_id: str = f"SELECT * FROM tickets WHERE shopper_id = {shopper_id} AND " \
                                            f"creation_unix_time = {time_of_reqeust}"
        cursor.execute(sql_request_to_get_ticket_id)
        data = cursor.fetchone()
        return {
            "ticket_id": data[0],
            "shopper_id": data[1],
            "title": data[3],
            "creation_unix_time": data[11],
            "reward": data[13]
        }

    @staticmethod
    def checkAccessToTicketEdition(ticket_id: int, shopper_id: int, cursor: sqlite3.Cursor) -> bool:
        sql_request_to_check: str = f"SELECT * FROM tickets WHERE ticket_id = {ticket_id}"
        cursor.execute(sql_request_to_check)
        return cursor.fetchone()[1] == shopper_id

    @staticmethod
    def updatePropertyOfTicket(ticket_id: int, shopper_id: int, property_name: str,
                               property_value: typing.Union[int, str, float],
                               cursor: sqlite3.Cursor) -> dict[str, typing.Union[str, float, int]]:
        assert Tickets.checkAccessToTicketEdition(ticket_id, shopper_id, cursor)
        if type(property_value) == str:
            sql_request: str = f"UPDATE tickets SET {property_name} = '{property_value}' WHERE ticket_id = {ticket_id}"
        else:
            sql_request: str = f"UPDATE tickets SET {property_name} = {property_value} WHERE ticket_id = {ticket_id}"
        cursor.execute(sql_request)
        return Tickets.getTicketInformationById(ticket_id, cursor)

    @staticmethod
    def getTicketInformationById(ticket_id: int, cursor: sqlite3.Cursor) -> dict[str, typing.Union[str, float, int]]:
        cursor.execute(
            f"SELECT * FROM tickets WHERE ticket_id={ticket_id}"
        )
        data = cursor.fetchone()
        return {
            "ticket_id": data[0],
            "shopper_id": data[1],
            "angel_id": data[2],
            "title": data[3],
            "description": data[4],
            "weight": data[5],
            "latitude": data[6],
            "longitude": data[7],
            "token_image": data[8],
            "type": data[9],
            "deadline_unix_time": data[10],
            "creation_unix_time": data[11],
            "status": data[12],
            "reward": data[13]
        }

    @staticmethod
    def getTicketInformationWithUser(ticket_id: int,
                                     cursor: sqlite3.Cursor) -> dict[str, typing.Union[str, int, float]]:
        pass

    @staticmethod
    def getListOfTicketsForUser(user_id: int, user_token: str,
                                cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        Users.checkTokenSignature(user_id, user_token, cursor)
        sql_request = f"SELECT * FROM tickets WHERE shopper_id != {user_id} AND status = 0 ORDER BY creation_unix_time"
        cursor.execute(sql_request)
        return_data: dict[str, list[dict[str, typing.Any]]] = {"tickets": []}
        while True:
            data = cursor.fetchone()
            if data is None:
                break
            return_data['tickets'].append(
                {
                    "ticket_id": data[0],
                    "shopper_id": data[1],
                    "angel_id": data[2],
                    "title": data[3],
                    "description": data[4],
                    "weight": data[5],
                    "latitude": data[6],
                    "longitude": data[7],
                    "token_image": data[8],
                    "type": data[9],
                    "deadline_unix_time": data[10],
                    "creation_unix_time": data[11],
                    "status": data[12],
                    "reward": data[13],
                }
            )
        for ticket in return_data['tickets']:
            shopper_info = Users.publicUserInformationById(ticket['shopper_id'], cursor)
            ticket['shopper_info'] = shopper_info
        print(return_data)
        return return_data

    @staticmethod
    def getTicketsFromHistory(user_id: int, user_token: str,
                              ticket_status: int, from_angel: int,
                              cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        Users.checkTokenSignature(user_id, user_token, cursor)
        column_title = {0: 'shopper_id', 1: 'angel_id'}[from_angel]
        sql_request_template = f"SELECT * FROM tickets WHERE {column_title} = {user_id} AND status={ticket_status}"
        cursor.execute(sql_request_template)
        return_data = {"tickets": []}
        while True:
            data = cursor.fetchone()
            if data is None:
                break
            return_data['tickets'].append(
                {
                    "ticket_id": data[0],
                    "shopper_id": data[1],
                    "angel_id": data[2],
                    "title": data[3],
                    "description": data[4],
                    "weight": data[5],
                    "latitude": data[6],
                    "longitude": data[7],
                    "token_image": data[8],
                    "type": data[9],
                    "deadline_unix_time": data[10],
                    "creation_unix_time": data[11],
                    "status": data[12],
                    "reward": data[13],
                }
            )
        for ticket in return_data['tickets']:
            shopper_info = Users.publicUserInformationById(ticket['shopper_id'], cursor)
            ticket['shopper_info'] = shopper_info
        print(return_data)
        return return_data

    # METHOD WILL BE OVERWRITTEN IN MVP V2
    @staticmethod
    def bookTicket(ticket_id: int, shopper_id: int,
                   cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        sql_request = f"UPDATE tickets SET angel_id={shopper_id}, status=1 WHERE ticket_id={ticket_id}"
        cursor.execute(sql_request)
        print("STATUS OF TICKET HAS BEEN UPDATED")
        return Tickets.getTicketInformationById(ticket_id, cursor)

    @staticmethod
    def cancelBookOfTicket(ticket_id: int, cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        sql_request = f"UPDATE tickets SET angel_id=NULL, status=0 WHERE ticket_id={ticket_id}"
        cursor.execute(sql_request)
        print('CANCELLING OF BOOKING WAS SUCCESSFUL')
        return Tickets.getTicketInformationById(ticket_id, cursor)

    @staticmethod
    def completeOrder(ticket_id: int, cursor: sqlite3.Cursor) -> dict[str, typing.Any]:
        sql_request = f"UPDATE tickets SET status=2 WHERE ticket_id={ticket_id}"
        cursor.execute(sql_request)
        print("COMPLETE OF ORDER WAS SUCCESSFUL")
        return Tickets.getTicketInformationById(ticket_id, cursor)


class Offers:

    @staticmethod
    def sendOfferToBookTicket(angel_id, ticket_id, cursor: sqlite3.Cursor) -> dict[str, int]:
        if Offers.offerIsUnique(angel_id, ticket_id, cursor):
            sql_request = f"INSERT INTO offers(ticket_id, angel_id, creation_unix_time) " \
                          f"VALUES ({ticket_id}, {angel_id}, {int(time.time())})"
            cursor.execute(sql_request)
        sql_request = f"SELECT * FROM offers WHERE angel_id={angel_id} and ticket_id={ticket_id}"
        cursor.execute(sql_request)
        data = cursor.fetchone()
        return {
            "offer_id": data[0],
            "ticket_id": data[1],
            "angel_id": data[2],
            "creation_unix_time": data[3]
        }

    @staticmethod
    def offerIsUnique(angel_id: int, ticket_id: int,
                      cursor: sqlite3.Cursor) -> bool:
        sql_request = f"SELECT * FROM offers WHERE angel_id={angel_id} AND ticket_id={ticket_id}"
        cursor.execute(sql_request)
        return cursor.fetchone() is None

