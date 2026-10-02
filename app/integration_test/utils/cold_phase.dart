bool coldPhaseSkip(String phase, Iterable<String> tags, bool? callerSkip) {
  if (callerSkip == true) return true;
  final seed = tags.contains('cold_seed'),
      verify = tags.contains('cold_verify');
  if (phase == 'seed') return !seed;
  if (phase == 'verify') return !verify;
  return seed || verify;
}
