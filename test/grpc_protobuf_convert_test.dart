import 'package:fixnum/fixnum.dart';
import 'package:grpc_googleapis/google/protobuf.dart' as pb;
import 'package:grpc_protobuf_convert/grpc_protobuf_convert.dart';
import 'package:test/test.dart';

void main() {
  test('fromDuration', () {
    var duration = GrpcProtobufConvert.fromDuration(
      pb.Duration(
        nanos: 2000,
        seconds: GrpcProtobufConvert.toInt64(30),
      ),
    );

    expect(duration.inSeconds, 30);
    expect(duration.inMilliseconds, 30002);
  });

  test('fromTimestamp', () {
    var date = GrpcProtobufConvert.fromTimestamp(
      pb.Timestamp(
        nanos: 2000,
        seconds: GrpcProtobufConvert.toInt64(30),
      ),
    );

    expect(date.millisecondsSinceEpoch, 30002);
  });

  test('toDuration', () {
    var duration = Duration(milliseconds: 35200);

    var pbDuration = GrpcProtobufConvert.toDuration(duration);

    expect(pbDuration.seconds.toInt(), 35);
    expect(pbDuration.nanos, 200000);
  });

  test('toInt64', () {
    var value = 1234567890;

    var i64 = GrpcProtobufConvert.toInt64(value);

    expect(i64, Int64.parseInt('1234567890'));
  });

  test('toTimestamp', () {
    var timestamp = DateTime.fromMillisecondsSinceEpoch(1635902704309);

    var pbTimestamp = GrpcProtobufConvert.toTimestamp(timestamp);

    expect(pbTimestamp.seconds.toInt(), 1635902704);
    expect(pbTimestamp.nanos, 309000);
  });
}
