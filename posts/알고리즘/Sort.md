# 정렬
- 데이터를 일정한 순서로 배치하는 것
- 오름차순 : 리스트를 가장 작은 숫자에서 가장 큰 숫자로 정렬
- 내림차순 : 리스트를 가장 큰 숫자에서 가장 작은 숫자로 정렬
- 구현이 단순한 정렬: 버블,선택,삽입,셀...
- 구현이 복잡한 정렬: 힙,병합,퀵,기수 ...

1. 버블정렬(Bubble sort)
* 알고리즘 동작이 각 순회의 가장 큰 요소가 맨 뒤로 이동하는 방식
* 교환이 있을 때에는 swapped 변수를 true로 설정하며, 한 루프 동안 교환이 없으면 swapped 변수를 false로 설정하여 전체 순회
* 시간 복잡도가 아주 높은 정렬

```go
package main

import "fmt"

func bubbleSort(arr []int) {
	n := len(arr)
	swapped := true

	for swapped {
		swapped = false

		for i := 1; i < n; i++ {
			if arr[i-1] > arr[i] {
				arr[i-1], arr[i] = arr[i], arr[i-1]
				swapped = true
			}
		}

		n-- // 각 루프 후 가장 큰 값이 정렬되었으므로 범위 축소
		// 현재 상태 출력
		fmt.Println("Intermediate array:", arr)
	}
}

func main() {
	arr := []int{90, 63, 25, 12}
	fmt.Println("Original array:", arr)

	bubbleSort(arr)

	fmt.Println("Sorted array:", arr)
}

```


초기 배열: [90, 63, 25, 12]

| 루프 | 비교       | 배열 상태              |
|------|------------|------------------------|
| 1    | 90와 63     | [63, 90, 25, 12]       |
|      | 90와 25     | [63, 25, 90, 12]       |
|      | 90와 12     | [63, 25, 12, 90]       |
| 2    | 63와 25     | [25, 63, 12, 90]       |
|      | 63와 12     | [25, 12, 63, 90]       |
| 3    | 25와 12     | [12, 25, 63, 90]       |

정렬이 완료된 배열: [12, 25, 63, 90]

2. 삽입정렬(Insertion sort)
* 리스트 내 하나의 요소를 선택해 다른 요소와 비교하여 알맞은 위치에 삽입
* 시간 복잡도가 높은 정렬이지만 거품 정렬보다 비교 횟수가 적다
* 두번째 요소에서 시작
```go
package main

import "fmt"

func insertionSort(arr []int) {
	n := len(arr)
	for i := 1; i < n; i++ {
		key := arr[i]
		j := i - 1

		// key보다 큰 원소를 오른쪽으로 이동
		for j >= 0 && arr[j] > key {
			arr[j+1] = arr[j]
			j--
		}
		arr[j+1] = key
	}
}

func main() {
	arr := []int{6, 5, 8, 3}
	fmt.Println("Original array:", arr)

	insertionSort(arr)

	fmt.Println("Sorted array:", arr)
}

```


| 단계 | 현재 배열 상태 | key  | 설명                            |
|------|--------------|------|---------------------------------|
| 1    | [6, 5, 8, 3] | 5    | 5와 6을 비교하여 5를 앞으로 이동 |
|      | [5, 6, 8, 3] |      |                                 |
| 2    | [5, 6, 8, 3] | 8    | 8과 6을 비교하여 8을 앞으로 이동 |
|      | [5, 6, 8, 3] |      |                                 |
| 3    | [5, 6, 8, 3] | 3    | 3과 8을 비교하여 3을 앞으로 이동 |
|      | [5, 6, 3, 8] |      | 3과 6을 비교하여 3을 앞으로 이동 |
|      | [5, 3, 6, 8] |      | 3과 5를 비교하여 3을 앞으로 이동 |
|      | [3, 5, 6, 8] |      | 최종적으로 정렬 완료             |


최종 정렬된 배열: [3, 5, 6, 8]

세부적인 배열 변화를 보면, 
각 단계에서 key와 비교되는 원소들이 오른쪽으로 이동하면서 정렬이 진행됩니다. 
마지막 단계에서는 key 값이 적절한 위치에 삽입되면서 최종적으로 정렬된 배열이 완성됩니다.



3. 병합정렬(Merge sort)
* 높은 효율을 보이는 정렬 알고리즘
* 분할 정복 접근을 기반으로 함
* 분할 정복 알고림즘은 재귀를 통해 문제를 두 개 이상의 더 작은 문제로 분할하여 
    각각의 작은 문제들이 해결될 때까지 나누기를 반복하는 알고리즘
* 시간복잡도 안정적 O(nlogn)
```go
package main

import (
	"fmt"
)

func mergeSort(arr []int) []int {
	// 배열의 길이가 1 이하이면 이미 정렬되었으므로 그대로 반환
	if len(arr) <= 1 {
		return arr
	}

	// 배열을 중간 기준으로 분할
	mid := len(arr) / 2
	left := arr[:mid]
	right := arr[mid:]

	// 왼쪽과 오른쪽 배열을 재귀적으로 정렬
	left = mergeSort(left)
	right = mergeSort(right)

	// 정렬된 두 배열을 병합하는 부분
	result := make([]int, 0, len(arr)) // 결과 배열 생성
	leftIndex, rightIndex := 0, 0 // 왼쪽과 오른쪽 배열의 인덱스 초기화

	// 두 배열의 요소 중 작은 값을 선택하여 결과 배열에 추가
	for leftIndex < len(left) && rightIndex < len(right) {
		// 왼쪽 배열의 요소가 더 작거나 같은 경우, 또는 오른쪽 배열의 모든 요소를 추가한 경우
		if left[leftIndex] <= right[rightIndex] {
			result = append(result, left[leftIndex]) // 작은 값 추가
			leftIndex++ // 왼쪽 배열의 인덱스 증가
		} else {
			result = append(result, right[rightIndex]) // 작은 값 추가
			rightIndex++ // 오른쪽 배열의 인덱스 증가
		}
	}

	// 남은 요소를 결과 배열에 복사
	result = append(result, left[leftIndex:]...) // 왼쪽 배열의 남은 요소 추가
	result = append(result, right[rightIndex:]...) // 오른쪽 배열의 남은 요소 추가

	return result
}

func main() {
	arr := []int{38, 27, 43, 3, 9, 82, 10}
	fmt.Println("Before merge sort:", arr)

	sortedArr := mergeSort(arr)
	fmt.Println("After merge sort:", sortedArr)
}


```
Step 1: 배열을 반으로 나누기 ,각 배열의 크기가 1이 될 때까지

| 단계 | 전체 배열                                                                      |
|----|----------------------------------------------------------------------------|
| 1  | [38, 27, 43, 3, 9, 82, 10]                                                 |
| 2  | [38, 27, 43,3]   \|   [ 9, 82, 10]                                         |
| 3  | [38,27]   \|   [ 43,3]   \|   [9,82]   \|   [ 10]                          |
| 6  | [38]   \|   [27]   \|   [43]   \|   [3]   \|   [9]   \|   [82]   \|   [10] |


Step 2: 정렬 및 머지 수행

|        | 1                | 2              | 3              | 4   |
|--------|------------------|----------------|----------------|-----|
| 1  | [27, 38]         | [3, 43]        | [9, 82]        | [10]|
| 2  | [3, 27, 38, 43]  | [9, 10, 82]    |                |     |
| 3  | [3, 9, 10, 27, 38, 43, 82]         |                |                |     |


4. 퀵정렬(Quick sort)
* 분할 정복 방법 이용
* 입력 리스트를 두 리스트로 나눌때, 한쪽은 특정 값보다 작은 값만 모으고 다른 하나는 특정 값보다 큰 값만 모은다
* 특정값 = 피벗
* 피벗을 기준으로 작은, 같은, 큰 요소들을 각각 low, same, high 배열에 분류하여 정렬을 수행하는 방법
```go
package main

import (
	"fmt"
)

func quickSort(arr []int) []int {
	if len(arr) <= 1 {
		return arr
	}

	pivot := arr[len(arr)-1] // 피벗을 배열의 마지막 요소로 선택
	var low, same, high []int

	// 피벗을 기준으로 작은, 같은, 큰 요소들을 분류
	for _, num := range arr {
		if num < pivot {
			low = append(low, num)
		} else if num > pivot {
			high = append(high, num)
		} else {
			same = append(same, num)
		}
	}

	// 왼쪽과 오른쪽을 재귀적으로 정렬하고 병합
	return append(append(quickSort(low), same...), quickSort(high)...)
}

func main() {
	arr := []int{38, 27, 43, 3, 9, 82, 10}
	fmt.Println("Before quick sort:", arr)

	sortedArr := quickSort(arr)
	fmt.Println("After quick sort:", sortedArr)
}

```
* 왼쪽.오른쪽으로 나눈경우
```go
package main

import "fmt"

func quickSort(arr []int) []int {
	if len(arr) <= 1 {
		return arr
	}

	pivot := arr[len(arr)-1] // 피벗을 배열의 마지막 요소로 선택
	var left, right []int

	// 피벗보다 작은 요소는 왼쪽, 큰 요소는 오른쪽에 분할
	for _, num := range arr[:len(arr)-1] {
		if num <= pivot {
			left = append(left, num)
		} else {
			right = append(right, num)
		}
	}

	// 왼쪽과 오른쪽을 재귀적으로 정렬하고 병합
	return append(append(quickSort(left), pivot), quickSort(right)...)
}

func main() {
	arr := []int{38, 27, 43, 3, 9, 82, 10}
	fmt.Println("Before quick sort:", arr)

	sortedArr := quickSort(arr)
	fmt.Println("After quick sort:", sortedArr)
}

```


5. 선택정렬(Selection sort)
- 왼쪽부터 오른쪽으로 이동하면서 가장 작은 값을 선택해 위치를 옮기는 알고리즘
- 배열에서 최소값을 선택하고 해당 위치에 있는 요소와 교환하는 방식으로 정렬을 수행하는 간단한 정렬 알고리즘
- 시간 복잡도 O(n^2)

```go
package main

import (
	"fmt"
)

func selectionSort(arr []int) []int {
	n := len(arr)

	for i := 0; i < n-1; i++ {
		// 최소값을 현재 인덱스로 설정
		minIndex := i

		// i 이후의 요소들 중에서 최소값을 찾음
		for j := i + 1; j < n; j++ {
			if arr[j] < arr[minIndex] {
				minIndex = j
			}
		}

		// 최소값과 현재 위치의 요소를 교환
		if minIndex != i {
			arr[i], arr[minIndex] = arr[minIndex], arr[i]
		}
	}

	return arr
}

func main() {
	arr := []int{38, 27, 43, 3, 9, 82, 10}
	fmt.Println("Before selection sort:", arr)

	sortedArr := selectionSort(arr)
	fmt.Println("After selection sort:", sortedArr)
}

```


# javascript
* 오름차순
arr.sort((a, b) => a - b);
* 내림차순 
arr.sort((a, b) => b - a);

https://school.programmers.co.kr/learn/courses/30/lessons/120862?language=javascript