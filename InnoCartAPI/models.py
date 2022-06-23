from pydantic import BaseModel


class UserCreateRequest:
    nickname: str
    name: str
    surname: str
    email: str
    phone_number: str
    telegram: str
    password_hash: str

    def __init__(self):
        pass


class LoginRequest:
    nickname: str
    password_hash: str

    def __init__(self, nickname, password_hash):
        self.nickname = nickname
        self.password_hash = password_hash

