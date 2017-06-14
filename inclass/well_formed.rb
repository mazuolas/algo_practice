def well_formed(str)
  brackets = []
  openers = '{[('
  str.split("").each do |char|
    next unless '{[()]}'.include?(char)
    if openers.include?(char)
       brackets << char
     else
       case char
       when ')'
         return false unless brackets.last == '('
       when ']'
         return false unless brackets.last == '['
       when '}'
         return false unless brackets.last == '{'
       end
       brackets.pop
     end
   end
   brackets.empty?
 end
 p well_formed('{[(asdf)asdf]sadf}')
 p well_formed('{[(sdfa)asdf}')
