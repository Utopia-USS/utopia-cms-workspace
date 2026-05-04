class CmsSupabaseTable {
  final String name;
  final String? schema;

  const CmsSupabaseTable(this.name, {this.schema});

  String get fullName => schema != null ? '$schema.$name' : name;
}

class CmsSupabaseDataTable extends CmsSupabaseTable {
  final String idKey;

  const CmsSupabaseDataTable(super.name, {this.idKey = 'id', super.schema});
}

class CmsSupabaseAssociationTable extends CmsSupabaseTable {
  final CmsSupabaseDataTable originTable, foreignTable;
  final String originKey, foreignKey;

  const CmsSupabaseAssociationTable(
    super.name, {
    required this.originTable,
    required this.foreignTable,
    required this.originKey,
    required this.foreignKey,
    super.schema,
  });

  CmsSupabaseAssociationTable get reversed {
    return CmsSupabaseAssociationTable(
      name,
      originTable: foreignTable,
      foreignTable: originTable,
      originKey: foreignKey,
      foreignKey: originKey,
      schema: schema,
    );
  }
}
