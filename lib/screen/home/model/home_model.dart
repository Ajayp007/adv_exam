class JokesModel {
  String? created_at, icon_url, updated_at, url, value;

  JokesModel(
      {this.created_at, this.icon_url, this.updated_at, this.url, this.value});

  factory JokesModel.mapToModel(Map m1) {
    return JokesModel(
        created_at: m1['created_at'],
        icon_url: m1['icon_url'],
        updated_at: m1['updated_at'],
        url: m1['url'],
        value: m1['value']);
  }
}
