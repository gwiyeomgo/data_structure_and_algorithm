# algorithm
자료구조,알고리즘 공부하고 내용을 정리하려고 합니다.

# 왜 필요?
데이터를 효과적으로 저장하고,처리하는 방법
자료구조를 이해하지 못하면 불필요하게 메모리와 성능을 낭비할 수 있다.

1. 선형 구조
   배열,연결 리스트,스택, 큐
3. 비선형 구조
   트리, 그래프

# 성능 측정 방법론?
1. 시간 복잡도 = 알고리즘에 사용되는 연산 횟수
2. 공간 복잡도 = 알고리즘에 사용되는 메모리의 양

효율적인 알고리즘을 사용한다고 가정했을때 시간과 공간은 반비례 관계

## - 시간복잡도를 표현할 때는 최악의 경우를 나타내는 Big-O 표기법 사용
최악의 경우를 기반으로 했을때 얼마나 소요가 될 거이다 라고 명시


O(n) 의 시간 복잡도 => 1차원 for문 어떠한 변수만큼 반복을 한다
O(n²)의 시간 복잡도 => 이중 for문 , n² 만큼 반복을 한다
O(1) 의 시간 복잡도 => a ,b 더해서 바로 출력

* 보통 연산 횟수가 10억을 넘어가면 1초 이상의 시간이 소요된다.
* 보통 시간 제한이 1초정도

## 공간 복잡도 표기는 일반적으로 MB 단위로 표기
int a[1000]:4KB
int a[1000000]:4MB

---

|번호 | 목차 |  진행|
|---|---|---|
| 01 | [List](./List.md)           | |
| 02 | [Stack](./Stack.md)         | |
| 03 | [Queue](./Queue.md)         | |
| 04 | [Sort](./Sort.md)           | |
| 05 | [Tree](./Tree.md)           | |
| 06 | [Search](./Search.md)       | |
| 07 | [Graph](./Graph.md)         | |
| 08 | [Heap](./Heap.md)           | |
| 09 | [HashTable](./HashTable.md) | |

https://github.com/WeareSoft/tech-interview

https://velog.io/@teo/%ED%94%84%EB%A1%A0%ED%8A%B8%EC%97%94%EB%93%9C-%EA%B0%9C%EB%B0%9C%EC%9E%90%EC%97%90%EA%B2%8C-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98-%EA%B3%B5%EB%B6%80%EA%B0%80-%EB%AF%B8%EC%B9%98%EB%8A%94-%EC%98%81%ED%96%A5




# 이론 기록

```
fmt.Printf("Enter  size  of  your  array: “)
var  size  int
fmt.Scanln(&size)
```
___
```
arr  :=  make([]int, 10)
for i:=0; i<size; i++ {
fmt.Printf("Enter %dth  element: ",  i)
fmt.Scanf("%d", &arr[i])
}
```
___
```
var n1, n2, n3, n4 int

fmt.Println("IPv4 주소")

fmt.Scanf("%d.%d.%d.%d", &n1, &n2, &n3, &n4)

//128.34.0.1
```
___
```
reader  :=  bufio.NewReader(os.Stdin)

fmt.Println("Simple  Shell")

fmt.Println("---------------------")

  

for {

fmt.Print("-> ")

text, _ :=  reader.ReadString('\n')

// convert  CRLF  to  LF

text = strings.Replace(text, "\n", "", -1)

  

if  strings.Compare("hi", text) ==  0 {

fmt.Println("hello, Yourself")

}

  

}
```
___
```
복잡도  Complexity

시간  복잡도 (빅오) => Big-O  표기법에서는  최악의  경우를  산정하여  보여주는  것



```
[https://www.bigocheatsheet.com/](https://www.bigocheatsheet.com/)
___
```
*가우스  덧셈

연속된  숫자의  합을  이용하여  빠르게  누락된  숫자를  찾는  방법

n := len(nums)

  

// 배열 내의 모든 숫자를 합하여 total_sum을 구합니다.

total_sum := 0

for _, num := range nums {

total_sum += num

}

  

// 0부터 n까지의 합을 구하는 공식을 사용하여 expected_sum을 계산합니다.

expected_sum := n * (n + 1) / 2

  

// 누락된  숫자를  계산합니다.

missing := expected_sum - total_sum
```
___

```
재귀(백트래킹)?

모든  경우의  수를  만들어서  원하는  조건에  맞는  결과를  찾아내는  과정

모든  조합이  필요한  경우
```