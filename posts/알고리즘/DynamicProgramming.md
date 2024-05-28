# 동적 프로그래밍

하나의 문제를 작은 단위로 쪼개어 해결하고 결과를 수집 및 병합하여 최종 결론을 만들어내는 일련의 과정
쪼개어진 문제를 해결해가는 과정에서 연산의 결괏값을 저장하고
그 이후엔 중복된 연산의 저장된 값을 꺼내어 쓸 수 있다

모든 경우의 수를 조합하면서 확인하는 과정을 가지는 문제는
동적 프로그래밍 접근법이 가능하다

### 메모이제이션을 통해 피보나치 수열


### 최대구간의 합



[단계별 동적 프로그래밍 ](https://www.hackerrank.com/contests/srin-aadc03/challenges/classic-01-knapsack/problem)

[동일 합으로 배열 분할 문제](https://leetcode.com/problems/partition-equal-subset-sum/)
```go
package main

import (
	"fmt"
)

func canPartition(nums []int) bool {
	// 배열의 합을 계산합니다.
	sum := 0
	for _, num := range nums {
		sum += num
	}
	
	// 합이 홀수인 경우 배열을 두 개의 부분 배열로 분할하여 동일한 합을 만들 수 없습니다.
	if sum%2 != 0 {
		return false
	}

	// dp[i][j]는 첫 번째 i개의 요소로 합이 j가 가능한지를 나타내는 불리언 배열입니다.
	halfSum := sum / 2
	dp := make([][]bool, len(nums)+1)
	for i := range dp {
		dp[i] = make([]bool, halfSum+1)
	}

	// 초기값 설정: 합이 0인 경우는 항상 가능합니다.
	for i := 0; i <= len(nums); i++ {
		dp[i][0] = true
	}

	// 동적 프로그래밍을 사용하여 배열을 분할 가능한지 확인합니다.
	for i := 1; i <= len(nums); i++ {
		for j := 1; j <= halfSum; j++ {
			dp[i][j] = dp[i-1][j]
			if j >= nums[i-1] {
				dp[i][j] = dp[i][j] || dp[i-1][j-nums[i-1]]
			}
		}
	}

	// 배열을 두 개의 부분 배열로 분할하여 동일한 합을 만들 수 있는지 여부를 반환합니다.
	return dp[len(nums)][halfSum]
}

func main() {
	nums := []int{1, 5, 11, 5}
	fmt.Println(canPartition(nums)) // Output: true (11 = 1 + 5 + 5, 11 = 11)
}

```

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




___


[최장 공통부분 수열](https://leetcode.com/problems/longest-consecutive-sequence/)

해시 맵 (Hash Map): numSet이라는 해시 맵을 사용하여 연속된 요소를 저장하고 중복을 피하며 O(1) 시간 복잡도로 요소에 접근할 수 있도록 합니다. 이 자료구조는 두 가지 목적을 가지고 있습니다: (1) 요소의 존재 여부를 빠르게 확인하고, (2) 이미 처리한 요소를 추적하는 데 사용됩니다.

단순 반복 (Iteration): 주어진 배열 nums를 두 번 반복하며 알고리즘을 수행합니다. 첫 번째 반복에서는 numSet에 요소들을 추가하고, 두 번째 반복에서는 각 요소를 기준으로 연속된 요소의 길이를 계산합니다.

```go
func longestConsecutive(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	// 연속된 요소를 저장하기 위한 set을 생성하고 요소들을 추가합니다.
	numSet := make(map[int]bool)
	for _, num := range nums {
		numSet[num] = true
	}

	maxLength := 0

	// 각 요소에 대해 연속된 요소의 수를 찾습니다.
	for _, num := range nums {
		if !numSet[num-1] { // 현재 요소의 이전 요소가 없는 경우에만 시작할 수 있습니다.
			currentNum := num
			currentLength := 1

			// 현재 요소를 기준으로 연속된 요소의 수를 세어 나갑니다.
			for numSet[currentNum+1] {
				currentNum++
				currentLength++
			}

			// 최대 길이 갱신
			if currentLength > maxLength {
				maxLength = currentLength
			}
		}
	}

	return maxLength
}
```

# [피보나치수](https://school.programmers.co.kr/learn/courses/30/lessons/12945)
```
function solution(n) {
const mod = 1234567;
const fib = [0, 1];

    for (let i = 2; i <= n; i++) {
        fib[i] = (fib[i - 1] + fib[i - 2]) % mod;
    }

    return fib[n];
}
```

결과를 더 작은 값으로 제한하기 위해 나머지 연산을 사용하는 것이 일반적인 방법
1234567로 나눈 나머지를 반환하여 결과를 제한
결과가 항상 양수이면서 정수형의 범위를 초과하지 않는 값을 얻을 수 있음
