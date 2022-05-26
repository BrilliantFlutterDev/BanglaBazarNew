class AllowedVendorStatesResponse {
  AllowedVendorStatesResponse({
    required this.status,
    required this.states,
  });
  late final bool status;
  late final List<States> states;

  AllowedVendorStatesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    states = List.from(json['States']).map((e) => States.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['States'] = states.map((e) => e.toJson()).toList();
    return _data;
  }
}

class States {
  States({
    required this.StateID,
    required this.CountryID,
    required this.State,
    required this.Native,
    required this.StateCode,
    required this.VATTaxRate,
    required this.FlatDeliveryRate,
    required this.FlatDeliveryRateKilo,
    required this.Active,
    this.LastUpdate,
    required this.AdminNote,
  });
  late final int StateID;
  late final int CountryID;
  late final String State;
  late final String Native;
  late final String StateCode;
  late final String VATTaxRate;
  late final String FlatDeliveryRate;
  late final String FlatDeliveryRateKilo;
  late final String Active;
  late final Null LastUpdate;
  late final String AdminNote;

  States.fromJson(Map<String, dynamic> json) {
    StateID = json['StateID'];
    CountryID = json['CountryID'];
    State = json['State'];
    Native = json['Native'];
    StateCode = json['StateCode'];
    VATTaxRate = json['VATTaxRate'];
    FlatDeliveryRate = json['FlatDeliveryRate'];
    FlatDeliveryRateKilo = json['FlatDeliveryRateKilo'];
    Active = json['Active'];
    LastUpdate = null;
    AdminNote = json['AdminNote'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StateID'] = StateID;
    _data['CountryID'] = CountryID;
    _data['State'] = State;
    _data['Native'] = Native;
    _data['StateCode'] = StateCode;
    _data['VATTaxRate'] = VATTaxRate;
    _data['FlatDeliveryRate'] = FlatDeliveryRate;
    _data['FlatDeliveryRateKilo'] = FlatDeliveryRateKilo;
    _data['Active'] = Active;
    _data['LastUpdate'] = LastUpdate;
    _data['AdminNote'] = AdminNote;
    return _data;
  }
}
