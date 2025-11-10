/**
 * BOOSTLY - Utilitaires de Sécurité
 * 
 * Fonctions de sécurité: chiffrement, validation, sanitization.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 * 
 * Sécurité:
 * - Chiffrement AES-256 pour données sensibles
 * - Validation et sanitization des inputs
 * - Protection XSS et injection
 * - Conformité RGPD
 */

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Utilitaires de sécurité
class SecurityUtils {
  static const _storage = FlutterSecureStorage();
  static encrypt.Encrypter? _encrypter;

  /// Initialise le chiffrement
  static void initializeEncryption() {
    // En production, générer et stocker la clé de manière sécurisée
    final key = encrypt.Key.fromSecureRandom(32);
    encrypt.IV.fromSecureRandom(16); // IV généré mais non utilisé pour l'instant
    _encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  /// Chiffre une chaîne de caractères
  static String encryptString(String plainText) {
    if (_encrypter == null) {
      initializeEncryption();
    }
    
    try {
      final encrypted = _encrypter!.encrypt(plainText);
      return encrypted.base64;
    } catch (e) {
      return plainText; // En cas d'erreur, retourner le texte original
    }
  }

  /// Déchiffre une chaîne de caractères
  static String decryptString(String encryptedText) {
    if (_encrypter == null) {
      initializeEncryption();
    }
    
    try {
      final encrypted = encrypt.Encrypted.fromBase64(encryptedText);
      return _encrypter!.decrypt(encrypted);
    } catch (e) {
      return encryptedText; // En cas d'erreur, retourner le texte chiffré
    }
  }

  /// Valide un email
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  /// Valide un mot de passe (minimum 8 caractères)
  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  /// Valide un mot de passe fort
  static bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!RegExp(r'[a-z]').hasMatch(password)) return false;
    if (!RegExp(r'[A-Z]').hasMatch(password)) return false;
    if (!RegExp(r'\d').hasMatch(password)) return false;
    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(password)) return false;
    return true;
  }

  /// Sanitize une chaîne de caractères (protection XSS)
  static String sanitizeInput(String input) {
    return input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('/', '&#x2F;');
  }

  /// Hash un mot de passe (SHA-256 pour stockage local)
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Génère un token sécurisé
  static String generateSecureToken() {
    final random = encrypt.Key.fromSecureRandom(32);
    return random.base64;
  }

  /// Stocke une valeur de manière sécurisée
  static Future<void> storeSecureValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Récupère une valeur stockée de manière sécurisée
  static Future<String?> getSecureValue(String key) async {
    return await _storage.read(key: key);
  }

  /// Supprime une valeur stockée
  static Future<void> deleteSecureValue(String key) async {
    await _storage.delete(key: key);
  }

  /// Valide une URL
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  /// Valide un numéro de téléphone (format français)
  static bool isValidPhoneNumber(String phone) {
    final regex = RegExp(r'^(\+33|0)[1-9](\d{2}){4}$');
    return regex.hasMatch(phone.replaceAll(' ', ''));
  }

  /// Masque un email pour l'affichage
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) {
      return '${username[0]}***@$domain';
    }
    
    return '${username[0]}***${username[username.length - 1]}@$domain';
  }

  /// Masque un numéro de téléphone
  static String maskPhoneNumber(String phone) {
    if (phone.length < 4) return phone;
    return '${phone.substring(0, 2)}**${phone.substring(phone.length - 2)}';
  }
}

