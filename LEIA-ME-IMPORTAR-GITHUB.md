# NectarLink Android — importação da tradução PT-BR

Este pacote está organizado para ser extraído diretamente na raiz de uma cópia (fork) do repositório NectarLink.

## Conteúdo

- `android/app/src/main/res/values-pt-rBR/strings.xml`: 217 strings traduzidas de um total de 1.215 (17,9%).
- `.github/workflows/android-ptbr-validation.yml`: workflow para testar e compilar o APK de depuração na sua branch.
- `scripts/validar-ptbr-android.ps1`: verifica XML, chaves e placeholders contra o catálogo original.

## Importar pelo GitHub Desktop (sem usar Git Bash)

1. No GitHub, abra https://github.com/thtbee/nectarlink e clique em **Fork** para criar uma cópia na sua conta.
2. Instale/abra GitHub Desktop: https://desktop.github.com/ . Faça login na sua conta.
3. No GitHub Desktop, use **File → Clone repository** e clone o seu fork `SEU-USUARIO/nectarlink`.
4. No GitHub Desktop, crie uma branch chamada `traducao-portugues-br` usando **Current Branch → New Branch**.
5. Extraia este ZIP. Copie o conteúdo extraído para a pasta raiz do repositório clonado, mantendo a estrutura de pastas. Autorize a mesclagem das pastas.
6. Volte ao GitHub Desktop. Confira se aparecem os arquivos novos; grave um commit com a mensagem `Adicionar tradução parcial PT-BR para Android`.
7. Clique em **Push origin** para enviar a branch ao seu GitHub.
8. Abra seu repositório no site do GitHub, entre em **Actions** e veja a execução **Android PT-BR - build de validação**. Ela também inicia automaticamente após o push para a branch indicada.
9. Quando terminar, abra a execução e baixe o artefato `nectarlink-android-debug-validacao`.

## Importante sobre o APK desta etapa

A tradução ainda está parcial: 217 de 1.215 strings. O guia do projeto exige que uma língua incompleta não seja oferecida nem distribuída. Por isso, este pacote **não** altera `android/app/src/main/res/xml/locales_config.xml` nem `AppLanguage.kt`.

O workflow gera um APK de depuração para validar que o projeto compila e passa nos testes. **Esse APK ainda não oferece Português (Brasil) no seletor de idiomas** e não deve ser tratado como a versão traduzida final.

Quando as 1.215 strings estiverem traduzidas e revisadas, a etapa final será adicionar `pt-rBR` ao `locales_config.xml` e `AppLanguage.languages`, atualizar os testes e gerar o APK com o idioma habilitado.

## Validar localmente (opcional)

Abra PowerShell na raiz do repositório e execute:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validar-ptbr-android.ps1
```

O script é somente de validação; não modifica os arquivos.
