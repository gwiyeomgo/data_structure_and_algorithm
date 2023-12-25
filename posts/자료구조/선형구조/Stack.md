


# 스택 
가장 최근에 추가한 요소만 제거할 수 있는 선형 자료구조

- lifo (후입 선출)
  last in first out
  - 마지막에 추가한 요소부터 꺼낼 수 있다

제한된 스택 : 추가할 수 있는 요소의 수에 제한이 있는 스택
무제한 스택 :추가할 수 있는 요소의 수에 제한이 없는 스택


# [슬라이스 기반 stack](https://replit.com/@gwiyeomgo/stack#main.go)
```

package main

import "fmt"

type Stack struct {
    data []interface{}
}
// 스택에 요소를 추가하는 것
func (s *Stack) Push(item interface{}) {
    s.data = append(s.data, item)
}
//스택에 마지막으로 추가한 요소를 꺼내는 것
func (s *Stack) Pop() interface{} {
    if s.IsEmpty() {
        return nil
    }
    lastIndex := len(s.data) - 1
    popped := s.data[lastIndex]
    s.data = s.data[:lastIndex]
    return popped
}
//스택에 마지막에 있는 요소를 제거하지 않고 접근
func (s *Stack) Peek() interface{} {
    if s.IsEmpty() {
        return nil
    }
    return s.data[len(s.data)-1]
}

func (s *Stack) IsEmpty() bool {
    return len(s.data) == 0
}

```

___
### [4.1 유효한 괄호 검증](https://leetcode.com/problems/valid-parentheses/)

|                |                                                                                                                                      | (시간/공간)복잡도 |
|:----------------|--------------------------------------------------------------------------------------------------------------------------------------|------------|
|범위,제한사항| 1.문자열 입력 <br/> 2. (),{},[] <br/> 3.비어 있는 문자열은 유효하다고 판단  <br/> 4. (,{,[ 경우 이 괄호는 닫는 괄호가 나올 때까지 스택에 남아야 한다                             |    O(N)        |
|아이디어| 1. 요소 stack 에 담고  <br/> 2.마지막 요소와 비교   <br/> * 짝이 맞으면 pop  <br/> * 짝이 맞지 않으면 추가  <br/> 3. 모든 요소를 돌고 stack 길이가 0이면 true, 1개이상이면 false | O(N)       |

```go
type Stack struct {
    data []rune
}

func (s *Stack) Push(item rune) {
    s.data = append(s.data, item)
}

func (s *Stack) Pop() rune {
    if s.IsEmpty() {
        return 0
    }
    lastIndex := len(s.data) - 1
    popped := s.data[lastIndex]
    s.data = s.data[:lastIndex]
    return popped
}

func (s *Stack) Peek() rune {
    if s.IsEmpty() {
        return 0
    }
    return s.data[len(s.data)-1]
}

func (s *Stack) IsEmpty() bool {
    return len(s.data) == 0
}

func isValid(s string) bool {
    stack := Stack{}
    
    for _, ch := range s {
        d := rune(ch)
        
        if d == '(' || d == '{' || d == '[' {
            stack.Push(d)
        } else if (d == ')' && stack.Peek() == '(') ||
                  (d == '}' && stack.Peek() == '{') ||
                  (d == ']' && stack.Peek() == '[') {
            stack.Pop()
        } else {
            return false
        }
    }
  
    return stack.IsEmpty()
}

```



___
### [4.3 permutation 순열](https://leetcode.com/problems/permutations/)

|                |                                                            |(시간/공간)복잡도                    |
|:----------------|------------------------------------------------------------|--------------------------|
|범위,제한사항|                                                            |  |
|아이디어| 스택에 쌓아둔 숫자들을 꺼내어 모든 가능한 조합을 만들어가는 과정을 반복하며 순열을 생성합니다.<br/> 여기서 스택은 이미 선택한 숫자들을 추적하고, 백트래킹을 위해 사용됩니다.<br/> 이전 단계로 돌아가면서 조합을 생성하고 탐색하는 방식이기 때문에, <br/> 재귀를 사용하지 않고도 순열을 구할 수 있게 되었습니다.<br/> 이러한 방식은 스택을 활용하여 재귀적인 구조를 명시적으로 구현하지 않고도 순열 문제를 해결하는 좋은 방법 중 하나입니다.|  |

```go
package main

import "fmt"

func permute(nums []int) [][]int {
	result := [][]int{}
	stack := []int{}
	used := make([]bool, len(nums))

	for len(stack) > 0 || len(nums) > 0 {
		if len(stack) == len(nums) {
			// 스택에 모든 요소가 쌓였을 때 순열을 결과에 추가
			current := make([]int, len(stack))
			copy(current, stack)
			result = append(result, current)
		}

		for i, num := range nums {
			if used[i] {
				continue
			}

			// 숫자를 사용하고 스택에 추가
			used[i] = true
			stack = append(stack, num)

			// 다음 숫자로 이동
			nums = nums[:i+copy(nums[i:], nums[i+1:])]

			// 스택을 기반으로 백트래킹하여 순열을 생성
			break
		}

		// 스택에서 마지막 요소 제거 및 해당 숫자의 사용 표시 해제
		if len(stack) > 0 {
			last := stack[len(stack)-1]
			used[numIndex(nums, last)] = false
			stack = stack[:len(stack)-1]
		}
	}

	return result
}

func numIndex(nums []int, num int) int {
	for i, n := range nums {
		if n == num {
			return i
		}
	}
	return -1
}

func main() {
	nums := []int{1, 2, 3}
	result := permute(nums)
	fmt.Println(result)
}


```

### https://leetcode.com/problems/reverse-string/