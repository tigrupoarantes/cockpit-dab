# Manifesto Lakehouse

Gerado a partir do banco real via `.env`, com snapshots auxiliares em `docs/schema_columns.csv` e `docs/schema_fks.csv`.

## Resumo por schema

| schema | objetos | shared | chokdistribuidora | g4distribuidora |
|---|---:|---:|---:|---:|
| bronze | 86 | 13 | 36 | 37 |
| silver | 43 | 10 | 18 | 15 |
| gold | 13 | 12 | 0 | 1 |

## Observacoes

- `shared` e o fallback para objetos sem sufixo de industria ou com override explicito.
- `g4_distribuidora` e `g4distribuidora` sao tratados como a mesma industria canonica: `g4distribuidora`.
- Cada objeto do medalhao recebeu um artefato `.md` em `lakehouse/<schema>/<industria>/`.
