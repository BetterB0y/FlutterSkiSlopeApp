import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ticket_data.dart';
import 'package:ski_slope/data/repository/ticket_repository.dart';

abstract class LoadTicketsUseCase {
  FutureDataResult<List<TicketData>> execute(int id);
}

class LoadTicketsImpl extends LoadTicketsUseCase {
  final TicketRepository _repository;

  LoadTicketsImpl(this._repository);

  @override
  FutureDataResult<List<TicketData>> execute(int id) => _repository.loadTicketsById(id);
}
