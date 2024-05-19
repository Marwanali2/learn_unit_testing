import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_unit_testing/user_model.dart';
import 'package:learn_unit_testing/user_repo.dart';
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
                data: { // الداتا اللي هترجعها ال API
                  "id": 1,
                  "name": "Leanne Graham",
                  "username": "Bret",
                  "email": "Sincere@april.biz",
                  "address": {
                    "street": "Kulas Light",
                    "suite": "Apt. 556",
                    "city": "Gwenborough",
                    "zipcode": "92998-3874",
                    "geo": {"lat": "-37.3159", "lng": "81.1496"}
                  },
                  "phone": "1-770-736-8031 x56442",
                  "website": "hildegard.org",
                  "company": {
                    "name": "Romaguera-Crona",
                    "catchPhrase": "Multi-layered client-server neural-net",
                    "bs": "harness real-time e-markets"
                  }
                },
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
