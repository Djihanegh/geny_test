import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider {
  ConnectivityProvider({required Connectivity connectivity}) : _connectivity = connectivity;
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return _connectivity.checkConnectivity();
  }

  final Connectivity _connectivity;
}
