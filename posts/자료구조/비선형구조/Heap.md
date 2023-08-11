
# 힙 = 이진힙 : 
최대값 및 최소값을 찾아내는 연산을 빠르게 하기 위해 고안된 완전 이진트리를 기본으로 한 자료구조
   1. 완전 이진 트리(Complete Binary Tree): 마지막 레벨을 제외한 모든 레벨에서 노드가 완전히 채워진 이진 트리입니다. 마지막 레벨의 노드는 왼쪽부터 채워져야 합니다.
   2. 부모노드의 키값과 자식 노드의 키값 사이에는 대소관계가 성립


## - 최대힙 : 부모 키값이 자식노드 키값보다 큰 힙
        - 루트 노드 삭제
        - 가장 낮은 레벨에서 가장 오른쪽의 노드를 루트로 올린다
        - 루트에서 각 자식 노드와 값을 비교하여 더 큰 값과 교환한다
        - 더 이상 교환이 없을 때까지 진행

Max Heap은 트리(Tree)의 한 종류이며
Max Heap 특성이 유지하기 위해 increase value 작업 수행

Max Heap에서 index에 위치한 요소를 삭제하고 힙 속성을 유지하는 코드를 아래에 제공합니다.
요소를 삭제하면 힙 속성이 깨질 수 있기 때문에 "heapify" 과정을 수행하여 힙 속성을 복원합니다
```go
package main

import (
    "fmt"
)

type MaxHeap struct {
    array []int
}

func NewMaxHeap() *MaxHeap {
    return &MaxHeap{
        array: []int{},
    }
}
//새로운 값을 힙에 추가
func (h *MaxHeap) Insert(value int) {
    h.array = append(h.array, value)
    index := len(h.array) - 1
    h.bubbleUp(index)
}

//Max Heap에서 최대값(루트 노드)를 추출하는 함수
func (h *MaxHeap) ExtractMax() (int, error) {
    if len(h.array) == 0 {
        return 0, fmt.Errorf("Heap is empty")
    }
    root := h.array[0]
    lastIndex := len(h.array) - 1
    h.array[0] = h.array[lastIndex]
    h.array = h.array[:lastIndex]
    h.heapify(0)
    return root, nil
}
//올라가면서 재정렬
func (h *MaxHeap) bubbleUp(index int) {
    parentIndex := (index - 1) / 2
    for index > 0 && h.array[parentIndex] < h.array[index] {
        h.array[parentIndex], h.array[index] = h.array[index], h.array[parentIndex]
        index = parentIndex
        parentIndex = (index - 1) / 2
    }
}
//내려가면서 재정렬
func (h *MaxHeap) heapify(index int) {
    leftChildIndex := 2*index + 1
    rightChildIndex := 2*index + 2
    largest := index

    if leftChildIndex < len(h.array) && h.array[leftChildIndex] > h.array[largest] {
        largest = leftChildIndex
    }
    if rightChildIndex < len(h.array) && h.array[rightChildIndex] > h.array[largest] {
        largest = rightChildIndex
    }

    if largest != index {
        h.array[index], h.array[largest] = h.array[largest], h.array[index]
        h.heapify(largest)
    }
}

func main() {
    heap := NewMaxHeap()
    valuesToAdd := []int{4, 10, 3, 5, 1, 8}
    
    for _, value := range valuesToAdd {
        heap.Insert(value)
    }

    fmt.Println("Max Heap before extraction:", heap.array)

    // Extract the maximum value from the heap
    extractedValue, err := heap.ExtractMax()
    if err != nil {
        fmt.Println("Error:", err)
    } else {
        fmt.Println("Extracted Max Value:", extractedValue)
        fmt.Println("Max Heap after extraction:", heap.array)
    }
}

```
* bubbleUp: 새로운 값이 추가되었을 때 부모와 값을 비교하여 힙 속성을 유지하는 작업
* heapify: 요소가 제거되었을 때 힙 속성을 유지하기 위한 작업 


> 힙을 배열로 표현하는 것에는 여러 이유?:
* 메모리 공간의 효율성: 배열은 연속된 메모리 공간을 사용하므로 힙을 배열로 표현하면 메모리 관리가 간편합니다. 트리 기반의 구조를 포인터로 표현하는 것보다 배열로 표현하는 것이 메모리 사용 면에서 더 효율적일 수 있습니다.
* 인덱스 계산의 간편함: 배열을 사용하면 부모와 자식 노드 간의 관계를 간단한 수학적인 계산을 통해 쉽게 찾을 수 있습니다. 부모 노드의 인덱스는 (i - 1) / 2로 계산하고, 왼쪽 자식 노드의 인덱스는 2 * i + 1, 오른쪽 자식 노드의 인덱스는 2 * i + 2로 계산할 수 있습니다. 이러한 인덱스 계산은 배열로 힙을 구현할 때 특히 유용합니다.
* 간결함과 접근성: 배열은 다른 데이터 구조보다 접근이 빠르며, 요소를 추가하거나 제거하는 연산도 상수 시간에 수행됩니다. 이러한 특성 덕분에 배열로 힙을 표현하면 코드가 더 간결하고 성능이 좋아집니다.
* 구현의 단순함: 배열을 사용하면 힙을 구현하는 코드가 더 간단해집니다. 노드와 링크를 사용하는 트리 기반의 힙 구현보다 배열을 사용하는 것이 구현이 단순하고 이해하기 쉬울 수 있습니다.


## - 최소힙 : 부모 키값이 자식노드 키값보다 작은 힙(가장 작은 값이 루투노드에 있음)

```go
package main

import (
	"fmt"
)

type MinHeap struct {
	array []int
}

func NewMinHeap() *MinHeap {
	return &MinHeap{
		array: []int{},
	}
}

func (h *MinHeap) Insert(value int) {
	h.array = append(h.array, value)
	index := len(h.array) - 1
	h.bubbleUp(index)
}

func (h *MinHeap) bubbleUp(index int) {
	parentIndex := (index - 1) / 2
	for index > 0 && h.array[parentIndex] > h.array[index] {
		h.array[parentIndex], h.array[index] = h.array[index], h.array[parentIndex]
		index = parentIndex
		parentIndex = (index - 1) / 2
	}
}

func (h *MinHeap) ExtractMin() (int, error) {
	if len(h.array) == 0 {
		return 0, fmt.Errorf("Heap is empty")
	}
	root := h.array[0]
	lastIndex := len(h.array) - 1
	h.array[0] = h.array[lastIndex]
	h.array = h.array[:lastIndex]
	h.heapify(0)
	return root, nil
}

func (h *MinHeap) heapify(index int) {
	leftChildIndex := 2*index + 1
	rightChildIndex := 2*index + 2
	smallest := index

	if leftChildIndex < len(h.array) && h.array[leftChildIndex] < h.array[smallest] {
		smallest = leftChildIndex
	}
	if rightChildIndex < len(h.array) && h.array[rightChildIndex] < h.array[smallest] {
		smallest = rightChildIndex
	}

	if smallest != index {
		h.array[index], h.array[smallest] = h.array[smallest], h.array[index]
		h.heapify(smallest)
	}
}

func main() {
	heap := NewMinHeap()
	valuesToAdd := []int{4, 10, 3, 5, 1, 8}

	for _, value := range valuesToAdd {
		heap.Insert(value)
	}

	fmt.Println("Min Heap before extraction:", heap.array)

	// Extract the minimum value from the heap
	extractedValue, err := heap.ExtractMin()
	if err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Println("Extracted Min Value:", extractedValue)
		fmt.Println("Min Heap after extraction:", heap.array)
	}
}

```

Insert 연산은 bubbleUp을 사용하여 새로운 값을 부모 노드와 비교하면서 위로 올려야 하며, ExtractMin 연산은 heapify을 사용하여 힙 속성을 유지하면서 최소값을 추출