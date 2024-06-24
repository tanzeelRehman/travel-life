//This can be used for /autocomplete, /search and /reverse
class GetGeocodeResponseModel {
  String? type;
  List<Features>?
      features; //these are all of the matches (possible locations) that we get if we query with any tex

  GetGeocodeResponseModel({this.type, this.features});

  GetGeocodeResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['features'] != null) {
      features = <Features>[];

      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? type;
  Geometry? geometry;
  Properties? properties;
  List<double>?
      bbox; // [min_lon, min_lat, max_lon, max_lat] (area of the match)

  Features({this.type, this.geometry, this.properties, this.bbox});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;

    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    if (json['bbox'] != null) {
      bbox = json['bbox'].cast<double>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    data['bbox'] = this.bbox;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates; // [longitude, latitude]

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

// _a means alias of a country, region, locality etc.
// _gid is kinda like a unique id but it should not be treate or used as an unique identifier, it can be used with /place endpoint in order to get a specific place info
// label is a formated address of the place
// county: official governmental area; usually bigger than a locality, almost always smaller than a region
// https://github.com/pelias/documentation/blob/master/autocomplete.md //complete documentation to know more about the fields

class Properties {
  String? id;
  String? gid;
  String? layer;
  String? source;
  String? sourceId;
  String? name;
  String? accuracy;
  String? country;
  String? countryGid;
  String? countryA;
  String? region;
  String? regionGid;
  String? regionA;
  String? county;
  String? countyGid;
  String? locality;
  String? localityGid;
  String? continent;
  String? continentGid;
  String? label;
  Addendum? addendum;
  String? countyA;
  String? housenumber;
  String? street;
  String? postalcode;
  String? localadmin;
  String? localadminGid;
  String? macrocounty;
  String? macrocountyGid;
  String? macroregion;
  String? macroregionGid;
  String? neighbourhood;
  String? neighbourhoodGid;

  Properties(
      {this.id,
      this.gid,
      this.layer,
      this.source,
      this.sourceId,
      this.name,
      this.accuracy,
      this.country,
      this.countryGid,
      this.countryA,
      this.region,
      this.regionGid,
      this.regionA,
      this.county,
      this.countyGid,
      this.locality,
      this.localityGid,
      this.continent,
      this.continentGid,
      this.label,
      this.addendum,
      this.countyA,
      this.housenumber,
      this.street,
      this.postalcode,
      this.localadmin,
      this.localadminGid,
      this.macrocounty,
      this.macrocountyGid,
      this.macroregion,
      this.macroregionGid,
      this.neighbourhood,
      this.neighbourhoodGid});

  Properties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gid = json['gid'];
    layer = json['layer'];
    source = json['source'];
    sourceId = json['source_id'];
    name = json['name'];
    accuracy = json['accuracy'];
    country = json['country'];
    countryGid = json['country_gid'];
    countryA = json['country_a'];
    region = json['region'];
    regionGid = json['region_gid'];
    regionA = json['region_a'];
    county = json['county'];
    countyGid = json['county_gid'];
    locality = json['locality'];
    localityGid = json['locality_gid'];
    continent = json['continent'];
    continentGid = json['continent_gid'];
    label = json['label'];
    addendum = json['addendum'] != null
        ? new Addendum.fromJson(json['addendum'])
        : null;
    countyA = json['county_a'];
    housenumber = json['housenumber'];
    street = json['street'];
    postalcode = json['postalcode'];
    localadmin = json['localadmin'];
    localadminGid = json['localadmin_gid'];
    macrocounty = json['macrocounty'];
    macrocountyGid = json['macrocounty_gid'];
    macroregion = json['macroregion'];
    macroregionGid = json['macroregion_gid'];
    neighbourhood = json['neighbourhood'];
    neighbourhoodGid = json['neighbourhood_gid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gid'] = this.gid;
    data['layer'] = this.layer;
    data['source'] = this.source;
    data['source_id'] = this.sourceId;
    data['name'] = this.name;
    data['accuracy'] = this.accuracy;
    data['country'] = this.country;
    data['country_gid'] = this.countryGid;
    data['country_a'] = this.countryA;
    data['region'] = this.region;
    data['region_gid'] = this.regionGid;
    data['region_a'] = this.regionA;
    data['county'] = this.county;
    data['county_gid'] = this.countyGid;
    data['locality'] = this.locality;
    data['locality_gid'] = this.localityGid;
    data['continent'] = this.continent;
    data['continent_gid'] = this.continentGid;
    data['label'] = this.label;
    if (this.addendum != null) {
      data['addendum'] = this.addendum!.toJson();
    }
    data['county_a'] = this.countyA;
    data['housenumber'] = this.housenumber;
    data['street'] = this.street;
    data['postalcode'] = this.postalcode;
    data['localadmin'] = this.localadmin;
    data['localadmin_gid'] = this.localadminGid;
    data['macrocounty'] = this.macrocounty;
    data['macrocounty_gid'] = this.macrocountyGid;
    data['macroregion'] = this.macroregion;
    data['macroregion_gid'] = this.macroregionGid;
    data['neighbourhood'] = this.neighbourhood;
    data['neighbourhood_gid'] = this.neighbourhoodGid;
    return data;
  }
}

class Addendum {
  Concordances? concordances;
  Osm? osm;

  Addendum({this.concordances, this.osm});

  Addendum.fromJson(Map<String, dynamic> json) {
    concordances = json['concordances'] != null
        ? new Concordances.fromJson(json['concordances'])
        : null;
    osm = json['osm'] != null ? new Osm.fromJson(json['osm']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.concordances != null) {
      data['concordances'] = this.concordances!.toJson();
    }
    if (this.osm != null) {
      data['osm'] = this.osm!.toJson();
    }
    return data;
  }
}

class Concordances {
  int? gnId;
  int? gpId;
  int? qsPgId;
  String? wdId;
  String? wkPage;

  Concordances({this.gnId, this.gpId, this.qsPgId, this.wdId, this.wkPage});

  Concordances.fromJson(Map<String, dynamic> json) {
    gnId = json['gn:id'];
    gpId = json['gp:id'];
    qsPgId = json['qs_pg:id'];
    wdId = json['wd:id'];
    wkPage = json['wk:page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gn:id'] = this.gnId;
    data['gp:id'] = this.gpId;
    data['qs_pg:id'] = this.qsPgId;
    data['wd:id'] = this.wdId;
    data['wk:page'] = this.wkPage;
    return data;
  }
}

//if the location is a business then we can also get this info from osm (addendum > osm)
class Osm {
  String? wikidata;
  String? wikipedia;
  String? operator;
  String? website;
  String? phone;
  String? openingHours;

  Osm(
      {this.wikidata,
      this.wikipedia,
      this.operator,
      this.website,
      this.phone,
      this.openingHours});

  Osm.fromJson(Map<String, dynamic> json) {
    wikidata = json['wikidata'];
    wikipedia = json['wikipedia'];
    operator = json['operator'];
    website = json['website'];
    phone = json['phone'];
    openingHours = json['opening_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wikidata'] = this.wikidata;
    data['wikipedia'] = this.wikipedia;
    data['operator'] = this.operator;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['opening_hours'] = this.openingHours;
    return data;
  }
}
