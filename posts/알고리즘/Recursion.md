

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
|아이디어|문자열 하나씩 분리 => 호출 스택에 저장 => 다시 꺼내서 단어 순서를 바꿈 <br/> 문자열을 하나만 남을 때까지 잘라내 마지막 문자와 이전 스택에 남겨진 조합을 만드는 분할 정복 |  |

```go

```
* 분할 정복
  > 문제를 작은 여러개의 문제로 쪼갠 후 재귀적으로 각 문제를 해결한 후 이를 다시 합쳐 원래 문제를 해결하는 방법