import '../../../../core/error/failures.dart';
import '../../../../util/either_helper.dart';

abstract class PrimeRepository {
  Future<Either<Failure, List<int>>> getNumber({required String path});
}
