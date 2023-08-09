___
### [2.1 회문인지 확인](https://leetcode.com/problems/valid-palindrome/submissions/)

|                |                          | (시간/공간)복잡도                                    |
|:----------------|-------------------------------|-----------------------------------------------|
|범위,제한사항|      | o(n) 문자열의 길이만큼 반복문을 수행                        |
|아이디어          | 아스키코드 알파벳소문자로 통일 <br/> 아스키코드 문자나,숫자일 경우만 분리 <br/> 문자열을 리버스해서 일치하는지 비교 <br/>  | o(n) 새로운 문자열 cleanedStr과 reversedStr을 만들기 때문에 |

```go
func isPalindrome(s string) bool {
  cleanedStr := ""
  for _, ch := range s {
    if unicode.IsLetter(ch) || unicode.IsDigit(ch) {
      cleanedStr += string(unicode.ToLower(ch))
    }
  }

  // 문자열을 리버스하여 비교합니다.
  reversedStr := ""
  for i := len(cleanedStr) - 1; i >= 0; i-- {
    reversedStr += string(cleanedStr[i])
  }

  return cleanedStr == reversedStr
}
```

- 회문(palindrome)은 앞으로 읽으나 뒤로 읽으나 동일한 문자열이 되는 단어, 문장, 또는 숫자를 의미합니다.
- 아스키코드(ASCII)
  - 숫자: 48부터 57까지 (0부터 9까지)
  - 소문자: 97부터 122까지 (a부터 z까지)
  - 대문자: 65부터 90까지 (A부터 Z까지)
```go
s := “GOLANG"
//[71 79 76 65 78 71]

for _, r := range s {
fmt.Printf("%c - %d\n", r, r)
//G - 71
//O - 79
}
```
- 공백제거
```go
sample := " This is a sample string   "
noSpaceString := strings.ReplaceAll(sample, " ", “")
```

### [2.2 그룹 에너그램](https://leetcode.com/problems/group-anagrams/)

|                |                                 |(시간/공간)복잡도                    |
|:----------------|---------------------------------|--------------------------|
|범위,제한사항| 문자열 리스트,리스트에 있는 모든 문자열은 소문자로 구성 | O(n log n) sort.Strings(s) 사용으로 |
|아이디어          |                                 | strings.Join(s, "")을 사용하여 문자열을 다시 합치는 작업도 시간과 메모리를 소모   |

```go
import "fmt"
import "sort"
func groupAnagrams(strs []string) [][]string {
    hashmap := make(map[string][]string)
    for _, str := range strs {
      s := strings.Split(str, "")
      sort.Strings(s)
      key := strings.Join(s, "")
       hashmap[key]  =append(hashmap[key],str)
      
    }

    list := make([][]string, 0, len(hashmap))

    for  _, value := range hashmap {
      list = append(list, value)
    }
    return list
}

```

>  에너그램은 두 단어가 같은 문자들로 이루어져 있지만, 서로 다른 순서로 배열되어 있을 때 발생
Ex) ”listen”과 "silent"은 에너그램

### [2.4 validIPAddress](https://leetcode.com/problems/validate-ip-address/)

|                |                                 | (시간/공간)복잡도                                            |
|:----------------|---------------------------------|-------------------------------------------------------|
|범위,제한사항| 문자열 리스트,리스트에 있는 모든 문자열은 소문자로 구성 | O(1)|                                                  |
|아이디어          |                                 | O(1) |

```go
func validIPAddress(queryIP string) string {
ipv4Pattern := `^(?:(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$`
	ipv6Pattern := `^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`
	if regexp.MustCompile(ipv4Pattern).MatchString(queryIP) {
		return "IPv4"
	} else if regexp.MustCompile(ipv6Pattern).MatchString(queryIP) {
		return "IPv6"
	}
return "Neither"
}
```

> 위 코드에서는 IPv4 패턴과 IPv6 패턴을 각각 정규식으로 컴파일하여 regexp.MatchString 함수를 통해 매치 여부를 확인합니다. 매치되는 패턴이 있을 경우에 해당하는 문자열("IPv4" 또는 "IPv6")을 반환

