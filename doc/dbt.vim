*vim-dbt* dbt development plugin

==========================================================================
CONTENTS                                            *dbtContents*

    1. Intro ................ |dbtIntro|
    2. Commands ............. |dbtCommands|
    3. Configuration ........ |dbtConfiguration|
    4. Mappings ............. |dbtMappings|
    5. License .............. |dbtLicense|

==============================================================================
1. Intro                                                           *dbtIntro*

dbt (data build tool) support for Vim. vim-dbt comes with filetype detection 
that determines when .sql and .yml files belong to a dbt project, dbt syntax 
highlighting (based on jinja2 + SQL syntax), and commands & mappings for 
running core dbt commands from within vim.

==============================================================================
2. Commands                                                      *dbtCommands*

                                                                   *:DbtRun*
:DbtRun
    Run one or more models against the target environment (see |g:dbt_target|).
    The argument completion is enabled for model names:

    `:DbtRun dim_<TAB>` or `:DbtRun dim_<C-A>`

    When run with no arguments, the command will take the filename of the 
    current buffer (sans extension) as its argument.

                                                                   *:DbtTest*
:DbtTest
    Test one or more models agains the target environment; accepts arguments in 
    the same way as |DbtRun|.

                                                                   *:DbtToggle*
:DbtToggle
    Toggles the dbt terminal window open or closed.

                                                                   *:DbtRef*
:DbtRef
    If called without arguments, then it should be called with a "ref()" under 
    the cursor; otherwise, it can open model files taken from an argument list.

                                                                   *:DbtSchema*
:DbtSchema
    Opens the relevant schema file for the model in the current buffer.

==============================================================================
3. Configuration                                            *dbtConfiguration*

You can configure the following settings to change how vim-dbt works.

------------------------------------------------------------------------------
4.1 g:clam_autoreturn                                *DbtConfiguration_target*

==============================================================================
4. Mappings                                                      *dbtMappings*

vim-dbt has several <Plug> mappings that can be used to create custom mappings.

Available <Plug> keys are:

                                                                    *(dbt-run)*

Calls `dbt run` for the model in the current buffer

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
