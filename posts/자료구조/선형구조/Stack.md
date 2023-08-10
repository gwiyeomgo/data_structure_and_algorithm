


스택 자료구
filo
fist in last out


리스트나 deque 로 구현


리스트는 연속적인 메모리 블록을 할당하여 공간을 하나씩 채워가는 형태고
deque 은 이중 연결 리스트로 데이터 연결을 지원한다

deque은 연결 리스트 구조여서 앞에서부터 접근하기 때문에 리스트의 인덱싱보다 조금 느리다
또한 메모리가 허용하는 한 계속 추가할 수 있으나 리스트는 만들어진 공간이 차면 추가적으로 확장해 주는 작업이 필요하다

# [슬라이스 기반 stack](https://replit.com/@gwiyeomgo/stack#main.go)
```go

package main

import "fmt"

type Stack struct {
    data []interface{}
}

func (s *Stack) Push(item interface{}) {
    s.data = append(s.data, item)
}

func (s *Stack) Pop() interface{} {
    if s.IsEmpty() {
        return nil
    }
    lastIndex := len(s.data) - 1
    popped := s.data[lastIndex]
    s.data = s.data[:lastIndex]
    return popped
}

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