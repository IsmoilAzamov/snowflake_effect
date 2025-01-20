import 'package:hive/hive.dart';

part 'type_entity.g.dart';

@HiveType(typeId: 1)
class TypeEntity {
  @HiveField(0)
  bool? isGroup;
  @HiveField(1)
  int? parentId;
  @HiveField(2)
  int? value;
  @HiveField(3)
  String? text;
  @HiveField(4)
  String? orderCode;

  TypeEntity({
    this.isGroup,
    this.parentId,
    this.value,
    this.text,
    this.orderCode,
  });

  factory TypeEntity.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('value')) {
      if (json['value'] is int) {
        return TypeEntity(
          isGroup: json['isGroup'],
          parentId: json['parentId'],
          value: json['value'],
          text: json['text'],
          orderCode: json['orderCode'],
        );
      }
    }
    return TypeEntity(
      isGroup: json['isGroup'],
      parentId: json['parentId'],
      value: null,
      text: json['text'],
      orderCode: json['orderCode'],
    );
  }

  Map<String, dynamic> toJson() => {
        'isGroup': isGroup,
        'parentId': parentId,
        'value': value,
        'text': text,
        'orderCode': orderCode,
      };
}
