module Main ( main ) where

import Data.Char
import Data.List
import Dragon
import Network.URI

-- impure code --
main :: IO ()
main = interact $ unlines . sortBy compareURI . nub . lines

-- pure code --
compareURI :: String -> String -> Ordering
compareURI 𝑥 𝑦 = (parseURI 𝑥' `uriCompare` parseURI 𝑦') `mappend`
                 (𝑥' `compare` 𝑦')
                 where 𝑥' = map toLower 𝑥
                       𝑦' = map toLower 𝑦

deepSplit :: Char -> Char -> Char -> String -> [[[String]]]
deepSplit 𝑥 𝑦 𝑧 = map (map (map padNum . massage . splitBy 𝑧) . splitBy 𝑦) . splitBy 𝑥
                  where massage 𝑠@(𝑥:𝑦:[]) = if all isDigit 𝑥 && all isDigit 𝑦
                                             then [(padNum 𝑥) ++ "." ++ 𝑦]
                                             else 𝑠
                        massage 𝑠 = 𝑠

pad :: Int -> Char -> String -> String
pad 𝑙 𝑐 𝑠 = if length 𝑠 < 𝑙
            then 𝑐 : pad (𝑙 - 1) 𝑐 𝑠
            else 𝑠

padNum :: String -> String
padNum 𝑠 = if length 𝑠 > 0 && all isDigit 𝑠
           then pad 40 '0' 𝑠
           else 𝑠

uriAuthorityCompare :: Maybe URIAuth -> Maybe URIAuth -> Ordering
uriAuthorityCompare (Just 𝑥) (Just 𝑦) = (uriRegName 𝑥 `uriRegNameCompare` uriRegName 𝑦) `mappend`
                                        (uriPort 𝑥 `uriPortCompare` uriPort 𝑦) `mappend`
                                        (uriUserInfo 𝑥 `uriUserInfoCompare` uriUserInfo 𝑦)
uriAuthorityCompare 𝑥 𝑦               = 𝑥 `compare` 𝑦

uriCompare :: Maybe URI -> Maybe URI -> Ordering
uriCompare (Just 𝑥) (Just 𝑦) = (uriScheme 𝑥 `uriSchemeCompare` uriScheme 𝑦) `mappend`
                               (uriAuthority 𝑥 `uriAuthorityCompare` uriAuthority 𝑦) `mappend`
                               (uriPath 𝑥 `uriPathCompare` uriPath 𝑦) `mappend`
                               (uriQuery 𝑥 `uriQueryCompare` uriQuery 𝑦) `mappend`
                               (uriFragment 𝑥 `uriFragmentCompare` uriFragment 𝑦)
uriCompare 𝑥 𝑦               = 𝑥 `compare` 𝑦

uriFragmentCompare :: String -> String -> Ordering
uriFragmentCompare = compare

uriPath' :: String -> [[[String]]]
uriPath' = deepSplit '/' '-' '.'

uriPathCompare :: String -> String -> Ordering
uriPathCompare 𝑥 𝑦 = (uriPath' 𝑥 `compare` uriPath' 𝑦)

uriPort' :: String -> Int
uriPort' (':':𝑥𝑠) = read 𝑥𝑠
uriPort' _        = -1

uriPortCompare :: String -> String -> Ordering
uriPortCompare 𝑥 𝑦 = (uriPort' 𝑥 `compare` uriPort' 𝑦)

uriQuery' :: String -> [[[String]]]
uriQuery' ('?':𝑥𝑠) = sort . deepSplit '&' '=' '.' $ 𝑥𝑠
uriQuery' _        = []

uriQueryCompare :: String -> String -> Ordering
uriQueryCompare 𝑥 𝑦 = (uriQuery' 𝑥 `compare` uriQuery' 𝑦)

uriRegName' :: String -> [String]
uriRegName' = reverse . prune "www" . splitBy '.'

uriRegNameCompare :: String -> String -> Ordering
uriRegNameCompare 𝑥 𝑦 = (uriRegName' 𝑥 `compare` uriRegName' 𝑦)

uriScheme' :: String -> String
uriScheme' 𝑎 = if 𝑎 == "https:"
               then "http:"
               else 𝑎

uriSchemeCompare :: String -> String -> Ordering
uriSchemeCompare 𝑥 𝑦 = (uriScheme' 𝑥 `compare` uriScheme' 𝑦)

uriUserInfo' :: String -> String
uriUserInfo' = reverse . prune '@' . reverse

uriUserInfoCompare :: String -> String -> Ordering
uriUserInfoCompare 𝑥 𝑦 = (uriUserInfo' 𝑥 `compare` uriUserInfo' 𝑦)
