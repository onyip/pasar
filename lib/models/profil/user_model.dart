// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.status,
        this.code,
        this.message,
        this.data,
    });

    bool status;
    String code;
    String message;
    Data data;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
        this.userFullname,
        this.email,
        this.phone,
        this.photo,
        this.latitude,
        this.longitude,
        this.location,
        this.rating,
    });

    String userId;
    String userFullname;
    String email;
    String phone;
    String photo;
    double latitude;
    double longitude;
    String location;
    dynamic rating;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"] == null ? null : json["user_id"],
        userFullname: json["user_fullname"] == null ? null : json["user_fullname"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        photo: json["photo"] == null ? null : json["photo"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        location: json["location"] == null ? null : json["location"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "user_fullname": userFullname == null ? null : userFullname,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "photo": photo == null ? null : photo,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "location": location == null ? null : location,
        "rating": rating,
    };
}
