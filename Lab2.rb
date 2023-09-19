def rpn_ref(exp)
  precedence = {
    '+' => 1,
    '-' => 1,
    '*' => 2,
    '/' => 2
  }
  output = []
  stack = []

  exp.each_char do |char|
    if char.match?(/\d/)
      output << char
    elsif char == '('
      stack.push(char)
    elsif char == ')'
      while stack.last != '('
        output << stack.pop
      end
      stack.pop
    elsif precedence.key?(char)
      while !stack.empty? && stack.last != '(' && precedence[char] <= precedence[stack.last]
        output << stack.pop
      end
      stack.push(char)
    end
  end

  output.concat(stack.reverse)
  return output.join(' ')
end

loop do
  puts 'Enter math expression (or "exit"): '
  input = gets.chomp

  if input.downcase == 'exit'
    break
  end
  rpn = rpn_ref(input)
  puts "RPN: #{rpn}"
end
