module Constants where

_FORCE_LINE_LENGTH = 30 :: Int

_STEP = 0.01 --промежуток времени который проходит между шагами idle

--тут определить всякие физические переменные:
_RADIUS = 0.08 :: Double -- радиус сферы которая рисует частицы
_CUBELENGTH = 5 :: Double -- длина стороны куба который для generatePointsFromCube
_POINTDIST = 0.01 :: Double -- растояние между точками на силовой линии
_FORCELINENUM = 100 :: Int -- количество силовых линий
_GENERATECUBEPOINTS = 10 :: Int --что-то про generatePointsFromCube, не знаю что делает
_CURRENT = (-3) :: Double --ток в магнитном поле
_NUMBER = 100 :: Int --число которое берёт circuitFromFunction - не знаю, что делает
_CHARGE = 1 :: Double