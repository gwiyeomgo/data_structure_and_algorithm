
# 트리
* 계층적 데이터를 저장하고 활용하기 위한 자료구조
* 비선형적 자료 구조
  * 루트(root):가장 꼭대기에 있는 노드
  * 자식노드 : 루트 노드 아래로 연결되는 링크드 노드
  * 잎새노드(leaf)=리프트노드 :트리의 마지막 노드,즉 자식 노드가 없는 노드
  * 높이:높이는 잎새 노드로부터의 경로 길이
  * 깊이:깊이는 루트에서 노드로의 경로 길이
  * 에지: 트리에서 두 노드 사이의 연결
  * 서브트리 : 노드(루트 노드 제외) 와 그 자손 노드


트리를 탐색해 얻고자 하는 값이 어떤 것이고,어떤 식으로 순회해야 효과적으로 답을 찾을 수 있는지 고민

## * 이진 탐색 트리
각각의 노드가 최대 두 개의 자식만 가질 수 있고
각 노드의 값이 왼쪽에 있는 서브트리의 어떤 값보다 크고,
오른쪽 서브트리에 있는 어떤 값보다 작도록 정렬한 자료구조
이진 탐색 트리는 중복값을 저장 할 수 없다
이진 탐색 트리는 백트래킹 필요

해시 테이블보다 실행 시간이 느리지만
계층 표현이 가능함
디렉터리 프로그램..

문서 객체 모델 (dom)이란 xml,html 문서를 트리로 나타내는 언어 독립적 인터페이스


* 너비 우선 이동

레벨의 순서대로 모든 노드에 방문하는 방법

루트 0
자식 레벨 1
손자 레벨 2


* 너비 우선 탐색
  너비 우선 이동을 사용하는 탐색 방법


* 깊이 우선 이동
  이진 트리의 모든 노드를 한 방향으로 방문한 후 다음 형제 노드로 이동
  전위,후위,중위



* 이진 트리 뒤집기 = 이진 트리 반전

모든 노드의 좌우를 바꾸는 것
오른쪽 노드는 전부 왼쪽 노드가 되고
왼쪽 노드는 전부 오른쪽 노드가 된다.


## * 이진 트리
각각의 노드가  최대 2개인 자식 노드만 가질 수 있는 트리 자료구조

> 전위 순회(preorder) : root - l -r

> 중위 순회(inorder) : l - root- r

> 후위 순회(postorder) : l -r -root
   
```go
package main

import (
	"fmt"
)

// TreeNode는 이진 트리 노드를 나타내는 구조체입니다.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

// NewTreeNode는 새로운 TreeNode를 생성하는 함수입니다.
func NewTreeNode(val int) *TreeNode {
	return &TreeNode{Val: val, Left: nil, Right: nil}
}

// Insert는 이진 트리에 값을 삽입하는 함수입니다.
func (root *TreeNode) Insert(val int) *TreeNode {
	if root == nil {
		return NewTreeNode(val)
	}

	if val < root.Val {
		root.Left = root.Left.Insert(val)
	} else {
		root.Right = root.Right.Insert(val)
	}

	return root
}

// PreOrderTraversal는 이진 트리를 전위 순회하는 함수입니다.
func (root *TreeNode) PreOrderTraversal() {
	if root == nil {
		return
	}
	fmt.Print(root.Val, " ")
	root.Left.PreOrderTraversal()
	root.Right.PreOrderTraversal()
}

// InOrderTraversal는 이진 트리를 중위 순회하는 함수입니다.
func (root *TreeNode) InOrderTraversal() {
	if root == nil {
		return
	}
	root.Left.InOrderTraversal()
	fmt.Print(root.Val, " ")
	root.Right.InOrderTraversal()
}

// PostOrderTraversal는 이진 트리를 후위 순회하는 함수입니다.
func (root *TreeNode) PostOrderTraversal() {
	if root == nil {
		return
	}
	root.Left.PostOrderTraversal()
	root.Right.PostOrderTraversal()
	fmt.Print(root.Val, " ")
}

// Search는 이진 트리에서 값을 찾는 함수입니다.
func (root *TreeNode) Search(val int) *TreeNode {
  if root == nil || root.Val == val {
    return root
  }

  if val < root.Val {
    return root.Left.Search(val)
  }

  return root.Right.Search(val)
}

// Delete는 이진 트리에서 값을 삭제하는 함수입니다.
func (root *TreeNode) Delete(val int) *TreeNode {
  if root == nil {
    return nil
  }

  if val < root.Val {
    root.Left = root.Left.Delete(val)
  } else if val > root.Val {
    root.Right = root.Right.Delete(val)
  } else {
    // 삭제할 노드를 찾은 경우

    // 하나 이상의 자식이 없는 경우 또는 하나의 자식만 있는 경우
    if root.Left == nil {
      return root.Right
    } else if root.Right == nil {
      return root.Left
    }

    // 두 개의 자식이 있는 경우
    root.Val = root.Right.findMinValue()
    root.Right = root.Right.Delete(root.Val)
  }
  return root
}

// findMinValue는 현재 노드 아래에서 가장 작은 값을 찾아 반환하는 함수입니다.
func (root *TreeNode) findMinValue() int {
  current := root
  for current.Left != nil {
    current = current.Left
  }
  return current.Val
}

func main() {
	var root *TreeNode

	// 이진 트리에 값 삽입
	root = root.Insert(5)
	root.Insert(3)
	root.Insert(7)
	root.Insert(2)
	root.Insert(4)
	root.Insert(6)
	root.Insert(8)

	// 각 순회 방법 예제
	fmt.Print("Pre-order traversal: ")
	root.PreOrderTraversal() // 전위 순회 결과 출력: 5 3 2 4 7 6 8
	fmt.Println()

	fmt.Print("In-order traversal: ")
	root.InOrderTraversal() // 중위 순회 결과 출력: 2 3 4 5 6 7 8
	fmt.Println()

	fmt.Print("Post-order traversal: ")
	root.PostOrderTraversal() // 후위 순회 결과 출력: 2 4 3 6 8 7 5
	fmt.Println()

    // 값 찾기 예제
    fmt.Println(root.Search(6)) // 찾은 경우: &{6 0xc000010240 0xc000010260}
    fmt.Println(root.Search(9)) // 못 찾은 경우: <nil>
  
    // 값 삭제 예제
    fmt.Print("Before deletion: ")
    root.InOrderTraversal() // 중위 순회 결과 출력: 2 3 4 5 6 7 8
    fmt.Println()
  
    root = root.Delete(5)    // 루트 노드 삭제
    fmt.Print("After deletion: ")
    root.InOrderTraversal() // 중위 순회 결과 출력: 2 3 4 6 7 8
    fmt.Println()

}

```


# 깊이 우선 탐색(DFS) 알고리즘으로 트리 탐색
    stack 
    스택 자료구조를 활용하여 현재 탐색 중인 노드를 스택에 넣고 해당 노드의 자식 노드 중 하나를 선택하여 다시 스택에 넣는 방식

```go
package main

import (
	"fmt"
)

// TreeNode는 기본 트리 노드 구조체입니다.
type TreeNode struct {
	Value int
	Left  *TreeNode
	Right *TreeNode
}

// StackNode는 스택에 저장할 노드 구조체입니다.
type StackNode struct {
	Node  *TreeNode
	Level int
}

// Stack은 스택 구조체입니다.
type Stack struct {
	Nodes []StackNode
}

// Push는 스택에 노드를 추가합니다.
func (s *Stack) Push(node *TreeNode, level int) {
	s.Nodes = append(s.Nodes, StackNode{Node: node, Level: level})
}

// Pop는 스택에서 노드를 꺼냅니다.
func (s *Stack) Pop() (node *TreeNode, level int) {
	if len(s.Nodes) == 0 {
		return nil, -1
	}
	index := len(s.Nodes) - 1
	node, level = s.Nodes[index].Node, s.Nodes[index].Level
	s.Nodes = s.Nodes[:index]
	return node, level
}

// DFS는 스택을 사용하여 깊이 우선 탐색을 수행합니다.
func DFS(root *TreeNode) {
	if root == nil {
		return
	}

	stack := Stack{}
	stack.Push(root, 0)

	for len(stack.Nodes) > 0 {
		node, level := stack.Pop()
		fmt.Printf("Level %d: %d\n", level, node.Value)

		// 오른쪽 자식을 먼저 스택에 넣어야 왼쪽 자식이 먼저 나오게 됩니다.
		if node.Right != nil {
			stack.Push(node.Right, level+1)
		}
		if node.Left != nil {
			stack.Push(node.Left, level+1)
		}
	}
}

func main() {
	// 트리 생성 예시:      1
	//                /   \
	//               2     3
	//              / \   / \
	//             4   5 6   7
	root := &TreeNode{
		Value: 1,
		Left: &TreeNode{
			Value: 2,
			Left: &TreeNode{
				Value: 4,
			},
			Right: &TreeNode{
				Value: 5,
			},
		},
		Right: &TreeNode{
			Value: 3,
			Left: &TreeNode{
				Value: 6,
			},
			Right: &TreeNode{
				Value: 7,
			},
		},
	}

	fmt.Println("Depth First Search:")
	DFS(root)
}

```

# 너비 우선 탐색(BFS) 알고리즘으로 트리 탐색
    queue
```go
package main

import (
	"fmt"
)

// TreeNode는 기본 트리 노드 구조체입니다.
type TreeNode struct {
	Value int
	Left  *TreeNode
	Right *TreeNode
}

// QueueNode는 큐에 저장할 노드 구조체입니다.
type QueueNode struct {
	Node  *TreeNode
	Level int
}

// Queue는 큐 구조체입니다.
type Queue struct {
	Nodes []QueueNode
}

// Enqueue는 큐에 노드를 추가합니다.
func (q *Queue) Enqueue(node *TreeNode, level int) {
	q.Nodes = append(q.Nodes, QueueNode{Node: node, Level: level})
}

// Dequeue는 큐에서 노드를 꺼냅니다.
func (q *Queue) Dequeue() (node *TreeNode, level int) {
	if len(q.Nodes) == 0 {
		return nil, -1
	}
	node, level = q.Nodes[0].Node, q.Nodes[0].Level
	q.Nodes = q.Nodes[1:]
	return node, level
}

// BFS는 큐를 사용하여 너비 우선 탐색을 수행합니다.
func BFS(root *TreeNode) {
	if root == nil {
		return
	}

	queue := Queue{}
	queue.Enqueue(root, 0)

	for len(queue.Nodes) > 0 {
		node, level := queue.Dequeue()
		fmt.Printf("Level %d: %d\n", level, node.Value)

		if node.Left != nil {
			queue.Enqueue(node.Left, level+1)
		}
		if node.Right != nil {
			queue.Enqueue(node.Right, level+1)
		}
	}
}

func main() {
	// 트리 생성 예시:      1
	//                /   \
	//               2     3
	//              / \   / \
	//             4   5 6   7
	root := &TreeNode{
		Value: 1,
		Left: &TreeNode{
			Value: 2,
			Left: &TreeNode{
				Value: 4,
			},
			Right: &TreeNode{
				Value: 5,
			},
		},
		Right: &TreeNode{
			Value: 3,
			Left: &TreeNode{
				Value: 6,
			},
			Right: &TreeNode{
				Value: 7,
			},
		},
	}

	fmt.Println("Breadth First Search:")
	BFS(root)
}

```

[Path Sum](https://leetcode.com/problems/path-sum-ii/)
```go

/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func pathSum(root *TreeNode, targetSum int) [][]int {
    var result [][]int
    var currentPath []int

    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, sum int) {
        if node == nil {
            return
        }

        // 현재 노드의 값을 현재 경로에 추가합니다.
        currentPath = append(currentPath, node.Val)
        sum -= node.Val

        // 리프 노드인 경우, 현재 경로의 합이 목표값과 일치하면 경로를 결과에 추가합니다.
        if node.Left == nil && node.Right == nil && sum == 0 {
            pathCopy := make([]int, len(currentPath))
            copy(pathCopy, currentPath)
            result = append(result, pathCopy)
        } else {
            // 왼쪽과 오른쪽 서브트리를 탐색합니다.
            dfs(node.Left, sum)
            dfs(node.Right, sum)
        }

        // 되돌아가기: 현재 경로의 마지막 노드를 제거합니다.
        currentPath = currentPath[:len(currentPath)-1]
    }

    dfs(root, targetSum)
    return result
}

```

```markdown

| Call # | Node Value | Add to Path | Sum | Current Path    | Result           |
|--------|------------|-------------|-----|-----------------|------------------|
| 1      | 5          | Yes         | 22  | [5]             |                  |
| 1-1    | 4          | Yes         | 18  | [5, 4]          |                  |
| 1-1-1  | 11         | Yes         | 7   | [5, 4, 11]      |                  |
| 1-1-1-1| 7          | Yes         | 0   | [5, 4, 11, 7]   | [5, 4, 11, 2]    |
| 1-1-2  | 2          | Yes         | 0   | [5, 4, 11, 2]   | [5, 4, 8, 5]     |
| 1-2    | 8          | Yes         | 14  | [5, 8]          |                  |
| 1-2-1  | 13         | Yes         | 1   | [5, 8, 13]      |                  |
| 1-2-1-1| 4          | Yes         | -3  | [5, 8, 13, 4]   |                  |
| 1-2-1-2| 5          | Yes         | -2  | [5, 8, 13, 4, 5]|                  |
| 1-2-2  | 4          | Yes         | 0   | [5, 8, 4]       | [5, 8, 4, 5]     |
| 1-2-2-1| 5          | Yes         | -1  | [5, 8, 4, 5]    |                  |
| Result |            |             |     |                 | [[5,4,11,2],[5,8,4,5]] |

```


[3번째 큰 수](https://leetcode.com/problems/third-maximum-number/)

```go
package main

import (
	"fmt"
	"sort"
)

func thirdMax(nums []int) int {
	uniqueNums := unique(nums)
	sort.Ints(uniqueNums)

	if len(uniqueNums) < 3 {
		return uniqueNums[len(uniqueNums)-1] // 고유한 요소가 1개 또는 2개일 경우 가장 큰 값을 반환
	}
	return uniqueNums[len(uniqueNums)-3] // 세 번째로 큰 값을 반환
}

// 중복을 제거한 고유한 정수 배열 반환
func unique(intSlice []int) []int {
	keys := make(map[int]bool)
	list := []int{}
	for _, entry := range intSlice {
		if _, value := keys[entry]; !value {
			keys[entry] = true
			list = append(list, entry)
		}
	}
	return list
}

func main() {
	nums := []int{2, 2, 3, 1}
	result := thirdMax(nums)
	fmt.Println("Output:", result) // Output: 1
}

```
그런데 이문제를 트리를 써서 해보면..? (오류남)



[이진트리 반전](https://leetcode.com/problems/invert-binary-tree/)

```go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

// 이진 트리를 반전시키는 함수
func invertTree(root *TreeNode) *TreeNode {
	if root == nil {
		return nil
	}

	// 왼쪽과 오른쪽 서브트리를 재귀적으로 반전
	root.Left, root.Right = invertTree(root.Right), invertTree(root.Left)

	return root
}

```


[이진 검색 트리 검색](https://leetcode.com/problems/validate-binary-search-tree/)
제약조건
노드의 왼쪽 서브트리에 있는 모든 노드의 값은 해당 노드의 값보다 작아야 합니다.
노드의 오른쪽 서브트리에 있는 모든 노드의 값은 해당 노드의 값보다 커야 합니다.
왼쪽 서브트리와 오른쪽 서브트리 모두가 이진 탐색 트리여야 합니다.
주어진 제약 조건은 노드의 개수가 [1, 104] 범위 내에 있으며, 각 노드의 값은 -231 이상 231 - 1 이하의 범위 내에 있습니다.

```go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func isValidBST(root *TreeNode) bool {
    return isBST(root, math.MinInt64, math.MaxInt64)
}

func isBST(node *TreeNode, min, max int) bool {
    if node == nil {
        return true
    }
    if node.Val <= min || node.Val >= max {
        return false
    }
    return isBST(node.Left, min, node.Val) && isBST(node.Right, node.Val, max)
}

```
위 코드에서 isValidBST 함수는 주어진 이진 트리가 유효한 BST인지 확인합니다. isBST 함수는 재귀적으로 노드를 탐색하면서 해당 노드의 값이 주어진 범위 내에 있는지 확인합니다. 이 코드를 실행하면 예제 입력 트리의 결과가 false가 됨을 확인할 수 있습니다.