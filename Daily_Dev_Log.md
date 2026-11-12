# Daily Dev Log

- 2025-11-06
  - `.NET` deployment with docker/caddy
  - sample in repo:

- 2026-02-09
  - psql: pg_dump and pg_restore --> use `--clean` for `.dump` file instead of plain sql, so pg_restore can be used

- 2026-03-02:
  - node: ES MODLUE ("type": "module")-> ALL import ... dependencies are loaded/evaluated before the module body runs -> side effect import `import 'dotenv.config'`

- 2026-08-12
  - **C#**:

    ```c#
    int? x = null;
    int y = x
    int y = x!
    int y = x.Value
    int y = x!.Value
    ```

- 2026-09-16
  - **Docker**: secrets / docker-compose

- 2026-09-16
  - **Docker**: volumes / docker-compose

- 2026-10-07
  - **Monitoring**: seq / grafana / openobserve

- 2026-10-08
  - **.NET**: structured logging / httpexception middleware / TraceId & SpanId

- 2026-11-12
  - **docker** / **Linux**: 