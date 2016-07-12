module Dragon where

import Data.Char
import Data.List
import Data.Ratio

bitwidth :: (Integral α) => α -> α
bitwidth = ceiling . logBase 2 . (+ 1) . fromIntegral

bottom :: α
bottom = bottom

factorial :: (Eq α, Num α) => α -> α
factorial 0 = 1
factorial 𝑛 = factorial (𝑛 - 1) * 𝑛

fibonacci :: (Integral α, Num β) => α -> β
fibonacci 𝑛 | 𝑛 < 0 = (-1) ^ (𝑛' + 1) * fibonacci 𝑛'
                      where 𝑛' = abs 𝑛
fibonacci 0         = 0
fibonacci 1         = 1
fibonacci 𝑛         = fibonacci (𝑛 - 1) + fibonacci (𝑛 - 2)

fibonacci0, fibonacci1 :: [Integer]
fibonacci0 = 0 : 1 : zipWith (+) fibonacci0 fibonacci1
fibonacci1 = tail fibonacci0

fibonacci0', fibonacci1' :: [Integer]
fibonacci0'@(_:fibonacci1') = 0 : 1 : [𝑎 + 𝑏 | (𝑎,𝑏) <- zip fibonacci0' fibonacci1']

pred' :: (Bounded α, Enum α, Eq α) => α -> α
pred' 𝑥 | 𝑥 == minBound = maxBound
        | otherwise     = pred 𝑥

prune :: Eq α => α -> [α] -> [α]
prune _ [] = []
prune 𝑥 (𝑦:𝑦𝑠) = if 𝑥 == 𝑦 then 𝑦𝑠 else 𝑦 : 𝑦𝑠

round' :: (Integral β, RealFrac α) => α -> β
round' 𝑥 = if abs 𝑟 < 0.5 then 𝑛 else 𝑚
           where (𝑛,𝑟) = properFraction 𝑥
                 𝑚     = if 𝑟 < 0 then 𝑛 - 1 else 𝑛 + 1

splitBy :: Char -> String -> [String]
splitBy 𝑐 = filter (/= [𝑐]) . groupBy (\𝑥 𝑦 -> 𝑥 /= 𝑐 && 𝑦 /= 𝑐)

succ' :: (Bounded α, Enum α, Eq α) => α -> α
succ' 𝑥 | 𝑥 == maxBound = minBound
        | otherwise     = succ 𝑥

solveRPN :: (Read α, RealFloat α) => String -> α
solveRPN = head . foldl parse [] . tok
           where -- 𝑓 𝑥 ... (variadic functions)
                 parse 𝑥𝑠 "maximum" = maximum 𝑥𝑠 : []
                 parse 𝑥𝑠 "minimum" = minimum 𝑥𝑠 : []
                 parse 𝑥𝑠 "product" = product 𝑥𝑠 : []
                 parse 𝑥𝑠 "sum" = sum 𝑥𝑠 : []
                 -- 𝑓 𝑥 𝑦 (binary functions)
                 parse (𝑥:𝑦:𝑧𝑠) "*" = (*) 𝑦 𝑥 : 𝑧𝑠
                 parse (𝑥:𝑦:𝑧𝑠) "+" = (+) 𝑦 𝑥 : 𝑧𝑠
                 parse (𝑥:𝑦:𝑧𝑠) "-" = (-) 𝑦 𝑥 : 𝑧𝑠
                 parse (𝑥:𝑦:𝑧𝑠) "/" = (/) 𝑦 𝑥 : 𝑧𝑠
                 parse (𝑥:𝑦:𝑧𝑠) "^" = (**) 𝑦 𝑥 : 𝑧𝑠
                 parse (𝑥:𝑦:𝑧𝑠) "atan2" = atan2 𝑦 𝑥 : 𝑧𝑠
                 parse (𝑥:𝑦:𝑧𝑠) "logBase" = logBase 𝑦 𝑥 : 𝑧𝑠
                 parse (𝑥:𝑦:𝑧𝑠) "max" = max 𝑦 𝑥 : 𝑧𝑠
                 parse (𝑥:𝑦:𝑧𝑠) "min" = min 𝑦 𝑥 : 𝑧𝑠
                 -- 𝑓 𝑥 (unary functions)
                 parse (𝑥:𝑦𝑠) "abs" = abs 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "acos" = acos 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "acosh" = acosh 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "asin" = asin 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "asinh" = asinh 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "atan" = atan 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "atanh" = atanh 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "ceiling" = (fromInteger . ceiling) 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "cos" = cos 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "cosh" = cosh 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "exp" = exp 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "exponent" = (fromIntegral . exponent) 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "floor" = (fromInteger . floor) 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "log" = log 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "negate" = negate 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "recip" = recip 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "round" = (fromInteger . round) 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "sin" = sin 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "sinh" = sinh 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "sqrt" = sqrt 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "tan" = tan 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "tanh" = tanh 𝑥 : 𝑦𝑠
                 parse (𝑥:𝑦𝑠) "truncate" = (fromInteger . truncate) 𝑥 : 𝑦𝑠
                 -- 𝑓 (nullary functions)
                 parse 𝑥𝑠 "pi" = pi : 𝑥𝑠
                 --parse 𝑥𝑠 "tau" = tau : 𝑥𝑠
                 -- punctuation
                 parse 𝑥𝑠 "," = 𝑥𝑠
                 parse 𝑥𝑠 "." = 𝑥𝑠
                 parse 𝑥𝑠 ";" = 𝑥𝑠
                 -- 𝑛 (numbers)
                 parse 𝑥𝑠 𝑛 = read 𝑛 : 𝑥𝑠

tok :: String -> [String]
tok []                   = []
tok (𝑥:𝑥𝑠) | isControl 𝑥 = tok 𝑥𝑠
tok 𝑠                    = 𝑡 : tok 𝑢
                           where [(𝑡,𝑢)] = lex 𝑠
