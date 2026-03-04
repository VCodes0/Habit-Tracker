// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailySummaryAdapter extends TypeAdapter<DailySummary> {
  @override
  final int typeId = 1;

  @override
  DailySummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailySummary(
      date: fields[0] as String,
      completionPercentage: fields[1] as double,
      totalHabits: fields[2] as int,
      completedHabits: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DailySummary obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.completionPercentage)
      ..writeByte(2)
      ..write(obj.totalHabits)
      ..writeByte(3)
      ..write(obj.completedHabits);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailySummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
