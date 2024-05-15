import 'package:flutter_test/flutter_test.dart';
import 'package:learn_unit_testing/counter.dart';

void main() {
  // given when then
  late CounterClass counterClassObject;
  setUp(() {
    // Arrange
    counterClassObject = CounterClass();
  });
  group('Counter Class - ', () {
    test(
      'given counter class when it is initialized then value of count should equal to zero',
      () {
        // Act
        final count = counterClassObject.count;
        // Assert
        expect(count, 0);
      },
    );

    test(
      'given counter class when incrementCounter is called then value of count should be 1',
      () {
        // Arrange

        // Act
        counterClassObject.incrementCounter();
        final val = counterClassObject.count;
        // Assert
        expect(val, 1);
      },
    );
    test(
      'given counter class when decrementCounter is called then value of count should be -1',
      () {
        // Arrange

        // Act
        counterClassObject.decrementCounter();
        final val = counterClassObject.count;
        // Assert
        expect(val, -1);
      },
    );

    test(
      'given counter class when resetCounter is called then value of count should be 0',
      () {
        //Act
        counterClassObject.resetCounter();
        final val = counterClassObject.count;
        // Assert
        expect(val, 0);
      },
    );
  });
}
