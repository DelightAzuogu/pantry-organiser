class PantryItemState {
  PantryItemState({
    this.isLoading = true,
    this.isCreated = false,
    this.isUpdated = false,
    this.isDeleted = false,
    this.error,
  });

  factory PantryItemState.loading() => PantryItemState();
  factory PantryItemState.created() => PantryItemState(
        isCreated: true,
        isLoading: false,
      );
  factory PantryItemState.updated() => PantryItemState(
        isUpdated: true,
        isLoading: false,
      );
  factory PantryItemState.deleted() => PantryItemState(
        isDeleted: true,
        isLoading: false,
      );
  factory PantryItemState.error(String error) => PantryItemState(
        error: error,
        isLoading: false,
      );

  final bool isLoading;
  final bool isCreated;
  final bool isUpdated;
  final bool isDeleted;
  final String? error;

  PantryItemState copyWith({
    bool? isLoading,
    bool? isCreated,
    bool? isUpdated,
    bool? isDeleted,
    String? error,
  }) {
    return PantryItemState(
      isLoading: isLoading ?? this.isLoading,
      isCreated: isCreated ?? this.isCreated,
      isUpdated: isUpdated ?? this.isUpdated,
      isDeleted: isDeleted ?? this.isDeleted,
      error: error ?? this.error,
    );
  }
}
