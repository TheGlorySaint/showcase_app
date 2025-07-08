// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:showcase/core/domain/dio_module.dart' as _i495;
import 'package:showcase/core/domain/remote_data_source.dart' as _i86;
import 'package:showcase/feature/prime/data/repositories/prime_repository.dart'
    as _i173;
import 'package:showcase/feature/prime/domain/repositories/prime_repository.dart'
    as _i1057;
import 'package:showcase/feature/prime/presentation/cubit/prime_cubit.dart'
    as _i376;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio());
    gh.lazySingleton<_i86.RemoteDatasource>(
      () => _i86.RemoteDatasourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i1057.PrimeRepository>(
      () => _i173.PrimeRepositoryImpl(
        remoteDatasource: gh<_i86.RemoteDatasource>(),
      ),
    );
    gh.factory<_i376.PrimeCubit>(
      () => _i376.PrimeCubit(gh<_i1057.PrimeRepository>()),
    );
    return this;
  }
}

class _$DioModule extends _i495.DioModule {}
