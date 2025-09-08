import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(ref),
);

class AuthState {
  final String? token;
  final String? role;
  final bool isLoading;
  final String? error;

  AuthState({
    this.token,
    this.role,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => token != null;
  bool get isGuru => role == 'guru';
  bool get isSiswa => role == 'user';

  AuthState copyWith({
    String? token,
    String? role,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      token: token ?? this.token,
      role: role ?? this.role,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthStateNotifier(this.ref) : super(AuthState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final role = prefs.getString('role');
      
      if (token != null && role != null) {
        state = state.copyWith(
          token: token,
          role: role,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json', // tambahkan ini
        },
        body: json.encode({'email': email, 'password': password}), // ubah ke json
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('role', data['user']['role']);

        state = state.copyWith(
          token: data['token'],
          role: data['user']['role'],
          isLoading: false,
        );
      } else {
        throw Exception('Login gagal: ${response.statusCode}');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token != null) {
        await http.post(
          Uri.parse('http://127.0.0.1:8000/api/logout'),
          headers: {'Authorization': 'Bearer $token'},
        );
      }
      
      await prefs.clear();
      state = AuthState(); // Reset state to default (no user, no role)
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> refreshRole() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) return;

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/user'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final role = jsonDecode(response.body)['role'];
        await prefs.setString('role', role);
        state = state.copyWith(role: role, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}