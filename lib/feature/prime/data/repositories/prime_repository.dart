import 'package:injectable/injectable.dart';

import '../../../../core/domain/remote_data_source.dart';
import '../../../../core/error/failures.dart';
import '../../../../util/barrel_util.dart';
import '../../domain/repositories/prime_repository.dart';

@Injectable(as: PrimeRepository)
class PrimeRepositoryImpl implements PrimeRepository {
  PrimeRepositoryImpl({required this.remoteDatasource});
  final RemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, List<int>>> getNumber({required String path}) async {
    try {
      final response = await remoteDatasource.getApiEndpoint(path);

      return Right(List<int>.from(response));
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
