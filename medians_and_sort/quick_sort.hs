import Control.Monad.ST
import Data.STRef
import Control.Monad
import Control.Monad.State
import Data.Array
import Data.Array.ST
import System.Random


generateArray :: Random r => Int -> r -> r -> IO (Array Int r)
generateArray size min max =
    getStdGen >>= return . listArray (0, size - 1) . randomRs (min, max)


swapArrElem :: (Ord a) => STArray s Int a -> Int -> Int -> ST s ()
swapArrElem arr lhs rhs = do
  l <- readArray arr lhs
  r <- readArray arr rhs
  writeArray arr lhs r
  writeArray arr rhs l


partitionLoop :: (Ord a) => STArray s Int a -> a -> Int -> StateT Int (ST s) ()
partitionLoop arr pivotElement i = do
  pivotIndex <- get
  thisElement <- lift $ readArray arr i
  when (thisElement <= pivotElement) $ do
    lift $ swapArrElem arr i pivotIndex
    put (pivotIndex + 1)


partition :: (Ord a) => STArray s Int a -> Int -> Int -> ST s Int
partition arr start end = do
  pivotElement <- readArray arr start
  let pivotIndex_0 = start + 1
  finalPivotIndex <- execStateT
    (mapM (partitionLoop arr pivotElement) [(start+1)..(end-1)])
    pivotIndex_0
  swapArrElem arr start (finalPivotIndex - 1)
  return $ finalPivotIndex - 1


quickSort :: (Ord a) => Array Int a -> Array Int a
quickSort inputArr = runSTArray $ do
  stArr <- thaw inputArr
  let (minIndex, maxIndex) = bounds inputArr
  quickSortHelper minIndex (maxIndex + 1) stArr
  return stArr


quickSortHelper :: (Ord a) => Int -> Int -> STArray s Int a -> ST s ()
quickSortHelper start end stArr = when (start + 1 < end) $ do
  pivotIndex <- partition stArr start end
  quickSortHelper start pivotIndex stArr
  quickSortHelper (pivotIndex + 1) end stArr