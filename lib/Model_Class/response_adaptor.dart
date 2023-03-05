import 'package:hive/hive.dart';
import 'hive_model.dart';

class ResponseDataAdapter extends TypeAdapter<ResponseData> {
  @override
  final typeId = 0;

  @override
  ResponseData read(BinaryReader reader) {
    return ResponseData(
      id: reader.read(),
      title: reader.read(),
      description: reader.read(),
      dueDate: reader.read(),
      project: reader.read(),
      reporter: reader.read(),
      fileUrl: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, ResponseData obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.dueDate);
    writer.write(obj.project);
    writer.write(obj.reporter);
    writer.write(obj.fileUrl);
  }
}
