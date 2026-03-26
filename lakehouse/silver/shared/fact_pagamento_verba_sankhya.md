<!-- generated: lakehouse-object -->
# silver.fact_pagamento_verba_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_pagamento
- Relacionamentos: 4

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_pagamento | int | False | True | False | - |
| 2 | sk_empresa | smallint | False | False | False | - |
| 3 | sk_funcionario | int | False | False | False | - |
| 4 | sk_evento | int | False | False | False | - |
| 5 | sk_calendario | int | False | False | False | - |
| 6 | valor | decimal(18,2) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_pagamento_calendario | sk_calendario | silver.dim_calendario.sk_calendario |
| fk_pagamento_empresa | sk_empresa | silver.dim_empresa.sk_empresa |
| fk_pagamento_evento | sk_evento | silver.dim_evento.sk_evento |
| fk_pagamento_funcionario | sk_funcionario | silver.dim_funcionario.sk_funcionario |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[fact_pagamento_verba_sankhya] (
    [sk_pagamento] int IDENTITY(1,1) NOT NULL,
    [sk_empresa] smallint NOT NULL,
    [sk_funcionario] int NOT NULL,
    [sk_evento] int NOT NULL,
    [sk_calendario] int NOT NULL,
    [valor] decimal(18,2) NOT NULL,
    CONSTRAINT [pk_pagamento] PRIMARY KEY ([sk_pagamento])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
