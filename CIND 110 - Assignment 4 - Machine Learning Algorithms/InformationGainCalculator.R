gain = function(entropy, weight1, fraction1, fraction2, weight2 = 0, fraction3 = 1, fraction4 = 1, weight3 = 0, fraction5 = 1, fraction6 = 1, weight4 = 0, fraction7 = 1, fraction8 = 1) {
  if (fraction1 == 0) fraction1 = 1
  if (fraction2 == 0) fraction2 = 1
  if (fraction3 == 0) fraction3 = 1
  if (fraction4 == 0) fraction4 = 1
  if (fraction5 == 0) fraction5 = 1
  if (fraction6 == 0) fraction6 = 1
  if (fraction7 == 0) fraction7 = 1
  if (fraction8 == 0) fraction8 = 1
  
  a = entropy - (weight1 * ((-fraction1 * log2(fraction1)) - (fraction2 * log2(fraction2)))) - (weight2 * ((-fraction3 * log2(fraction3)) - (fraction4 * log2(fraction4)))) - (weight3 * ((-fraction5 * log2(fraction5)) - (fraction6 * log2(fraction6)))) - (weight4 * ((-fraction7 * log2(fraction7)) - (fraction8 * log2(fraction8))))
  return(a)
}