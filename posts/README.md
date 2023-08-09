

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