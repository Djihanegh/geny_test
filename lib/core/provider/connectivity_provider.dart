import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider {
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return await _connectivity.checkConnectivity();
  }

  final Connectivity _connectivity;

  ConnectivityProvider({required Connectivity connectivity}) : _connectivity = connectivity;
}
