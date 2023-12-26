# tests for dot_local/bin/functions.sh

Describe 'functions.sh'
    setup() { :; }
    teardown() { :; }
    BeforeEach 'setup'
    AfterEach 'teardown'

    Include ../functions.sh

    Describe 'random_string()' 
        It 'should return random string default length.'
            When call random_string
            The output should regexp '^[a-zA-Z0-9]{32}$'
        End
        It 'should return random string 8 length.'
            When call random_string 8
            The output should regexp '^[a-zA-Z0-9]{8}$'
        End
    End

    Describe 'prepend_to_all()'
        It 'should prepend strings with prefix.'
            When call prepend_to_all ',' 'a' 'b' 'c'
            The output should eq ',a,b,c'
        End

        It 'should prepend strings with prefix.'
            params=(a b c)
            When call prepend_to_all ',' "${params[@]}"
            The output should eq ',a,b,c'
        End
        
        It 'should prepend strings with prefix.'
            params=(a b c)
            When call prepend_to_all ' -f ' "${params[@]}"
            The output should eq ' -f a -f b -f c'
        End

        It 'should prepend strings with prefix.'
            params=(a b)
            When call prepend_to_all '-e ' "${params[@]}"
            The output should eq '-e a-e b'
        End
    End
End
