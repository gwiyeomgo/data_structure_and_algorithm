

# tip



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
for _, ch := range s {
    d := rune(ch) // 문자열
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
___
```
메모이제이션

같은 계산을 반복해야 할 때,이전에 계산한 값을 메모리에 저장함으로써 같은 계산의 반복 수행을 제거하는 방법
동적 계획법의 핵심이 되는 기술
=> 대표적인 예시 : 피보나치수열
```
___
```
brute force
모든경우의수를 찾음
```
https://school.programmers.co.kr/learn/courses/30/lessons/120805
# javascript

> 정수 num1, num2가 매개변수로 주어질 때, num1을 num2로 나눈 몫을 return 하도록 solution 함수를 완성해주세요.
function solution(num1, num2) {
// var answer = (num1- (num1 % num2))/num2

    return Math.floor(num1 / num2); //소수점 이하 버리기 몫만
}