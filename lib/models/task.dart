/**
 * BOOSTLY - Modèle de Tâche
 * 
 * Représente une tâche dans l'application avec toutes ses propriétés.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:cloud_firestore/cloud_firestore.dart';

/// Modèle de données pour une tâche
class Task {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String category;
  final String priority;
  final String status;
  final DateTime createdAt;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final int estimatedMinutes;
  final List<String> tags;
  final bool isRecurring;
  final String? recurringPattern;
  final int streak;
  final int xpAwarded;
  final Map<String, dynamic>? metadata;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.category,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.dueDate,
    this.completedAt,
    this.estimatedMinutes = 0,
    this.tags = const [],
    this.isRecurring = false,
    this.recurringPattern,
    this.streak = 0,
    this.xpAwarded = 0,
    this.metadata,
  });

  /// Crée une tâche depuis un document Firestore
  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'],
      category: data['category'] ?? 'personal',
      priority: data['priority'] ?? 'medium',
      status: data['status'] ?? 'todo',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      estimatedMinutes: data['estimatedMinutes'] ?? 0,
      tags: List<String>.from(data['tags'] ?? []),
      isRecurring: data['isRecurring'] ?? false,
      recurringPattern: data['recurringPattern'],
      streak: data['streak'] ?? 0,
      xpAwarded: data['xpAwarded'] ?? 0,
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convertit la tâche en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'estimatedMinutes': estimatedMinutes,
      'tags': tags,
      'isRecurring': isRecurring,
      'recurringPattern': recurringPattern,
      'streak': streak,
      'xpAwarded': xpAwarded,
      'metadata': metadata,
    };
  }

  /// Crée une copie de la tâche avec des modifications
  Task copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? category,
    String? priority,
    String? status,
    DateTime? createdAt,
    DateTime? dueDate,
    DateTime? completedAt,
    int? estimatedMinutes,
    List<String>? tags,
    bool? isRecurring,
    String? recurringPattern,
    int? streak,
    int? xpAwarded,
    Map<String, dynamic>? metadata,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      tags: tags ?? this.tags,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringPattern: recurringPattern ?? this.recurringPattern,
      streak: streak ?? this.streak,
      xpAwarded: xpAwarded ?? this.xpAwarded,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Vérifie si la tâche est en retard
  bool get isOverdue {
    if (dueDate == null || status == 'completed') return false;
    return DateTime.now().isAfter(dueDate!);
  }

  /// Vérifie si la tâche est due aujourd'hui
  bool get isDueToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    return dueDate!.year == now.year &&
        dueDate!.month == now.month &&
        dueDate!.day == now.day;
  }

  /// Vérifie si la tâche est complétée
  bool get isCompleted => status == 'completed';

  @override
  String toString() {
    return 'Task(id: $id, title: $title, status: $status, category: $category)';
  }
}

