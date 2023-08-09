

| 01 | [ArrayList]()
| 02 | [LinkedList]()
| 03 | [DoublyLinkedList]()

https://www.golangprograms.com/golang-program-for-implementation-of-linked-list.html

https://dororongju.tistory.com/108?category=731412


# 연결 리스트(linked list)
배열을 사용하는 경우 메모리 공간이 불필요하게 낭비 될 수 있다.

(1)배열기반리스트
- [배열기반 리스트 예시](https://replit.com/@gwiyeomgo/js-datastruct#addArray.js)


# 포인터 기반 리스트

### 단반향 연결 리스트
javascript는 객체로 구현
- [링크드리스트 -노드 삽입,삭제,조회 예시](https://replit.com/@gwiyeomgo/js-datastruct#linkedListEx.js)
- 처음 추가했을 때 이미지
  <img src="https://user-images.githubusercontent.com/77624394/160768249-9acb7918-6673-49fc-9bb6-1e5a2feb2a9e.jpg" alt="drawing" width="200"/>

### 양방향 연결 리스트




객체를 통해 구현 예시,설명
[참고](https://www.geeksforgeeks.org/linked-list-set-2-inserting-a-node/)
[참고1](https://velog.io/@kimkevin90/Javascript%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%9C-Linked-List-%EA%B5%AC%ED%98%84)


___
### [3.1 연결 리스트 뒤집기](https://leetcode.com/problems/reverse-linked-list/)

* 연결리스트 
  * https://replit.com/@gwiyeomgo/linkedlist#main.go

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|      |  |
|아이디어          | 링크드리스트 생성시 값을 stack 에 추가 <br/> 마지막 요소는 넣지 않고 <br/> 스택에서 요소를 꺼내서 마지막 노드로부터 꺼내어진 요소를 다음으로 연결<br/>  |    |

```go
func reverseList(head *ListNode) *ListNode {
    var prev *ListNode // 이전 노드를 가리킬 포인터
    curr := head      // 현재 노드를 가리킬 포인터

    for curr != nil {
        var nextTemp *ListNode // 다음 노드를 가리킬 포인터
        nextTemp = curr.Next // 다음 노드를 임시로 저장
        curr.Next = prev // 현재 노드의 Next 포인터를 이전 노드로 변경
        prev = curr // 이전 노드 포인터를 현재 노드로 이동
        curr = nextTemp // 현재 노드 포인터를 다음 노드로 이동
    }

    return prev // 뒤집힌 연결 리스트의 head를 반환
}
```
```
대게 데이터를 역순으로 저장하는 경우에 스택을 많이 사용한다

배열은 고정 크기를 갖지만
연결 리스트는 데이터를 동적 크기로 관리하기 때문에
데이터가 얼마나 생성되고 관리돼야 하는지 측정할 수 없는 시스템이나 알고리즘에 활용

연결 리스트는 해당 값을 전근하기 위해 기본적으로 연결 리스트를 처음부터 순회해야 한다


```

```go

/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func reverseList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    stack := []*ListNode{}

    // 연결 리스트의 노드들을 스택에 push
    curr := head
    for curr != nil {
        stack = append(stack, curr)
        curr = curr.Next
    }

    // 스택을 순회하여 노드의 연결 방향 역전
    newHead := stack[len(stack)-1]
    curr = newHead
    for i := len(stack) - 2; i >= 0; i-- {
        curr.Next = stack[i]
        curr = curr.Next
    }
    curr.Next = nil // 마지막 노드의 Next를 nil로 설정

    return newHead
}

```
```
 재귀 호출을 이용하여 연결 리스트를 뒤집습니다. 각 재귀 호출마다 뒤집힌 연결 리스트의 head를 반환받아서 현재 노드의 Next를 설정하여 연결 방향을 역전시킵니다. 이를 통해 입력된 연결 리스트를 역순으로 뒤집은 결과를 반환
//head는 연결 리스트의 첫 번째 노드를 가리키는 포인터
```

```go

func reverseList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    newHead := reverseList(head.Next) // 재귀 호출로 뒤집힌 연결 리스트의 head를 가져옴

    // 현재 노드의 Next를 설정하여 연결 방향 역전
    head.Next.Next = head
    head.Next = nil

    return newHead
}
```


___
### [3.2 순환 검출](https://leetcode.com/problems/linked-list-cycle/)

|                |                                                                                     |(시간/공간)복잡도                |
|:----------------|-------------------------------------------------------------------------------------|----------------------|
|범위,제한사항|                                                                                     ||
|아이디어          | Fast/slow 포인터 패턴: Fast 포인터를 한 번에 2칸씩 움직이고 Slow 포인터를 한 번에 1칸씩 움직이며 서로 만나는 경우가 있는지 확인 |  |

```go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func hasCycle(head *ListNode) bool {
    slow := head
    fast := head
     for fast != nil && fast.Next!= nil {
        slow = slow.Next
        fast = fast.Next.Next
        if slow == fast {
            return true
        }
    }

    return false
}
```
* Fast/slow 포인터 패턴
  * 빠른(Fast) 포인터와 느린(Slow) 포인터를 동시에 사용하면서 서로 다른 속도로 움직이게 하여 데이터 구조를 순회하거나 특정 조건을 확인하는데 유용하게 활용


```go
func hasCycle(head *ListNode) bool {
        hash := make(map[*ListNode]bool)
    for curr := head; curr != nil; curr = curr.Next {
        if hash[curr] {
            return true
        }
        hash[curr] = true
    }
    return false

}
```

___
### [3.3 두 수 더하기](https://leetcode.com/problems/add-two-numbers-ii/)

|                |                          |(시간/공간)복잡도                   |
|:----------------|-------------------------------|-------------------------|
|범위,제한사항|  연결 리스트는 양의 정수로 표현 <br/> 1번째 노드는 가장 높은 자리의 숫자 <br/> 주어진 두 연결 리스트는 무조건 값이 있다 <br/> 0을 제외하고 0으로 시작 하는 숫자는 없다  <br/>    | |
|아이디어          |2개의 연결 리스트를 뒤집는다 뒤집은 연결 리스트를 순회하면서 각 자리수를 더한다 각 자리 숫자를 더하면 새로운 노드를 생성하고 연결 * 첫 노드가 가장 큰 수 이니 가장 작은 숫자부터 진행하려면 연결 리스트의 맨 뒤 숫자부터 시작 => 뒤집는 방법으로 stack 을 사용하기도 함 * 코드에서 reverseList 함수는 연결 리스트를 뒤집는 역할을 하고, addTwoNumbers 함수는 역순으로 더한 결과를 생성하되, 마지막에 결과를 다시 뒤집어서 정순으로 반환하도록 수정되었습니다. 이 코드를 사용하면 주어진 입력에 대해 [7,8,0,7]과 같은 원하는 결과를 얻을 수 있을 것입니다.  |  |

```go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    current := head

    for current != nil {
        nextTemp := current.Next
        current.Next = prev
        prev = current
        current = nextTemp
    }

    return prev
}

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
    reversedL1 := reverseList(l1)
    reversedL2 := reverseList(l2)

    dummy := &ListNode{}
    current := dummy
    carry := 0

    for reversedL1 != nil || reversedL2 != nil || carry > 0 {
        sum := carry

        if reversedL1 != nil {
            sum += reversedL1.Val
            reversedL1 = reversedL1.Next
        }

        if reversedL2 != nil {
            sum += reversedL2.Val
            reversedL2 = reversedL2.Next
        }

        carry = sum / 10
        current.Next = &ListNode{Val: sum % 10}
        current = current.Next
    }

    return reverseList(dummy.Next)
}

```

> carry는 이전 노드에서 발생한 올림을 나타내는 변수이며, sum은 현재 위치의 두 연결 리스트 노드의 값과 이전 노드에서 발생한 올림을 합친 값입니다.
 예를 들어, 두 노드의 값이 8과 7이며 이전 노드에서의 올림(carry)이 1이라면:
sum은 8 + 7 + 1 = 16이 됩니다.
carry는 sum을 10으로 나눈 몫이므로 1이 됩니다.
sum % 10은 현재 노드의 값을 나타내며, 여기서는 6이 됩니다.
따라서, 새로운 노드를 생성할 때 sum % 10로 현재 자릿수의 값을 저장하고, 다음 노드에는 올림 값인 carry를 전달해줍니다. 이렇게 함으로써 올림을 올바르게 처리하고, 정확한 결과를 얻을 수 있습니다.




