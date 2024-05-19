import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_unit_testing/user_model.dart';
import 'package:learn_unit_testing/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  late UserRepository userRepository;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    userRepository = UserRepository(mockDioClient);
  });

  group('User Repository - ', () {
    group(
      'get user method',
      () {
        test(
          'given user repository class when get user method is called and status code is 200 then user model should be returned',
          () async {
            // arrange
            when(() => mockDioClient.get(
                'https://jsonplaceholder.typicode.com/users/1')).thenAnswer(
              (invocation) async => Response(
                requestOptions: RequestOptions(path: ''),
                data:(await Dio().get('https://jsonplaceholder.typicode.com/users/1')).data, //الداتا اللي هترجعها ال API
                statusCode: 200,
              ),
            );

            // act
            final user = await userRepository.getUser();

            // assert
            expect(user, isA<UserModel>());
          },
        );

        test( // return exception if status code is not 200
          'given user repository class when get user method is called and status code is not 200 then exception should be thrown',
          () async {
            // arrange
            when(() => mockDioClient.get(
                'https://jsonplaceholder.typicode.com/users/1')).thenAnswer(
              (invocation) async => Response(
                requestOptions: RequestOptions(path: ''),
                data:'{}',
                statusCode: 500,
              ),
            );
            // act
            final user = userRepository.getUser();

            // assert
            expect(user, throwsException);
          },
        );
      },
    );
  });
}
