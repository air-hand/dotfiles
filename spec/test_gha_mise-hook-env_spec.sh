# tests for .github/actions/mise-hook-env/export.sh

Describe 'export.sh'
    # setup and teardown before include.
    setupAll() {
        export GITHUB_ENV="$(mktemp)"
        export GITHUB_PATH="$(mktemp)"
    }
    teardownAll() {
        if [[ -f "$GITHUB_ENV" ]]; then
            rm -f "$GITHUB_ENV"
        fi
        if [[ -f "$GITHUB_PATH" ]]; then
            rm -f "$GITHUB_PATH"
        fi
    }
    BeforeAll 'setupAll'
    AfterAll 'teardownAll'

    setup() {
        echo -n "" > $GITHUB_ENV
        echo -n "" > $GITHUB_PATH
    }
    BeforeEach 'setup'

    Describe 'export.sh'
        Include ../.github/actions/mise-hook-env/export.sh

        It 'should export variables'
            # stub mise command
            mise() {
                if [[ "$1" != "hook-env" ]]; then
                    command mise "$@"
                    return
                fi
                %text
                #|export FOO=BAR1
                #|export BAZ=QUX
                #|export FOO=BAR2
            }

            When call mise-hook-env
            The line 1 of contents of file "$GITHUB_ENV" should equal "FOO=BAR1"
            The line 2 of contents of file "$GITHUB_ENV" should equal "BAZ=QUX"
            The line 3 of contents of file "$GITHUB_ENV" should equal "FOO=BAR2"
        End

        It 'should export variables (path)'
            # stub mise command
            mise() {
                if [[ "$1" != "hook-env" ]]; then
                    command mise "$@"
                    return
                fi
                %text
                #|export PATH=/usr/local/bin:/usr/bin
                #|export BAZ=QUX
                #|export PATH=~/.local/bin:/usr/local/bin:/usr/bin
                #|export FOO_PATH=~/.local/bin:/usr/local/bin:/usr/bin
            }

            When call mise-hook-env
            The line 1 of contents of file "$GITHUB_PATH" should equal "~/.local/bin:/usr/local/bin:/usr/bin"
            The line 1 of contents of file "$GITHUB_ENV" should equal "BAZ=QUX"
            The line 2 of contents of file "$GITHUB_ENV" should equal "FOO_PATH=~/.local/bin:/usr/local/bin:/usr/bin"
        End
    End
End
