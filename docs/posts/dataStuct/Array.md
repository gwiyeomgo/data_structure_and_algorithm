___
### [1.1 두  수의  합  찾기]([https://leetcode.com/problems/two-sum/editorial/)


|                |                          |(시간/공간)복잡도                       |
|:----------------|-------------------------------|-----------------------------|
|범위,제한사항|같은  요소의  값을  중복해서  사용  불가            |O(n2)            |
|아이디어          |  2중 for 문 <br/>   Target 과 합이 같으면 탈출 <br/> 배열 반환 |O(1)            |
___
```
package main
import ("fmt")
func main() {
//두 수의 합 찾기
nums := []int{2,7,10,19}
target := 9
	for i,_ := range nums {
		for j := i+1 ; j < len(nums); j++ {
			if target == int(nums[i]+nums[j]){
				fmt.Print([]int{i,j})
			}
		}
	}
}
```
|                |                          |(시간/공간)복잡도                      |
|:----------------|-------------------------------|----------------------------|
|범위,제한사항|같은  요소의  값을  중복해서  사용  불가            |O(n)            |
|아이디어          |  Target - 요소1  = 요소2 <br/> 요소2가 있다면 출력 <br/> 요소2 없다면 요소1의 값을 map에 저장 <br/> 출력시 i 보다 인덱스가 클 수 있으니 오름차순으로 정렬 <br/> |O(n) 해시 테이블을 생성하여 최대로 모든 요소( n)을 담아야 한다         |
___
```
package main

import (
	"fmt"
	"sort"
)

func main() {
	nums := []int{2,3,8,9,11,12}
	target := 13
	dataMap := make(map[int]int,0)

	for i , num := range nums {
		val := target-num
		v, ok := dataMap[val]
		if ok {
			result := []int{i,v}
			sort.Slice(result,func(i, j int) bool {
				return result[i] <result[j]
			})
			fmt.Print(result)
			break
		}else{
			dataMap[num] = i
		}
	}
}

```

- 브루트 포스(brute force) 알고리즘
  >  선형 구조 :순차 탐색

  > 비선형 구조: 백트래킹, dfs,bfs

- 해시 테이블
    - 중복이라는 말이 나온다면 해시 테이블을 검토 생가가하기

___

### [1.2 정렬된 배열에서 중복 제거](https://www.hackerrank.com/contests/doyoulikeit/challenges/remove-duplicates-from-sorted-array)

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|an integer n (size of array) </br> array of size n.       |         |
|아이디어          |  fmt.scanf 로 입력값 받아서 배열에 값 넣음 <br/> 배열의 중복해결 (map 사용)  |     |

```
package main
import "fmt"

func removeDupplicateItems(intSlice []int) []int {
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
 //Enter your code here. Read input from STDIN. Print output to STDOUT
    var n int
    fmt.Scanln(&n)
    arr := make([]int,n)
 
    for i:=0; i<n;i++ {
        fmt.Scanf("%d",&arr[i])
    }
    fmt.Println(len(removeDupplicateItems(arr)))
    
}
```
|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|이진탐색 <br/> 맨 첫 요소 curr 저장 <br/> 배열의 요소를 맨 첫 요소를 제외하고 순회       | O(n) 배열의 모든 요소 n개를 순회        |
|아이디어          |  fmt.scanf 로 입력값 받아서 배열에 값 넣음 <br/> 배열의 중복해결 (map 사용)  | O(1)    |

```
package main
import "fmt"

func main() {
    var n int
    fmt.Scanln(&n)
    nums := make([]int,n)
    for i:=0; i<n;i++ {
        fmt.Scanf("%d",&nums[i])
    }
    curr := nums[0]
    cnt := 1
    
       for i,v := range nums {
        if curr != v {
            curr = nums[i]
            nums[cnt] = curr
            cnt += 1
        }
    }
    fmt.Println(cnt)
}
```
- [이진탐색](https://cjh5414.github.io/binary-search/)


___

### [1.3 배열에서 삽입 위치 찾기](https://leetcode.com/problems/search-insert-position/)

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|            | O(n) |
|아이디어          | 배열의 각 요소를 인덱스 0에서부터 순회한다 <br/> 순회하면서 target 의 값과 같거나 크다면 순회를 중단한다 <br/> 중단된 시점의 인덱스를 반환한다  |  O(1)   |

```
func searchInsert(nums []int, target int) int {
  
index := 0

for index < len(nums) {
if target <= nums[index] {
break;
}
index += 1
}

return index
}

```

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|              | O(NlogN) |
|아이디어          | 배열 요소를 이진 탐색으로 접근한다 <br/> 요소를 찾는다면, 해당 인덱스를 반환 <br/> 끝까지 찾지 못하고 이진 탐색을 종료한다면, <br/> 최종 접근했던 낮은 인덱스의 값을 반환한다 <br/>  |  O(1)   |

```
func searchInsert(nums []int, target int) int {
    
    low := 0
    high := len(nums) -1
    mid := 0
  
	for low <= high {
        mid = (low + high) /2;

        if(nums[mid]== target){
              fmt.Println(mid)
                return mid
        }else if (nums[mid]> target){
            high = mid -1
        }else {
            low = mid +1
        }
	}
    return low
}

```
___
### [1.4 정렬된 배열의 병합](https://leetcode.com/problems/merge-sorted-array/description/)

|                |                                                    | (시간/공간)복잡도                                                                                                               |
|:----------------|----------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
|범위,제한사항|                                                    | non-decreasing order (내림차순이 아닌 2개의 배열) <br/> 두개의 배열은 정렬됨 <br/> num1  m개, num2 n 개 요소가 있다 <br/> Num1 의 배열의 크기는 m+n  <br/> | O(NlogN) |
|아이디어          | 배열은 정렬되어있음 <br/> 값이 없는 요소는 m 번 이후부터로 순차적으로 배치 후 정렬 | O(N)                                                                                                                     |

```
import "sort"
func merge(nums1 []int, m int, nums2 []int, n int)  {

    for i,v := range nums2 {
        nums1[m+i]= v
    }
    
      sort.Slice(nums1,func(i, j int) bool {
        return nums1[i] < nums1[j]
      })
      fmt.Println(nums1)
}
```
|         |                         |(시간/공간)복잡도                    |
|:--------|------------------------------|--------------------------|
| 범위,제한사항 |               | O(N+M) |
| 아이디어    | 0. Index I,j,k 를 사용  <br/> 1.num1 의 값이 0인 인덱스는 m 이다  <br/> 2.num2 의 인덱스 (n-1) 의 값이 가장 큰 요소 이다 <br/> 3. num1[m-1] 값과 num2[n-1]  비교  값이 크다면 num1[i] 추가하고 k 와 j 값을 -1 해준다 <br/> 4 . 비교하다가 i,j값이 0 보다 작아지면 중단 <br/> |  O(1)   |

```
func merge(nums1 []int, m int, nums2 []int, n int)  {

  i := m-1 
  j := n-1
  k := m + n -1

  for i>=0 && j >= 0 {
    if nums1[i] < nums2[j] {
        nums1[k] = nums2[j]
        j -= 1
    }else{
        nums1[k] = nums1[i]
        i -= 1
    }
    k -= 1
  } 
  
  for j >=0 {
    nums1[k] = nums2[j]
    k -= 1
    j -= 1
  }
}


```

-  O(NlogN) 안정적인 시간 복잡도
___
### [1.4 파스칼의 삼각형](https://leetcode.com/problems/pascals-triangle/)

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|      | O(n2) |
|아이디어          | 기반 리스트 생성 <br/> 1번째 리스트 요소를 1로 초기화 <br/> 입력으로 주어진 행수 만큼 순회 <br/> 항상 맨 앞과 맨 뒤 값은 1 <br/>  |  O(1)   |

```
func generate(numRows int) [][]int {
    pascal := make([][]int,0)
    if numRows <= 0 {
        return pascal
    }
    pascal = append(pascal,[]int{1})
    for i:=1;i< numRows;i++ {
        pre_len := len(pascal[i-1])
        curr_list := make([]int,0)
        for j:=0;j<pre_len+1;j++ {
            num :=1
            if j !=0 && j != pre_len {
              num = pascal[i-1][j-1] +pascal[i-1][j]
            }
            curr_list = append(curr_list,num)
        }
         pascal = append(pascal,curr_list)
    }
    return pascal
}

```
￼
___
### [1.5 배열에서 다수의 요소 찾기](https://leetcode.com/problems/majority-element/)

|                |                          | (시간/공간)복잡도 |
|:----------------|-------------------------------|------------|
|범위,제한사항|     Num 의 길이값이 n ,정수 배열 ,다수의 수는 무조건 하나가 존재        | O(N)       |
|아이디어          | 해시 테이블에서 키= 요소,값 =횟수 <br/> 배열을 순회하면서 해시테이블에 저장 <br/> N 보다 큰 수를 찾음 <br/>  | O(N)        |

```
unc majorityElement(nums []int) int {
    n := len(nums)/2
    data := make(map[int]int,0)
    for _,num := range nums {

        data[num]+=1

         if data[num] > n {
           return num
        }
    }

    return -1
}

```
|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|      |  |
|아이디어          | 1.정렬한다 <br/> 2. 배열의 n 요소를 출력  |    |

```
func majorityElement(nums []int) int {
    n := len(nums)/2

     sort.Slice(nums,func(i, j int) bool {
        return nums[i] > nums[j]
      })

    return nums[n]
}

```

___
### [1.6 배열의 회전](https://practice.geeksforgeeks.org/problems/rotate-array-by-n-elements-1587115621/1?utm_source=gfg&utm_medium=article&utm_campaign=bottom_sticky_on_article)

|                |                                            |(시간/공간)복잡도                    |
|:----------------|--------------------------------------------|--------------------------|
|범위,제한사항|                                            | O(n^2)|
|아이디어          | 배열의 각 요소를 왼쪽으로 d번 이동 <br/>첫번째 요소를 임시변수에 저장 |  공간 : O(1)공간 복잡도는 해당 알고리즘이 실행되는 동안 사용되는 추가적인 메모리 공간의 크기를 나타냅니다. 이 문제에서 사용되는 메모리는 입력 배열의 길이에 따라 달라지는 배열 요소의 임시 저장용 변수 temp 하나 뿐입니다. 따라서 배열의 크기가 변하지 않는 한, 추가적인 메모리는 상수 크기이므로 O(1)   |

```
func rotLeft(a []int32, d int32) []int32 {
   
    for i := 0; i < int(d); i++ {
        temp := a[0] 
        for i := 1; i < len(a); i++ {
            a[i-1] = a[i]   //앞으로 땡기기
        }
        a[len(a)-1] = temp 
  
    }
    return a
}
```
> 참고 (배열의 각 요소를 오른쪽으로 d 번 이동)
```
prev := slice[len(slice)-1]
for i := range slice {
    temp := slice[i]
    slice[i] = prev
    prev = temp
}
d--
```
|                |                          | (시간/공간)복잡도 |
|:----------------|-------------------------------|------------|
|범위,제한사항|      | O(1)       |
|아이디어          | 슬라이스 복사 <br/> 슬라이스(slice)의 길이를 n으로 저장하고, b를 n으로 나누어 나머지를 구합니다. 이를 통해 b가 슬라이스의 길이보다 큰 경우에 대비합니다. <br/> 그리고 append 함수를 사용하여 슬라이스의 b번째 인덱스부터 끝까지와 처음부터 b-1번째 인덱스까지를 잘라서 다시 합칩니다. 이를 통해 왼쪽으로 b번 이동한 슬라이스를 생성합니다. <br/> b %= n b를 n으로 나눈 나머지 값을 b에 다시 저장하는 연산  | append 함수는 새로운 메모리 공간을 할당하여 슬라이스를 복사하므로, 여기서 사용되는 추가적인 메모리는 입력 슬라이스의 크기에 비례합니다. 따라서 이 알고리즘의 공간 복잡도는 O(n)       |

```
func rotLeft(a []int32, d int32) []int32 {
   
    n := int32(len(a))
    d %= n

    return append(a[d:], a[:d]...)
}

```

> slice
```
slice := []int{1, 2, 3, 4, 5}
slice[:b]는 인덱스 0부터 인덱스 b-1까지의 요소
slice[b:]는 b번째 요소부터 끝까지의 모든 요소
slice[:3]은 [1, 2, 3]
```
___
### [1.7 빠진 숫자 찾기](https://leetcode.com/problems/missing-number/submissions/)

|                |                          | (시간/공간)복잡도 |
|:----------------|-------------------------------|------------|
|범위,제한사항|      | O(N)       |
|아이디어          |   |주어진 함수에서 사용하는 메모리는 입력 배열 nums의 길이 n과 무관하며, 상수 개수의 변수만 사용하므로, 입력 크기에 비례하지 않습니다. 따라서 공간 복잡도는 O(1)       |

```

import "fmt"
func missingNumber(nums []int) int {
   
      n := len(nums)
      sort.Slice(nums,func(i, j int) bool {
        return nums[i] <nums[j]
      })

      for i:=0;i<n;i++ {
          if i == n-1 {
            return n
          }

          if nums[i] != i{
            return i
          }

     }
      
  return  -1
}

```
|                |                          | (시간/공간)복잡도 |
|:----------------|-------------------------------|------------|
|범위,제한사항|      | O(N)       |
|아이디어          | 이 함수는 주어진 배열에서 누락된 숫자를 찾기 위해 XOR 연산을 사용합니다. XOR 연산은 두 값이 같으면 0을, 다르면 1을 반환하는 연산으로, 누락된 숫자를 찾는데 효과적입니다. 주어진 배열 nums에는 중복되지 않은 0부터 n까지의 요소들이 있으므로, 0부터 n까지의 숫자를 XOR 연산하면 누락된 숫자가 결과로 나오게 됩니다. 따라서 위의 함수를 사용하여 누락된 숫자를 찾을 수 있습니다.  |       |

```
import "fmt"
func missingNumber(nums []int) int {
     n := len(nums)
    missing := n // n을 초기값으로 설정합니다.

    for i := 0; i < n; i++ {
        // XOR 연산을 통해 누락된 숫자를 찾습니다.
        // 예를 들어, nums = [3, 0, 1]일 때,
        // missing ^= (3 ^ 0 ^ 1 ^ 0 ^ 1 ^ 2 ^ 3) => missing ^= 2
        missing ^= (i ^ nums[i])
    }

    return missing

}

```
___
### [1.8 부분](https://leetcode.com/problems/subsets/)

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항|      |  |
|아이디어          |   |     |

```

func generateSubsets(nums []int, index int, subset []int, result *[][]int) {
    if index == len(nums) {
        *result = append(*result, append([]int{}, subset...))
        return
    }
    // 현재 원소를 부분집합에 포함하지 않는 경우
    generateSubsets(nums, index+1, subset, result)

    // 현재 원소를 부분집합에 포함하는 경우
    subset = append(subset, nums[index])
    generateSubsets(nums, index+1, subset, result)
    //추가한 원소를 다시 제거
    subset = subset[:len(subset)-1]
}

func subsets(nums []int) [][]int {
    result := [][]int{}
    subset := []int{}
    generateSubsets(nums, 0, subset, &result)
    return result
}
```

___
### [1.9 단어찾기](https://leetcode.com/problems/word-search/ )

|                |                          |(시간/공간)복잡도                    |
|:----------------|-------------------------------|--------------------------|
|범위,제한사항| M * n 의 크기의 문자 2차원 배열     |  |
|아이디어          |  Board 배열 순회 <br/> word[0] 과board[x][y]  비교 <br/> 크기를 벗어났는지 확인 <br/> 이미 방문한 위치인지 확인 <br/> |     |

```
board := [][]byte{
    {'A', 'B', 'C', 'E'},
    {'S', 'F', 'C', 'S'},
    {'A', 'D', 'E', 'E'},
}
word := “ABCCED”
```
````
func exist(board [][]byte, word string) bool {
    rows, cols := len(board), len(board[0])
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if search(board, word, i, j, 0) {
                return true
            }
        }
    }
    return false
}

func search(board [][]byte, word string, row, col, index int) bool {
    if index == len(word) {
        return true
    }

    rows, cols := len(board), len(board[0])
    if row < 0 || col < 0 || row >= rows || col >= cols || board[row][col] != word[index] {
        return false
    }

    // 현재 셀을 방문한 셀로 표시
    temp := board[row][col]
    board[row][col] = '#'

    // 상하좌우 방향으로 이동하며 다음 셀로 검사
    if search(board, word, row-1, col, index+1) ||
       search(board, word, row+1, col, index+1) ||
       search(board, word, row, col-1, index+1) ||
       search(board, word, row, col+1, index+1) {
        return true
    }

    // 현재 셀의 방문 표시를 원래 값으로 복원
    board[row][col] = temp

    return false
}

```