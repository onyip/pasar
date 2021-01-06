// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    String code;
    String message;
    Data data;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.userId,
        this.email,
        this.accessToken,
        this.type,
        this.expiredIn,
    });

    String userId;
    String email;
    String accessToken;
    String type;
    String expiredIn;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"] == null ? null : json["user_id"],
        email: json["email"] == null ? null : json["email"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
        type: json["type"] == null ? null : json["type"],
        expiredIn: json["expired_in"] == null ? null : json["expired_in"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "email": email == null ? null : email,
        "access_token": accessToken == null ? null : accessToken,
        "type": type == null ? null : type,
        "expired_in": expiredIn == null ? null : expiredIn,
    };
}
