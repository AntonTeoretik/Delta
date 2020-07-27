# Лекция 7, собственные классы типов, instance. Функторы.

# Собственные классы типов и instance

В Haskell можно создавать собственные классы типов. Для этого нужно указать название и список функций, которые для этого класса типов должны быть определены. 

Часто, после этого добавляют необходимые аксиомы, которым должны удовлетворять эти функции, однако Haskell не умеет отслеживать выполнение аксиом, поэтому их выполнение остается на совесть программисту. Давайте создадим класс `Group`, который реализует идею математической группы -- т.е. множества с одной обратимой ассоциативной операцией и нейтральным элементом. 

```Haskell

infixl 5 *.
class Group a where
  (*.) :: a -> a -> a -- это наша операция.
  invert  :: a -> a   -- для каждого элемента можно вернуть обратный.
  neutral :: a        -- нейтральный элемент.

-- Аксиомы группы
-- (*.) ассоциативна -- x *. y *. z = (x *. y) *. z = x *. (y *. z),
-- neutral *. x == x
-- x *. neutral == x
-- x *. (invert x) == neutral
-- (invert x) *. x == neutral

```

Для того, чтобы сделать какой-либо тип представителем класса `Grouph` надо написать ключевое слово `instance`, далее название нашего класса типов и названия того типа, который мы хотим реализовать. Пример -- `Integer` является группой по сложению:

```Haskell

instance Group Integer where
  neutral = 0
  invert = negate
  (*.) = (+)

--
>> 1 *. 4
5
>> invert 4
-4
>> neutral :: Integer
0

```

Можно реализовать тривиальную группу из одного элемента, т.е. реализовать для типа `()`

```Haskell

instance Group () where
  neutral = ()
  invert = id
  () *. () = ()

--
>> () *. ()
()
>> invert ()
()
>> neutral :: ()
()

```

Можно реализовывать представителей для встроенных классов типов. Например, допустим, у нас есть тип `Complex`, реализующий комплексные числа. Мы хотим сделать его представителем класса типов `Num` и `Show`, т.е. уметь складывать, вычитать и умножать комплексные числа, а также показывать их в консоль.

Сделаем это так:


```Haskell

data Complex = Complex Double Double
  deriving (Eq)

instance Show Complex where
  show (Complex x y) = show x ++ (if y >= 0 then " + i*" else " - i*") ++ show (abs y) -- реализация красивого Show для комплексных чисел.


instance Num Complex where
  (+) (Complex x1 y1) (Complex x2 y2) = Complex (x1 + x2) (y1 + y2)
  negate (Complex x y) = Complex (-x) (-y)
  (*) (Complex x1 y1) (Complex x2 y2) = Complex (x1 * x2 - y1 * y2) (x1 * y2 + x2* y1 ) 
  abs x = x -- это приходится реализовывать как-то, у нас -- бессмысленно.
  signum x = 1 -- аналогичено
  fromInteger n = Complex (fromInteger n) 0 

---

>> Complex (-1) 2 + Complex 2 (-1)
1.0 + i*1.0
>> Complex (-1) (-2) * Complex 2 (-1)
-4.0 - i*3.0
>> fromInteger 2 :: Complex 
2.0 + i*0.0



```

Можно также реализовать деление комплексных чисел. В этом случае надо еще сделать тип `Complex` представителем типа `Fractional`:

```Haskell

instance Fractional Complex where
  (/) z (Complex x2 y2) = alpha * z * Complex x2 (negate y2)
    where
      alpha = ( fromRational . toRational . (1/) $ x2^2 + y2^2)  ::Complex
  fromRational x = Complex (fromRational x) 0 

>> let i = Complex 0 1
>> i / i
1.0 + i*0.0
>> i * i
-1.0 + i*0.0

```