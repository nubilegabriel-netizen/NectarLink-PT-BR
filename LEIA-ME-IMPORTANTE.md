# NectarLink Android — PT-BR prévia para exibir no seletor

## Arquivos incluídos (caminhos completos)
1. `android/app/src/main/res/values-pt-rBR/strings.xml` — catálogo parcial, 341 strings.
2. `android/app/src/main/res/xml/locales_config.xml` — registra o locale `pt-BR` no Android.
3. `android/app/src/main/kotlin/app/nectarlink/android/ui/AppLanguage.kt` — adiciona `Português (Brasil)` ao seletor e normaliza `pt-BR`.
4. `.github/workflows/android-ptbr-preview.yml` — workflow que baixa o código oficial, aplica os três arquivos e gera um APK de prévia.

## Como importar no repositório NectarLink-PT-BR
Extraia o ZIP na raiz do repositório e mescle/substitua os arquivos mantendo os caminhos. Faça commit e push. Em GitHub > Actions, execute `Android PT-BR - APK de prévia`.

## Resultado esperado
O menu Settings > Appearance > Language > More passa a mostrar `Português (Brasil)`.

## Atenção: versão de prévia, não tradução completa
O catálogo atual contém 341 de 1.215 strings (aprox. 28.1%). As strings não traduzidas serão herdadas do inglês. Portanto, a interface ficará parcialmente em português e parcialmente em inglês.

O teste `LocalesTest` do projeto exige que todo idioma oferecido esteja 100% traduzido, incluindo plurais. Por isso o workflow de prévia executa `lintDebug assembleDebug`, mas deliberadamente não executa `testDebugUnitTest`. Não publique nem distribua este APK como versão final. Para liberar o idioma oficialmente, concluir todas as strings e plurais e então voltar a executar a suíte completa de testes.

O arquivo `action_wake` que causou `ExtraTranslation` não está no catálogo PT-BR deste pacote.
