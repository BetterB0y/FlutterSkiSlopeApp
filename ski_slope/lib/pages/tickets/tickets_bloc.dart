import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ticket_data.dart';
import 'package:ski_slope/pages/tickets/usecase/load_tickets.dart';
import 'package:ski_slope/utilities/extensions.dart';

class TicketsBloc extends StatedBloc<TicketsState> {
  final LoadTicketsUseCase _loadTickets;
  List<TicketData> _tickets = [];

  TicketsBloc(this._loadTickets);

  @override
  TicketsState get defaultState => LoadingState([]);

  void load(int id) async {
    setState(LoadingState(_tickets));
    var result = await _loadTickets.execute(id);
    printError(result);
    if (result is SuccessfulDataResult) {
      _tickets = result.data;
      setState(ReadyState(_tickets));
    } else if (result is NoInternetConnectionDataResult) {
      setState(NoInternetState(_tickets));
    } else {
      setState(ErrorState(_tickets));
    }
  }
}

abstract class TicketsState {
  List<TicketData> tickets;

  TicketsState(this.tickets);
}

class LoadingState extends TicketsState {
  LoadingState(List<TicketData> tickets) : super(tickets);
}

class ReadyState extends TicketsState {
  ReadyState(List<TicketData> tickets) : super(tickets);
}

class ErrorState extends TicketsState {
  ErrorState(List<TicketData> tickets) : super(tickets);
}

class NoInternetState extends TicketsState {
  NoInternetState(List<TicketData> tickets) : super(tickets);
}
