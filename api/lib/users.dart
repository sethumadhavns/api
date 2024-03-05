// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';
import 'dart:core';


Users usersFromJson(String str) {
    final jsonData = json.decode(str);
    return Users.fromJson(jsonData);
}

String usersToJson(Users data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class Users {
    List<Datum>? data;
    List<Source>? source;

    Users({
        this.data,
        this.source,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        source: List<Source>.from(json["source"].map((x) => Source.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "source": List<dynamic>.from(source!.map((x) => x.toJson())),
    };
}

class Datum {
    String? idNation;
    String? nation;
    int? idYear;
    String? year;
    int? population;
    String? slugNation;

    Datum({
        this.idNation,
        this.nation,
        this.idYear,
        this.year,
        this.population,
        this.slugNation,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idNation: json["ID Nation"],
        nation: json["Nation"],
        idYear: json["ID Year"],
        year: json["Year"],
        population: json["Population"],
        slugNation: json["Slug Nation"],
    );

    Map<String, dynamic> toJson() => {
        "ID Nation": idNation,
        "Nation": nation,
        "ID Year": idYear,
        "Year": year,
        "Population": population,
        "Slug Nation": slugNation,
    };
}

class Source {
    List<String>? measures;
    Annotations? annotations;
    String? name;
    List<dynamic>? substitutions;

    Source({
        this.measures,
        this.annotations,
        this.name,
        this.substitutions,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        measures: List<String>.from(json["measures"].map((x) => x)),
        annotations: Annotations.fromJson(json["annotations"]),
        name: json["name"],
        substitutions: List<dynamic>.from(json["substitutions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "measures": List<dynamic>.from(measures!.map((x) => x)),
        "annotations": annotations!.toJson(),
        "name": name,
        "substitutions": List<dynamic>.from(substitutions!.map((x) => x)),
    };
}

class Annotations {
    String? sourceName;
    String? sourceDescription;
    String? datasetName;
    String? datasetLink;
    String? tableId;
    String? topic;
    String? subtopic;

    Annotations({
        this.sourceName,
        this.sourceDescription,
        this.datasetName,
        this.datasetLink,
        this.tableId,
        this.topic,
        this.subtopic,
    });

    factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
        sourceName: json["source_name"],
        sourceDescription: json["source_description"],
        datasetName: json["dataset_name"],
        datasetLink: json["dataset_link"],
        tableId: json["table_id"],
        topic: json["topic"],
        subtopic: json["subtopic"],
    );

    Map<String, dynamic> toJson() => {
        "source_name": sourceName,
        "source_description": sourceDescription,
        "dataset_name": datasetName,
        "dataset_link": datasetLink,
        "table_id": tableId,
        "topic": topic,
        "subtopic": subtopic,
    };
}
