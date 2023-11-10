
# 탐색

- 순차 탐색 = 선형 탐색
    - 처음부터 끝까지 모든 요소를 검사하는 알고리즘
    - 배열이 있으면 이 데이터 배열의 처음부터 끝까지 차례대로 비교하여 원하는 데이터를 찾아내는 알고리즘
    - 어느 한 쪽 방향으로만 탐색할 수 있다는 의미
    - 최악:시간복잡도 O(n) 최선:O(1)
    
    ex) 정렬되지 않은 배열의 요소를 하나씩 모두 검사 - 오름차순 ,내림차순 검사

- 이진 탐색 
    - 데이터가 정렬된 상태일 때만 사용
    - 리스트에서 탐색의 범위를 1/2로 줄여 나가면서 숫자를 탐색하는 방법
    - O(log n) 시간 복잡도 
    ex) [10,12,13,14,15,18,19] 에서 18 의 인덱스를 찾는 방법
```
func binarySearch(arr []int, target int) int {
    first, last := 0, len(arr)-1

    for first <= last {
        mid := (first + last) / 2 //몫 연산자
        if arr[mid] == target {
            return mid 
        } else if arr[mid] > target {
        //찾는 숫자가 중앙보다 작은가? 인덱스를 1을 뺀고 last 변경= 중앙보다 작은 쪽 절반 버림
             last = mid - 1
        } else { 
			first = mid + 1
        }
    }

    return -1 // 찾지 못했을 때 -1 반환
}
```


