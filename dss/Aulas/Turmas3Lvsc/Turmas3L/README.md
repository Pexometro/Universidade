# Turmas3L

Exemplo de app com três camadas para usar em DSS.

NOTA: Este código foi criado para discussão e edição durante as aulas práticas de DSS, representando uma solução em construção. Como tal, não deverá ser visto como uma solução canónica, ou mesmo acabada. É disponibilizado para auxiliar o processo de estudo. 

Os alunos são encorajados a testar adequadamente o código fornecido e a procurar soluções alternativas, à medida que forem adquirindo mais conhecimentos. Deverão, por exemplo:
- considerar a utilização de transações nos DAOs, onde apropriado (ver slides)
- melhorar o tratamento de erros, definindo excepções apropriadas
- finalizar a implementação de métodos dos DAOs como put e containsKey
- considerar a utilização generalizada de PreparedStatements, para evitar ataques por SQL injection 


## Estrutura de Pastas

O espaço de trabalho contém duas pastas por padrão, onde:
- `src`: a pasta para manter os fontes
- `lib`: a pasta para manter as dependências (neste caso, os drivers JDBC)

Entretanto, os ficheiros de saída compilados serão gerados na pasta `bin`, por omissão.

> Se quiser personalizar a estrutura de pastas, abra `.vscode/settings.json` e atualize as configurações relacionadas lá.

## Gestão de Dependências

A vista `JAVA PROJECTS` permite-lhe gerir as suas dependências. Mais detalhes podem ser encontrados [aqui](https://github.com/microsoft/vscode-java-dependency#manage-dependencies).
