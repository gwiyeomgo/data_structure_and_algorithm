

재귀는 어떤 함수 내에서 자신을 다시 호출하는 것
분할 정복 알고리즘에 적용 가능


### 재귀(recursion)를 사용하여 배열의 요소들을 모두 더하는 함수

```go
package main

import (
	"fmt"
)

func sumElememts(nums []int) int{
	if len(nums)  == 1 {
		return nums[0]
	}
	return nums[0] + sumElememts(nums[1:])
}

func main() {
	nums :=   []int{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
	fmt.Println(sumElememts(nums))
}
//120
```

___
### [4.2 계단오르기](https://leetcode.com/problems/climbing-stairs/)
*  전형적인 다이나믹 프로그래밍 문제

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|    |  |
|아이디어| 메모이제이션을 사용 |  |

```go
func climb(n int,i int) int {
	  if n == i {
        return 1 
    }
    if n < i {
        return 0 
    }
    return climb(n,i+1) + climb(n,i+2) 
}

func climbStairs(n int) int {
  return climb(n,0)
} 
```
재귀 호출을 사용하여 문제를 풀려고 시도했으나
큰 입력값에 대해서는 타임아웃 발생
메모이제이션을 사용하여 중복 계산을 피하거나 반복문을 사용하여 효율적으로 구현이 필요
* 메모이제이션
```go
func climb(n int, i int, memo map[int]int) int {
    if n == i {
        return 1
    }
    if n < i {
        return 0
    }
    
    if val, ok := memo[i]; ok {
        return val
    }
    
    memo[i] = climb(n, i+1, memo) + climb(n, i+2, memo)
    return memo[i]
}

func climbStairs(n int) int {
    memo := make(map[int]int)
    return climb(n, 0, memo)
}

```
https://jeonghwan-kim.github.io/2023/04/17/usememo-usecallback
https://soyoonique.tistory.com/59

* 반복문 사용
```go
func climbStairs(n int) int {
    if n <= 2 {
        return n
    }
    
    prev1, prev2 := 1, 2
    for i := 3; i <= n; i++ {
        curr := prev1 + prev2
        prev1, prev2 = prev2, curr
    }
    
    return prev2
}

```

___
### [4.3 permutation 순열](https://leetcode.com/problems/permutations/)

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|    |  |
|아이디어| 문자열을 하나만 남을 때까지 분할하고, 마지막 문자와 이전에 남겨진 조합을 결합하여 순열을 찾는 방식을 사용 |  |

```go
package main

import "fmt"

func permute(nums []int) [][]int {
  if len(nums) == 0 {
    return [][]int{{}} // 빈 배열의 순열은 자기 자신입니다.
  }

  result := [][]int{}
  for i, num := range nums {
    // num을 제외한 나머지 숫자들로부터 재귀적으로 순열을 찾습니다.
    remaining := append(append([]int{}, nums[:i]...), nums[i+1:]...)
    permutations := permute(remaining)
    for _, p := range permutations {
      // num과 이전에 구한 순열을 결합하여 결과에 추가합니다.
      perm := append([]int{num}, p...)
      result = append(result, perm)
    }
  }
  return result
}

func main() {
  nums := []int{1, 2, 3}
  result := permute(nums)
  fmt.Println(result)
}

```
* 분할 정복
  > 문제를 작은 여러개의 문제로 쪼갠 후 재귀적으로 각 문제를 해결한 후 이를 다시 합쳐 원래 문제를 해결하는 방법

___
### [4.4 동전 교환](https://leetcode.com/problems/coin-change/)

|                |                                                                                   |(시간/공간)복잡도                    |
|:----------------|-----------------------------------------------------------------------------------|--------------------------|
|범위,제한사항|                                                                                   |  |
|아이디어| 주어진 코드는 동전 반환 문제를 해결하는 것을 목표로 함. <br/> coinChange 함수와 change 함수를 사용하여 문제를 풀이함.<br/> change 함수는 메모이제이션을 활용하여 중복 계산을 피하며, 재귀 호출을 사용함.<br/> 주어진 동전 배열과 금액으로 가장 적은 개수의 동전으로 반환하는 방법을 찾음.<br/>change 함수 호출 시 최초 거스름돈 값을 빼서 다음 호출로 전달하는 방식으로 구현됨.(재귀적으로 최적의 답을 탐색)|  |

* 메모이제이션(Memoization)을 사용하여 중복 계산을 피하고, 계산한 결과를 메모리에 저장해 두었다가 필요할 때 재사용하는 방식

```go
package main

import (
	"fmt"
	"math"
)

func coinChange(coins []int, amount int) int {
	return change(coins, amount, make(map[int]int))
}

func change(coins []int, amount int, memo map[int]int) int {
	if amount == 0 {
		return 0
	}
	if amount < 0 {
		return -1
	}

	if count, found := memo[amount]; found {
		return count
	}

	minCoins := math.MaxInt32
	for _, coin := range coins {
		remainingChange := change(coins, amount-coin, memo)
		if remainingChange != -1 {
			minCoins = min(minCoins, remainingChange+1)
		}
	}

	if minCoins == math.MaxInt32 {
		memo[amount] = -1
	} else {
		memo[amount] = minCoins
	}

	return memo[amount]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func main() {
	coins1 := []int{1, 2, 5}
	amount1 := 11
	fmt.Printf("Coins: %v, Amount: %d, Fewest Coins: %d\n", coins1, amount1, coinChange(coins1, amount1))

	coins2 := []int{2}
	amount2 := 3
	fmt.Printf("Coins: %v, Amount: %d, Fewest Coins: %d\n", coins2, amount2, coinChange(coins2, amount2))

	coins3 := []int{1}
	amount3 := 0
	fmt.Printf("Coins: %v, Amount: %d, Fewest Coins: %d\n", coins3, amount3, coinChange(coins3, amount3))
}

```

