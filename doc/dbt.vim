*vim-dbt* dbt development plugin

====================================================================
CONTENTS                                            *dbtContents*

    1. Intro ................ |dbtIntro|
    2. Install .............. |dbtInstall|
    3. Commands ............. |dbtCommands|
    4. Configuration ........ |dbtConfiguration|
    5. Mappings ............. |dbtMappings|
    6. License .............. |dbtLicense|


==============================================================================
1. Intro                                                           *dbtIntro*

dbt (data build tool) support for Vim. vim-dbt comes with 

==============================================================================
2. Install                                                           *dbtIntro*

dbt (data build tool) support for Vim. vim-dbt comes with 

==============================================================================
3. Commands                                                      *dbtCommands*

                                                                   *:DbtRun*
:DbtRun
    DbtRun opens the default browser and starts a new bug report
    with useful system information.

                                                                   *:DbtTest*
:DbtTest
    DbtTest opens the default browser and starts a new bug report
    with useful system information.

                                                                   *:DbtClose*
:DbtClose
    DbtClose opens the default browser and starts a new bug report
    with useful system information.

                                                                   *:DbtRef*
:DbtRef
    DbtRef opens the default browser and starts a new bug report
    with useful system information.

                                                                   *:DbtSchema*
:DbtSchema
    DbtSchema opens the default browser and starts a new bug report
    with useful system information.

==============================================================================
4. Configuration                                            *dbtConfiguration*

You can configure the following settings to change how Clam works.

------------------------------------------------------------------------------
3.1 g:clam_autoreturn                                *DbtConfiguration_target*

==============================================================================
5. Mappings                                                      *dbtMappings*

vim-dbt has several <Plug> mappings that can be used to create custom mappings.

Available <Plug> keys are:

                                                                    *(go-run)*

Calls `go run` for the current main package

                                                                *(go-run-tab)*

Calls `go run` for the current file in a new terminal tab
This option is neovim only.

                                                              *(go-run-split)*

Calls `go run` for the current file in a new terminal horizontal split
This option is neovim only.

                                                           *(go-run-vertical)*

Calls `go run` for the current file in a new terminal vertical split
This option is neovim only.

==============================================================================
5. License                                                        *dbtLicense*

dbt is licensed under the MIT License.
