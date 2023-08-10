# 정렬

1. 버블정렬(Bubble sort)
알고리즘 동작이 각 순회의 가장 큰 요소가 맨 뒤로 이동하는 방식
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
	}
}

func main() {
	arr := []int{64, 34, 25, 12, 22, 11, 90}
	fmt.Println("Original array:", arr)

	bubbleSort(arr)

	fmt.Println("Sorted array:", arr)
}

```
2. 삽입정렬(Insertion sort)
리스트 내 하나의 요소를 선택해 다른 요소와 비교하여 알맞은 위치에 삽입
* 시간 복잡도가 높은 정렬이지만 거품 정렬보다 비교 횟수가 적다
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
	arr := []int{64, 34, 25, 12, 22, 11, 90}
	fmt.Println("Original array:", arr)

	insertionSort(arr)

	fmt.Println("Sorted array:", arr)
}

```
3. 병합정렬(Merge sort)
* 높은 효율을 보이는 정렬 알고리즘
* 분할 정복 접근을 기반으로 함
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