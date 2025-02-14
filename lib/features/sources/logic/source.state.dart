part of 'source.cubit.dart';

class SourceState {
  final List<SourceDTO> sources;

  SourceState({required this.sources});

  factory SourceState.initial(List<SourceDTO> sources) =>
      SourceState(sources: sources);

  SourceState _add(SourceDTO source) =>
      SourceState(sources: sources.withUnique(source));

  SourceState _remove(SourceDTO source) =>
      SourceState(sources: sources.without(source));

  SourceState _replace(SourceDTO source) =>
      SourceState(sources: sources.withReplace(source));
}
