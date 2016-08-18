#!/usr/bin/runhaskell -i/home/nathan/code/yentl/src/

import Yentl


fig :: Fig (PoincareDisc ConReal) ()
fig = do
  let c t = path (CirclePath (0,0) (2/3) (1/4) 1) t
  p0 <- coords $ c (0/7)
  p1 <- coords $ c (1/7)
  p2 <- coords $ c (2/7)
  p3 <- coords $ c (3/7)
  p4 <- coords $ c (4/7)
  p5 <- coords $ c (5/7)
  p6 <- coords $ c (6/7)
  let
    ps =
      [ (p0,p1), (p0,p2), (p0,p3), (p0,p4), (p0,p5), (p0,p6)
      , (p1,p2), (p1,p3), (p1,p4), (p1,p5), (p1,p6)
      , (p2,p3), (p2,p4), (p2,p5), (p2,p6)
      , (p3,p4), (p3,p5), (p3,p6)
      , (p4,p5), (p4,p6)
      , (p5,p6)
      ]
    foo (x,y) = line x y >>= pen ultrathin
  sequence_ $ map foo ps
  return ()

vOpts = discView


main :: IO ()
main = writeImg fig EPS vOpts "" "cover.eps" $
  "Drawing of a triangle in the poincare plane.\n"
