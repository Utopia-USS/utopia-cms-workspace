# Utopia - Libs & Skills

A deployable showcase for [utopia_cms](https://pub.dev/packages/utopia_cms): a two-page admin panel that catalogs the Utopia ecosystem, rendered by `utopia_cms` itself.

- **Libs** - the published `utopia_*` packages (real pub.dev data).
- **Skills** - the Claude Code skills.

Both pages run on stateful in-memory mock delegates, so create / edit / delete are live for the session with no backend. Reload to reset to the seed data.

## Run

From the repo root:

```sh
melos run run:example      # Chrome, with hot reload
melos run build:example    # deployable web bundle -> build/web
```

Or directly:

```sh
cd packages/core/example && flutter run -d chrome
```
