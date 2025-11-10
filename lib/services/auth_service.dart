/**
 * BOOSTLY - Service d'Authentification
 * 
 * Gère l'authentification utilisateur via Firebase Auth.
 * Supporte email/password, Google Sign-In et Apple Sign-In.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 * 
 * Sécurité:
 * - Validation des emails
 * - Mots de passe hashés (Firebase)
 * - Authentification biométrique optionnelle
 * - Sessions avec expiration
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// TODO: Ajouter google_sign_in package: flutter pub add google_sign_in
// import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

/// Service d'authentification Firebase
class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  
  User? _currentFirebaseUser;
  BoostlyUser? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  AuthService() {
    // Écouter les changements d'état d'authentification
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  /// Utilisateur Firebase actuel
  User? get currentFirebaseUser => _currentFirebaseUser;
  
  /// Utilisateur BOOSTLY actuel
  BoostlyUser? get currentUser => _currentUser;
  
  /// État de chargement
  bool get isLoading => _isLoading;
  
  /// Message d'erreur
  String? get errorMessage => _errorMessage;
  
  /// Vérifie si l'utilisateur est connecté
  bool get isAuthenticated => _currentFirebaseUser != null;

  /// Écoute les changements d'état d'authentification
  Future<void> _onAuthStateChanged(User? user) async {
    _currentFirebaseUser = user;
    if (user != null) {
      await _loadUserData(user.uid);
    } else {
      _currentUser = null;
    }
    notifyListeners();
  }

  /// Charge les données utilisateur depuis Firestore
  Future<void> _loadUserData(String userId) async {
    try {
      _currentUser = await _firestoreService.getUser(userId);
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du chargement des données utilisateur: $e');
    }
  }

  /// Inscription avec email et mot de passe
  Future<BoostlyUser?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Valider l'email
      if (!_isValidEmail(email)) {
        throw Exception('Email invalide');
      }

      // Valider le mot de passe
      if (!_isValidPassword(password)) {
        throw Exception('Le mot de passe doit contenir au moins 8 caractères');
      }

      // Créer le compte Firebase
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Erreur lors de la création du compte');
      }

      // Mettre à jour le nom d'affichage
      if (displayName != null) {
        await userCredential.user!.updateDisplayName(displayName);
      }

      // Créer le profil utilisateur dans Firestore
      final boostlyUser = BoostlyUser(
        id: userCredential.user!.uid,
        email: email,
        displayName: displayName,
        createdAt: DateTime.now(),
        stats: UserStats(),
        preferences: UserPreferences(),
        subscription: SubscriptionInfo(),
      );

      await _firestoreService.createUser(boostlyUser);
      _currentUser = boostlyUser;

      _isLoading = false;
      notifyListeners();
      return boostlyUser;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getAuthErrorMessage(e.code);
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Connexion avec email et mot de passe
  Future<BoostlyUser?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Erreur lors de la connexion');
      }

      // Mettre à jour la date de dernière connexion
      await _firestoreService.updateUserLastLogin(userCredential.user!.uid);

      _isLoading = false;
      notifyListeners();
      return _currentUser;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getAuthErrorMessage(e.code);
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Connexion avec Google
  Future<BoostlyUser?> signInWithGoogle() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // TODO: Implémenter Google Sign In après installation du package
      // flutter pub add google_sign_in
      /*
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return null; // L'utilisateur a annulé
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      */
      
      // Temporaire: retourner null jusqu'à ce que Google Sign In soit configuré
      _isLoading = false;
      _errorMessage = 'Google Sign In non configuré. Installez le package: flutter pub add google_sign_in';
      notifyListeners();
      return null;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Connexion avec Apple (iOS uniquement)
  Future<BoostlyUser?> signInWithApple() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final appleProvider = AppleAuthProvider();
      final userCredential = await _auth.signInWithProvider(appleProvider);

      if (userCredential.user == null) {
        throw Exception('Erreur lors de la connexion Apple');
      }

      // Vérifier si l'utilisateur existe déjà
      final existingUser = await _firestoreService.getUser(userCredential.user!.uid);
      
      if (existingUser == null) {
        final boostlyUser = BoostlyUser(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          displayName: userCredential.user!.displayName,
          createdAt: DateTime.now(),
          stats: UserStats(),
          preferences: UserPreferences(),
          subscription: SubscriptionInfo(),
        );
        await _firestoreService.createUser(boostlyUser);
        _currentUser = boostlyUser;
      } else {
        await _firestoreService.updateUserLastLogin(userCredential.user!.uid);
        _currentUser = existingUser;
      }

      _isLoading = false;
      notifyListeners();
      return _currentUser;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Déconnexion
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // TODO: Décommenter après installation de google_sign_in
      // await GoogleSignIn().signOut();
      _currentUser = null;
      _currentFirebaseUser = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Réinitialisation du mot de passe
  Future<bool> resetPassword(String email) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _auth.sendPasswordResetEmail(email: email);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Validation de l'email
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validation du mot de passe
  bool _isValidPassword(String password) {
    return password.length >= 8;
  }

  /// Convertit les codes d'erreur Firebase en messages français
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'Le mot de passe est trop faible';
      case 'email-already-in-use':
        return 'Cet email est déjà utilisé';
      case 'invalid-email':
        return 'Email invalide';
      case 'user-not-found':
        return 'Aucun compte trouvé avec cet email';
      case 'wrong-password':
        return 'Mot de passe incorrect';
      case 'too-many-requests':
        return 'Trop de tentatives. Réessayez plus tard';
      case 'network-request-failed':
        return 'Erreur de connexion réseau';
      default:
        return 'Une erreur est survenue';
    }
  }
}

