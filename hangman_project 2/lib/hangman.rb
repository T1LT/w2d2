class Hangman
	DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
    attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

    def self.random_word
        DICTIONARY.sample
    end

    def initialize
        @secret_word = Hangman.random_word
        @guess_word = Array.new(@secret_word.length) { "_" }
        @attempted_chars = []
        @remaining_incorrect_guesses = 5
    end

    def already_attempted?(char)
        @attempted_chars.include? char
    end

    def get_matching_indices(char)
        res = []
        @secret_word.each_char.with_index do |ch, idx|
            res << idx if ch == char
        end
        res
    end

    def fill_indices(char, arr)
        arr.each do |pos|
            @guess_word[pos] = char
        end
        @guess_word
    end

    def try_guess(char)
        if self.already_attempted?(char)
            print "that has already been attempted"
            return false
        else
            temp = self.get_matching_indices(char)
            if temp.length == 0
                @remaining_incorrect_guesses -= 1
            else
                self.fill_indices(char, temp)
            end
            @attempted_chars << char
            return true
        end
    end

    def ask_user_for_guess
        print "Enter a char:"
        input = gets.chomp
        self.try_guess(input)
    end

    def win?
        if @guess_word.join == @secret_word
            print "WIN"
            return true
        end
        false
    end

    def lose?
        if @remaining_incorrect_guesses == 0
            print "LOSE"
            return true
        end
        false
    end

    def game_over?
        if self.win? || self.lose?
            print @secret_word
            return true
        end
        false
    end

end
