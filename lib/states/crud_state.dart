/// Representa as operações básicas de um fluxo CRUD.
enum CrudOperation {
  /// Criação de um novo registro.
  create,

  /// Leitura (visualização) de um registro existente.
  read,

  /// Atualização (edição) de um registro existente.
  update,

  /// Exclusão de um registro existente.
  delete,

  /// Duplicação de um registro existente.
  duplicate,
}

/// Estado genérico para operações CRUD, opcionalmente carregando
/// uma entidade do tipo [T] quando aplicável.
///
/// Exemplo de uso:
/// ```dart
/// // Apenas criação (sem payload)
/// final s1 = CrudState<MyModel>.create();
///
/// // Leitura de um objeto
/// final model = MyModel(id: 1, name: 'Foo');
/// final s2 = CrudState.read(model);
///
/// // Atualização
/// final updated = model.copyWith(name: 'Bar');
/// final s3 = CrudState.update(updated);
///
/// // Exclusão
/// final s4 = CrudState.delete(model);
///
/// // Duplicação
/// final s5 = CrudState.duplicate(model);
/// ```
class CrudState<T> {
  /// Operação sendo representada.
  final CrudOperation operation;

  /// Entidade associada à operação, quando relevante.
  final T? entity;

  /// Dados extras que podem ser úteis durante a operação.
  ///
  /// Ex: parâmetros adicionais, flags, valores temporários, etc.
  final Map<String, dynamic>? data;

  /// Construtor privado com todos os campos.
  const CrudState._(this.operation, [this.entity, this.data]);

  const CrudState.create({Map<String, dynamic>? data})
    : this._(CrudOperation.create, null, data);

  const CrudState.read(T entity, {Map<String, dynamic>? data})
    : this._(CrudOperation.read, entity, data);

  const CrudState.update(T entity, {Map<String, dynamic>? data})
    : this._(CrudOperation.update, entity, data);

  const CrudState.delete(T entity, {Map<String, dynamic>? data})
    : this._(CrudOperation.delete, entity, data);

  const CrudState.duplicate(T entity, {Map<String, dynamic>? data})
    : this._(CrudOperation.duplicate, entity, data);

  /// Getters convenientes
  bool get isCreate => operation == CrudOperation.create;
  bool get isRead => operation == CrudOperation.read;
  bool get isUpdate => operation == CrudOperation.update;
  bool get isDelete => operation == CrudOperation.delete;
  bool get isDuplicate => operation == CrudOperation.duplicate;

  @override
  String toString() {
    final parts = [
      'CrudState<$T>($operation',
      if (entity != null) ', entity: $entity',
      if (data != null) ', data: $data',
      ')',
    ];
    return parts.join();
  }
}
