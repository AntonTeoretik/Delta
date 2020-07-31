# Лекция 9. Примеры монад.


Напоминание что такое монада:


```Haskell

class Monad (m :: * -> *) where
  return :: a -> m a                -- тривиальная упаковка
  (>>=) :: m a -> (a -> m b) -> m b -- bind, связывания значения с вычислением
  (>>) :: m a -> m b -> m b         -- тривиальное связывание
  fail :: String -> m a


```

## Монада `Maybe`


Монада `Maybe` позволяет тривиальным образом обрабатывать исключения. Если вычисления в какой-то момент совершаются с ошибкой, то эта монада может позволить их обработать без того, чтобы завершать программу.

```Haskell

data Maybe a = Nothing | Just a
  deriving (Eq, Ord)

instance Monad Maybe where
  return x = Just x

  (Just x) >>= k = k x
  Nothing  >>= _ = Nothing
 
  fail _ = Nothing

```

Пример:

```Haskell

findNonEmpty :: [[a]] -> Maybe [a]
findNonEmpty = find (/= [])

findEven :: [Int] -> Maybe Int
findEven = find (\x -> x `mod` 2 == 0)

reverseSafe :: Int -> Maybe Double
reverseSafe 0 = Nothing
reverseSafe x = 1 / (realToFrac x)


-- Без монад:

compositionNonMonad :: [[a]] -> Maybe Int
compositionNonMonad lst = case findNonEmpty lst of
  Nothing -> Nothing
  Just xs -> case findEven xs of
            Nothing -> Nothing
            Just i -> reverseSafe i

-- C монадой:

compositionNonMonad' :: [[a]] -> Maybe Int
compositionNonMonad' x = findNonEmpty lst >>= findEven >>= reverseSafe


-- Или так:

compositionNonMonad'' :: [[a]] -> Maybe Int
compositionNonMonad'' x = do
  xs <- findNonEmpty lst
  i  <- findEven xs 
  reverseSafe i




```

## Монада "список"

Позволяет разветвить вычисления!

```Haskell

data [] a = [] | a : [a]
  deriving (Eq)

instance Monad [] where
  return x = [x]
  xs >>= k = concat (map k xs)
  fail _ = []

```


Примеры:

```Haskell

list = do
  x <- [1,2,3]
  y <- ['a','b','c']
  return (x, y)

>> list
[(1,'a'),(1,'b'),(1,'c'),(2,'a'),(2,'b'),(2,'c'),(3,'a'),(3,'b'),(3,'c')]

```

Аналогичный синтаксис:

```Haskell

list' = [(x, y) | x <- [1,2,3], y <- ['a', 'b', 'c']]

```


## Монада `IO`

Позволяет реализовать ввод вывод в консоль!

```Haskell

putStrLn :: String -> IO () -- вывод строки в консоль
-- тип -- стрелка Клейсли!
-- IO () -- тип -- пустой кортеж. 
-- Потому что не важно упакованное значение, 
-- а важен лишь побочный эффект.

getLine :: IO String
-- Тут нет аргумента, поэтому это "константа с эффектом"
-- Упакованный String (ждет ввода с консоли)

```

Пишем "Hello, World"

```Haskell

main :: IO () -- Просто константа! 
main = do
  putStrLine "Hello, World!"

```


Почему нужны монады? Потому что чистые функции!

Выход из положения -- это сделать так:


```Haskell

getChar :: RealWorld -> (RealWorld, Char) -- Просто константа! 


```
` RealWorld ` -- это тип "реального мира". Нет доступа к реализации.
Функция `main` -- точка входа

## Полезные функции:

`sequence_` -- накапливает эффекты и возвращает только их

```Haskell

>> sequence_ [Just 1, Just 2]
Just ()

>> sequence_ [Just 1, Nothing]
Nothing

>> sequence_ [[1,2], [3,4]]
[(),(),(),()]

>> sequence_ [ putChar 'a',  putChar 'b', putChar '\n' ]
ab


```


`sequence` -- делает из списка монад монаду списка:


```Haskell

>> sequence [ Just 2, Just 3 ]
Just [2,3]

>> sequence [ Just 2, Nothing]
Nothing

>> sequence [ [10,20], [1, 2, 3] ]
[[10,1],[10,2],[10,3],[20,1],[20,2],[20,3]]


>> sequence [getLine, getLine, getLine]
Haskell
is
beautiful
["Haskell","is","beautiful"]



```


`mapM_` -- как `map`, но со стрелкой Клейсли. Только эффект!
`mapM` -- уже реальные вычисления.

```Haskell

mapM_ f = sequence . map f
mapM_ f = sequence_ . map f

```


```Haskell


>> mapM_ (\x -> Just (2*x)) [1,2,3]
Just ()

>> mapM (\x -> Just (2*x)) [1,2,3]
Just [2,4,6]


```


## Что-то о `State`?

modify
execState
get
put
